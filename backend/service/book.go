package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/entity"
	"bookstore-backend/message"
)

func GetBookDetailsById(bookId uint32) *message.Response {
	var details *entity.BookDetails
	var err error

	if details, err = dao.GetBookDetailsFromRedisById(bookId); err != nil {
		goto fail
	} else if details != nil {
		goto succeed
	}

	if details, err = dao.GetBookDetailsById(bookId); err != nil {
		goto fail
	}

	_, _ = dao.SaveBookDetailsToRedis(details)

succeed:
	return message.Success(message.RequestSucceed).WithPayload(details)
fail:
	return message.Fail(err.Error())
}

func GetBookSnapshotById(bookId uint32) *message.Response {
	snapshot, err := dao.GetBookSnapshotById(bookId)
	if err != nil {
		return message.Fail(err.Error())
	}

	return message.Success(message.RequestSucceed).WithPayload(snapshot)
}

func GetRangedBookSnapshots(startIdx, endIdx uint32) *message.Response {
	var snapshots []*entity.BookSnapshot
	var err error

	if snapshots, err = dao.GetRangedBookSnapshotsFromRedis(startIdx, endIdx); err != nil {
		goto fail
	}

	if uint32(len(snapshots)) == endIdx-startIdx+1 {
		goto succeed
	}

	if snapshots, err = dao.GetRangedBookSnapshots(startIdx, endIdx); err != nil {
		goto fail
	}

	_, _ = dao.SaveRangedBookSnapshotsToRedis(snapshots)

succeed:
	return message.Success(message.RequestSucceed).WithPayload(snapshots)
fail:
	return message.Fail(err.Error())
}
