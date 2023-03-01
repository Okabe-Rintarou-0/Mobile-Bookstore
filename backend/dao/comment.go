package dao

import (
	"bookstore-backend/constants"
	"bookstore-backend/db/mongo"
	"bookstore-backend/db/mysql"
	"bookstore-backend/db/redis"
	"bookstore-backend/entity"
	"context"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"log"
	"strconv"
)

func UpdateCommentLike(commentId string, increment int) error {
	ctx := context.Background()
	objID, err := primitive.ObjectIDFromHex(commentId)
	if err != nil {
		return err
	}
	filter := bson.D{{"_id", objID}}
	update := bson.D{{"$inc", bson.D{{"like", increment}}}}

	_, err = mongo.Cli.Database(constants.BookStoreMongoDbName).
		Collection(constants.CommentsMongoCollectionName).
		UpdateOne(ctx, filter, update)
	return err
}

func SaveLikeRecordToRedis(username, commentId string, isLiked bool) error {
	var (
		val         = 1
		ctx         = context.Background()
		err         error
		usernameKey string
	)
	if !isLiked {
		val = 0
	}

	usernameKey = fmt.Sprintf("username:like:%s", username)
	cmd := redis.Cli.HSet(ctx, usernameKey, commentId, val)
	_, err = cmd.Result()
	return err
}

func ToggleLike(username, commentId string, isLiked bool) error {
	var (
		val         = 1
		increment   = 1
		ctx         = context.Background()
		err         error
		usernameKey string
	)
	if isLiked {
		val = 0
		increment = -1
	}

	log.Printf("according to isLiked: %v, val should be %v, while increment should be %v\n", isLiked, val, increment)

	if err = UpdateCommentLike(commentId, increment); err != nil {
		return err
	}

	usernameKey = fmt.Sprintf("username:like:%s", username)
	cmd := redis.Cli.HSet(ctx, usernameKey, commentId, val)
	_, err = cmd.Result()
	return err
}

func DumpLikeRecordToDb() error {
	var (
		err     error
		ctx     = context.Background()
		keys    []string
		results map[string]string
		isLiked int
	)

	cmd := redis.Cli.Keys(ctx, "username:like:*")
	if keys, err = cmd.Result(); err != nil {
		return err
	}

	for _, key := range keys {
		commentCmd := redis.Cli.HGetAll(ctx, key)
		if results, err = commentCmd.Result(); err != nil {
			return err
		}
		for commentId, val := range results {
			r := &entity.LikeRecord{
				Username:  key[14:],
				CommentId: commentId,
			}
			if isLiked, err = strconv.Atoi(val); err != nil || isLiked <= 0 {
				//log.Printf("Removing like record: %+v...\n", r)
				_ = RemoveLikeRecord(r)
			} else if isLiked > 0 {
				liked, _ := CheckIsLiked(r.Username, r.CommentId)
				if !liked {
					//log.Printf("Saving like record: %+v...\n", r)
					_ = SaveLikeRecord(r)
				}
			}
		}
	}
	return nil
}

// CheckIsLikedFromRedis returns (isLiked, exists, error)
func CheckIsLikedFromRedis(username, commentId string) (bool, bool, error) {
	var (
		err     error
		ctx     = context.Background()
		result  string
		isLiked int
	)

	usernameKey := fmt.Sprintf("username:like:%s", username)
	cmd := redis.Cli.HGet(ctx, usernameKey, commentId)
	if result, err = cmd.Result(); err != nil {
		return false, false, err
	}

	if isLiked, err = strconv.Atoi(result); err != nil {
		return false, false, err
	}

	return isLiked > 0, true, nil
}

// CheckIsLiked no needs to return "exists", for if is liked, it exists, otherwise it does not exist in like_tbl
func CheckIsLiked(username, commentId string) (bool, error) {
	var (
		r   entity.LikeRecord
		err error
	)

	row := mysql.Db.QueryRow("select username, comment_id from like_tbl where username = ? and comment_id = ?", username, commentId)
	if err = row.Scan(&r.Username, &r.CommentId); err != nil {
		return false, err
	}
	return true, nil
}

func SaveLikeRecord(record *entity.LikeRecord) error {
	var err error
	_, err = mysql.Db.Exec("insert into like_tbl (username, comment_id) value (?, ?)", record.Username, record.CommentId)
	return err
}

func RemoveLikeRecord(record *entity.LikeRecord) error {
	var err error
	_, err = mysql.Db.Exec("delete from like_tbl where username = ? and comment_id = ?", record.Username, record.CommentId)
	return err
}

func GetBookCommentsSnapshot(bookId uint32) (*entity.BookCommentsSnapshot, error) {
	var (
		bc        *entity.BookComments
		comment   *entity.Comment
		profile   *entity.UserProfile
		snapshot  entity.BookCommentsSnapshot
		err       error
		num       = 3
		commentId primitive.ObjectID
	)

	if bc, err = GetBookCommentsById(bookId); bc == nil || err != nil {
		return nil, err
	}

	if len(bc.CommentIds) < 3 {
		num = len(bc.CommentIds)
	}

	snapshot.NumComments = uint32(len(bc.CommentIds))
	for i := 0; i < num; i++ {
		commentId = bc.CommentIds[i]
		if comment, err = GetCommentById(commentId); comment == nil || err != nil {
			return nil, err
		}

		if profile, err = GetUserProfile(comment.Username); profile == nil || err != nil {
			return nil, err
		}

		snapshot.HotComments = append(snapshot.HotComments, &entity.CommentWithUserProfile{
			Comment:  comment,
			Nickname: profile.Nickname,
			Avatar:   profile.Avatar,
		})
	}
	return &snapshot, nil
}

func GetCommentById(id primitive.ObjectID) (*entity.Comment, error) {
	var (
		ctx     = context.Background()
		comment entity.Comment
		err     error
	)
	cur, err := mongo.Cli.Database(constants.BookStoreMongoDbName).
		Collection(constants.CommentsMongoCollectionName).
		Find(ctx, bson.D{{"_id", id}})

	if err != nil {
		return nil, err
	}

	if cur.Next(ctx) {
		err = cur.Decode(&comment)
		if err != nil {
			return nil, err
		}
		return &comment, nil
	}
	return nil, nil
}

func SaveBookComment(bookId uint32, comment *entity.Comment) (bool, error) {
	var (
		ctx = context.Background()
		bc  *entity.BookComments
		err error
	)

	if bc, err = GetBookCommentsById(bookId); bc == nil || err != nil {
		return false, err
	}

	insertRes, err := mongo.Cli.Database(constants.BookStoreMongoDbName).
		Collection(constants.CommentsMongoCollectionName).
		InsertOne(ctx, comment)

	var (
		commentId primitive.ObjectID
		ok        bool
	)

	if commentId, ok = insertRes.InsertedID.(primitive.ObjectID); !ok {
		return false, nil
	}

	if err != nil {
		return false, err
	}

	bc.CommentIds = append(bc.CommentIds, commentId)

	filter := bson.D{{"_id", bc.Id}}
	update := bson.D{{"$set", bson.D{{"commentIds", bc.CommentIds}}}}

	updateRes, err := mongo.Cli.Database(constants.BookStoreMongoDbName).
		Collection(constants.BookCommentsMongoCollectionName).
		UpdateOne(ctx, filter, update)
	if err != nil {
		return false, err
	}

	return updateRes.ModifiedCount == 1, nil
}
