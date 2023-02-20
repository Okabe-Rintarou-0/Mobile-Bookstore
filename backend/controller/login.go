package controller

import (
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

func CheckSession(c *gin.Context) {
	resp := message.Response{
		Success: session.Manager.CheckSession(c.Request),
	}
	c.JSON(http.StatusOK, resp)
}

func Login(c *gin.Context) {
	if session.Manager.CheckSession(c.Request) {
		c.JSON(http.StatusOK, message.Response{
			Success: true,
			Message: message.AlreadyLogin,
			Err:     "",
		})
	} else {
		username := c.PostForm("username")
		password := c.PostForm("password")
		result := service.Login(username, password)
		if result.Success {
			if sess, err := session.Manager.NewSession(c.Writer, c.Request); err == nil {
				_ = sess.Set("username", username)
			} else {
				fmt.Println(err)
				_ = c.Error(fmt.Errorf("internal error"))
				return
			}
		}
		c.JSON(http.StatusOK, result)
	}
}
