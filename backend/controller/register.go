package controller

import (
	"bookstore-backend/service"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

func Register(c *gin.Context) {
	username := c.PostForm("username")
	nickname := c.PostForm("nickname")
	email := c.PostForm("email")
	password := c.PostForm("password")
	if response, err := service.Register(username, nickname, email, password); err == nil {
		c.JSON(http.StatusOK, response)
	} else {
		fmt.Println(err)
		_ = c.Error(fmt.Errorf("internal error"))
	}
}
