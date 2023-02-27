package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/spf13/cast"
	"net/http"
)

func AddToCart(c *gin.Context) {
	var (
		param  string
		bookId uint32
		err    error
		ok     bool
	)
	param = c.Param("id")
	if bookId, err = cast.ToUint32E(param); err != nil {
		goto fail
	}

	if ok, err = service.AddToCart(bookId, session.Manager.GetUserId(c.Request)); err != nil {
		goto fail
	}

	if !ok {
		c.JSON(http.StatusOK, message.Fail(message.AlreadyInCart))
		return
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	fmt.Println(err.Error())
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func GetUserCartItems(c *gin.Context) {
	var (
		err   error
		items []*entity.CartItemWithBook
	)
	items, err = service.GetAllUserCartItems(session.Manager.GetUserId(c.Request))
	if err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed).WithPayload(items))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func UpdateCartItemNumber(c *gin.Context) {
	var (
		err    error
		param1 string
		param2 string
		id     uint32
		number uint32
	)

	param1 = c.Param("id")
	if id, err = cast.ToUint32E(param1); err != nil {
		goto fail
	}

	param2 = c.Param("number")
	if number, err = cast.ToUint32E(param2); err != nil {
		goto fail
	}

	err = service.UpdateCartItemNumber(id, number)
	if err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func RemoveCartItem(c *gin.Context) {
	var (
		err   error
		param string
		id    uint32
	)

	param = c.Param("id")
	if id, err = cast.ToUint32E(param); err != nil {
		goto fail
	}

	err = service.RemoveCartItem(id)
	if err != nil {
		goto fail
	}

	c.JSON(http.StatusOK, message.Success(message.RequestSucceed))
	return
fail:
	fmt.Println(err.Error())
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}
