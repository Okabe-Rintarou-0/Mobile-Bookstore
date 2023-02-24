package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"net/http"
	"strconv"
	"time"
)

func GetBookDetailsById(c *gin.Context) {
	var err error
	param := c.Param("id")
	var bookId int
	if bookId, err = strconv.Atoi(param); err != nil {
		c.JSON(http.StatusOK, message.Fail(message.NoSuchBook))
		return
	}

	c.JSON(http.StatusOK, service.GetBookDetailsById(uint32(bookId)))
}

func GetBookSnapshotById(c *gin.Context) {
	var err error
	param := c.Param("id")
	var bookId int
	if bookId, err = strconv.Atoi(param); err != nil {
		c.JSON(http.StatusOK, message.Fail(message.NoSuchBook))
		return
	}

	c.JSON(http.StatusOK, service.GetBookSnapshotById(uint32(bookId)))
}

func GetRangedBookSnapshots(c *gin.Context) {
	var err error
	startIdxParam := c.Query("start")
	endIdxParam := c.Query("end")
	var startIdx, endIdx int
	if startIdx, err = strconv.Atoi(startIdxParam); err != nil {
		c.JSON(http.StatusOK, message.Fail(message.NoSuchBook))
		return
	}

	if endIdx, err = strconv.Atoi(endIdxParam); err != nil {
		c.JSON(http.StatusOK, message.Fail(message.NoSuchBook))
		return
	}

	c.JSON(http.StatusOK, service.GetRangedBookSnapshots(uint32(startIdx), uint32(endIdx)))
}

func UploadBookComment(c *gin.Context) {
	var (
		err     error
		comment entity.Comment
		profile *entity.UserProfile
		bookId  int
		ok      bool
		data    []byte
	)
	param := c.Param("id")

	if bookId, err = strconv.Atoi(param); err != nil {
		goto fail
	}

	data, err = ioutil.ReadAll(c.Request.Body)
	defer c.Request.Body.Close()
	if err != nil {
		goto fail
	}

	profile, err = service.GetUserProfile(session.Manager.GetUsername(c.Request))
	if profile == nil || err != nil {
		goto fail
	}

	comment.Content = string(data)
	comment.Time = uint64(time.Now().UnixMilli())
	comment.Username = profile.Username

	ok, err = service.SaveBookComment(uint32(bookId), &comment)
	if !ok || err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func GetBookCommentsSnapshot(c *gin.Context) {
	var (
		err      error
		snapshot *entity.BookCommentsSnapshot
		bookId   int
	)

	param := c.Param("id")

	if bookId, err = strconv.Atoi(param); err != nil {
		goto fail
	}

	snapshot, err = service.GetBookCommentsSnapshot(uint32(bookId), session.Manager.GetUsername(c.Request))

	if snapshot == nil || err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed).WithPayload(snapshot))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}
