package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/db/redis"
	"bookstore-backend/entity"
	"database/sql"
	"log"
)

func GetIsLiked(username, commentId string) (bool, error) {
	var (
		isLiked bool
		exists  bool
		err     error
	)
	if isLiked, exists, err = dao.CheckIsLikedFromRedis(username, commentId); err != nil && err != redis.Nil {
		return false, err
	}

	//log.Printf("from redis: isLiked?: %v, exists?: %v, err: %+v", isLiked, exists, err)

	// if it does not exist, fetch from db and cache it in redis
	if !exists {
		isLiked, err = dao.CheckIsLiked(username, commentId)
		if err != nil {
			if err != sql.ErrNoRows {
				return false, err
			} else {
				return false, nil
			}
		}
		_ = dao.SaveLikeRecordToRedis(username, commentId, isLiked)
	}

	return isLiked, err
}

// LikeOrCancelLike returns (isLiked?, error?)
func LikeOrCancelLike(username, commentId string) (bool, error) {
	var (
		isLiked bool
		exists  bool
		err     error
	)
	if isLiked, exists, err = dao.CheckIsLikedFromRedis(username, commentId); err != nil && err != redis.Nil {
		return false, err
	}

	//log.Printf("Check is liked from redis, result is (isLiked?: %v, exists?: %v, error?: %+v)\n", isLiked, exists, err)

	// if it does not exist, fetch from db and cache it in redis
	if !exists {
		isLiked, err = dao.CheckIsLiked(username, commentId)
		//log.Printf("Check is liked from db, result is (isLiked?: %v, error?: %+v)\n", isLiked, err)
		if err != nil && err != sql.ErrNoRows {
			return false, err
		}
	}

	err = dao.ToggleLike(username, commentId, isLiked)

	return !isLiked, err
}

func SaveBookComment(bookId uint32, comment *entity.Comment) (bool, error) {
	return dao.SaveBookComment(bookId, comment)
}

func GetBookCommentsSnapshot(bookId uint32, username string) (*entity.BookCommentsSnapshot, error) {
	var (
		snapshot *entity.BookCommentsSnapshot
		err      error
	)
	if snapshot, err = dao.GetBookCommentsSnapshot(bookId); snapshot == nil || err != nil {
		return nil, err
	}

	for _, c := range snapshot.HotComments {
		if c.IsLiked, err = GetIsLiked(username, c.Id.Hex()); err != nil {
			return nil, err
		}
		log.Printf("%s isLiked?: %v\n", c.Id, c.IsLiked)
	}

	return snapshot, nil
}
