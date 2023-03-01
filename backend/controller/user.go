package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"fmt"
	"github.com/gin-gonic/gin"
	"io/ioutil"
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

func SaveUserAddress(c *gin.Context) {
	var (
		succeed bool
		err     error
		body    []byte
		addr    string
	)

	defer c.Request.Body.Close()
	if body, err = ioutil.ReadAll(c.Request.Body); err != nil {
		goto fail
	}

	addr = string(body)

	succeed, err = service.SaveUserAddress(session.Manager.GetUserId(c.Request), addr)
	if err != nil || !succeed {
		goto fail
	}
	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	fmt.Println(err.Error())
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func GetUserSavedAddresses(c *gin.Context) {
	var (
		err       error
		addresses []string
	)
	addresses, err = service.GetUserSavedAddresses(session.Manager.GetUserId(c.Request))
	if err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed).WithPayload(addresses))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}
