package controller

import (
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

func LikeOrCancelLike(c *gin.Context) {
	commentId := c.Param("id")
	isLiked, err := service.LikeOrCancelLike(session.Manager.GetUsername(c.Request), commentId)
	if err != nil {
		log.Println(err.Error())
		c.JSON(http.StatusOK, message.Fail(message.RequestFail))
	} else {
		c.JSON(http.StatusOK, message.Success(message.RequestSucceed).WithPayload(isLiked))
	}
}

func GetIsLiked(c *gin.Context) {
	commentId := c.Param("id")
	isLiked, err := service.GetIsLiked(session.Manager.GetUsername(c.Request), commentId)
	if err != nil {
		log.Println(err.Error())
		c.JSON(http.StatusOK, message.Fail(message.RequestFail))
	} else {
		c.JSON(http.StatusOK, message.Success(message.RequestSucceed).WithPayload(isLiked))
	}
}
