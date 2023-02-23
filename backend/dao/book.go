package dao

import (
	"bookstore-backend/constants"
	"bookstore-backend/db/mongo"
	"bookstore-backend/db/mysql"
	"bookstore-backend/db/redis"
	"bookstore-backend/entity"
	"context"
	"encoding/json"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"strconv"
	"strings"
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
