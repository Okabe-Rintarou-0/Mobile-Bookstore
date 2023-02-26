package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
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
