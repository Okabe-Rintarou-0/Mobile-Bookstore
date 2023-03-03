package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/spf13/cast"
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
		addr    entity.AddressInfo
	)

	defer c.Request.Body.Close()
	decoder := json.NewDecoder(c.Request.Body)
	if err = decoder.Decode(&addr); err != nil {
		goto fail
	}

	succeed, err = service.SaveUserAddress(session.Manager.GetUserId(c.Request), &addr)
	if err != nil || !succeed {
		goto fail
	}
	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func GetUserSavedAddresses(c *gin.Context) {
	var (
		err       error
		addresses []*entity.AddressInfo
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

func ChangeUserDefaultAddress(c *gin.Context) {
	var (
		err    error
		ok     bool
		oldId  int32
		newId  uint32
		body   map[string]interface{}
		param1 interface{}
		param2 interface{}
	)

	defer c.Request.Body.Close()
	d := json.NewDecoder(c.Request.Body)
	if err = d.Decode(&body); err != nil {
		goto fail
	}

	if param1, ok = body["oldId"]; !ok {
		goto fail
	}

	if param2, ok = body["newId"]; !ok {
		goto fail
	}

	if oldId, err = cast.ToInt32E(param1); err != nil {
		goto fail
	}

	if newId, err = cast.ToUint32E(param2); err != nil {
		goto fail
	}

	if err = service.ChangeUserDefaultAddress(oldId, newId); err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	fmt.Println(err.Error())
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func DeleteUserAddress(c *gin.Context) {
	var (
		err    error
		param  string
		addrId uint32
	)
	param = c.Param("id")

	if addrId, err = cast.ToUint32E(param); err != nil {
		goto fail
	}

	if err = service.DeleteUserAddress(addrId); err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	fmt.Println(err.Error())
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}
