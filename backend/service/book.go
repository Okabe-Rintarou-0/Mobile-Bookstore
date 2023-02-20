package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/message"
)

func GetBookDetailsById(bookId uint32) *message.Response {
	details, err := dao.GetBookDetailsById(bookId)
	if err != nil {
		return message.Fail(err.Error())
	}

	return message.Success(message.RequestSucceed).WithPayload(details)
}

func GetBookSnapshotById(bookId uint32) *message.Response {
	snapshot, err := dao.GetBookSnapshotById(bookId)
	if err != nil {
		return message.Fail(err.Error())
	}

	return message.Success(message.RequestSucceed).WithPayload(snapshot)
}

func GetRangedBookSnapshots(startIdx, endIdx uint32) *message.Response {
	snapshots, err := dao.GetRangedBookSnapshots(startIdx, endIdx)
	if err != nil {
		return message.Fail(err.Error())
	}

	return message.Success(message.RequestSucceed).WithPayload(snapshots)
}
