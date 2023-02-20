package controller

import (
	"bookstore-backend/message"
	"bookstore-backend/service"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
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
