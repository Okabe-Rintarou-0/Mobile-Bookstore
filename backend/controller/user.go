package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetUserProfile(c *gin.Context) {
	var (
		profile *entity.UserProfile
		err     error
		res     *message.Response
	)

	profile, err = service.GetUserProfile(session.Manager.GetUsername(c.Request))

	if profile == nil || err != nil {
		res = message.Fail(err.Error())
	} else {
		res = message.Success(message.RequestSucceed).WithPayload(profile)
	}

	c.JSON(http.StatusOK, res)
}
