package dao

import (
	"bookstore-backend/constants"
	"bookstore-backend/db/elasticsearch"
	"bookstore-backend/db/mongo"
	"bookstore-backend/db/mysql"
	"bookstore-backend/db/redis"
	"bookstore-backend/entity"
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"github.com/elastic/go-elasticsearch/v8/esapi"
	"github.com/olivere/elastic/v7"
	"go.mongodb.org/mongo-driver/bson"
	"strconv"
	"strings"
)

const (
	bookQueryTemplate = `{
	"query": {
		"bool": {
			"should": [
			    {"match": {"title": "%s"}},
			    {"match": {"author": "%s"}}
		    ]
		}
	},
	"from": %d,
	"size": %d
}`
)

func GetBookDetailsById(bookId uint32) (*entity.BookDetails, error) {
	var covers string
	var d entity.BookDetails
	err := mysql.Db.QueryRow("select id, covers, title, author, price, orgPrice, sales from book where book.id = ?", bookId).
		Scan(&d.Id, &covers, &d.Title, &d.Author, &d.Price, &d.OrgPrice, &d.Sales)

	d.Covers = strings.Split(covers, " ")

	return &d, err
}

func SaveBookDetailsToRedis(details *entity.BookDetails) (bool, error) {
	ctx := context.Background()
	cmd := redis.Cli.HSet(ctx, constants.BookDetailsKey, strconv.Itoa(int(details.Id)), details.ToJsonString())
	retVal, err := cmd.Result()
	return retVal == 1, err
}

func GetBookDetailsFromRedisById(bookId uint32) (*entity.BookDetails, error) {
	ctx := context.Background()
	var d entity.BookDetails
	cmd := redis.Cli.HGet(ctx, constants.BookDetailsKey, strconv.Itoa(int(bookId)))
	if result, err := cmd.Result(); err != nil {
		return nil, err
	} else {
		if err = json.Unmarshal([]byte(result), &d); err != nil {
			return nil, err
		}
		return &d, nil
	}
}

func GetBookSnapshotById(bookId uint32) (*entity.BookSnapshot, error) {
	var covers string
	var s entity.BookSnapshot
	err := mysql.Db.QueryRow("select id, covers, title, author, price, sales from book where book.id = ?", bookId).
		Scan(&s.Id, &covers, &s.Title, &s.Author, &s.Price, &s.Sales)

	blankIdx := strings.Index(covers, " ")
	if blankIdx != -1 {
		s.Cover = covers[:blankIdx]
	} else {
		s.Cover = covers
	}

	return &s, err
}

func SaveRangedBookSnapshotsToRedis(snapshots []*entity.BookSnapshot) (bool, error) {
	if len(snapshots) == 0 {
		return true, nil
	}

	ctx := context.Background()
	var zs []*redis.Z
	for _, s := range snapshots {
		zs = append(zs, &redis.Z{
			Score:  float64(s.Id),
			Member: s.ToJsonString(),
		})
	}
	cmd := redis.Cli.ZAdd(ctx, constants.BookSnapshotsKey, zs...)
	retVal, err := cmd.Result()
	return retVal == int64(len(snapshots)), err
}

func GetRangedBookSnapshotsFromRedis(startIdx, endIdx uint32) ([]*entity.BookSnapshot, error) {
	ctx := context.Background()
	var snapshots []*entity.BookSnapshot
	cmd := redis.Cli.ZRange(ctx, constants.BookSnapshotsKey, int64(startIdx-1), int64(endIdx))
	if results, err := cmd.Result(); err != nil {
		return nil, err
	} else {
		if len(results) > 0 {
			for _, result := range results {
				var s entity.BookSnapshot
				if err = json.Unmarshal([]byte(result), &s); err != nil {
					return nil, err
				} else {
					snapshots = append(snapshots, &s)
				}
			}
			return snapshots, err
		}
		return nil, nil
	}
}

func GetRangedBookSnapshots(startIdx, endIdx uint32) ([]*entity.BookSnapshot, error) {
	if startIdx > endIdx {
		return nil, fmt.Errorf("startIdx should less equal to endIdx")
	}
	var snapshots []*entity.BookSnapshot
	rows, err := mysql.Db.Query("select id, covers, title, author, price, sales from book where book.id >= ? and book.id <= ?", startIdx, endIdx)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var covers string
		var s entity.BookSnapshot
		if err = rows.Scan(&s.Id, &covers, &s.Title, &s.Author, &s.Price, &s.Sales); err != nil {
			return nil, err
		}

		blankIdx := strings.Index(covers, " ")
		if blankIdx != -1 {
			s.Cover = covers[:blankIdx]
		} else {
			s.Cover = covers
		}

		snapshots = append(snapshots, &s)
	}

	return snapshots, err
}

func GetBookCommentsById(bookId uint32) (*entity.BookComments, error) {
	var comments entity.BookComments
	ctx := context.Background()
	cur, err := mongo.Cli.Database(constants.BookStoreMongoDbName).
		Collection(constants.BookCommentsMongoCollectionName).
		Find(ctx, bson.D{{"bookId", bookId}})

	if err != nil {
		return nil, err
	}

	if cur.Next(ctx) {
		err = cur.Decode(&comments)
		if err != nil {
			return nil, err
		}
		return &comments, nil
	}
	return nil, nil
}

func DumpBookDocumentToElasticSearch() error {
	const eachPick = 20
	var (
		curIdx    uint32 = 1
		err       error
		data      []byte
		snapshots []*entity.BookSnapshot
		body      *bytes.Buffer
	)

	for true {
		snapshots, err = GetRangedBookSnapshots(curIdx, curIdx+eachPick-1)
		if err != nil {
			return err
		}

		body = &bytes.Buffer{}
		for _, snapshot := range snapshots {
			meta := []byte(fmt.Sprintf(`{ "index" : { "_id" : "%d" } }%s`, snapshot.Id, "\n"))
			data, err = json.Marshal(snapshot)
			data = append(data, "\n"...)
			body.Grow(len(meta) + len(data))
			body.Write(meta)
			body.Write(data)
		}

		_, err = elasticsearch.Cli.Bulk(body, elasticsearch.Cli.Bulk.WithIndex("book"))

		if err != nil {
			return err
		}

		if len(snapshots) < eachPick {
			break
		}

		curIdx += eachPick
	}
	return nil
}

func SearchBook(keyword string, startIdx, endIdx uint64) ([]*entity.BookSnapshot, error) {
	var (
		r         *elastic.SearchResult
		err       error
		response  *esapi.Response
		body      *bytes.Buffer
		size      = endIdx - startIdx + 1
		snapshots []*entity.BookSnapshot
	)

	body = &bytes.Buffer{}
	body.WriteString(fmt.Sprintf(bookQueryTemplate, keyword, keyword, startIdx, size))
	response, err = elasticsearch.Cli.Search(elasticsearch.Cli.Search.WithIndex("book"), elasticsearch.Cli.Search.WithBody(body), elasticsearch.Cli.Search.WithPretty())
	if err != nil {
		return nil, err
	}

	defer response.Body.Close()
	if err = json.NewDecoder(response.Body).Decode(&r); err != nil {
		return nil, err
	}

	if r.Hits == nil || len(r.Hits.Hits) == 0 {
		return nil, nil
	}

	for _, hitResult := range r.Hits.Hits {
		var snapshot entity.BookSnapshot
		if err = json.Unmarshal(hitResult.Source, &snapshot); err != nil {
			return nil, err
		}
		snapshots = append(snapshots, &snapshot)
	}

	return snapshots, nil
}
