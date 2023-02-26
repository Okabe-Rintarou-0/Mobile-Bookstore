package controller

import (
	"bookstore-backend/entity"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"github.com/gin-gonic/gin"
	"log"
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
		return
	}

	var (
		err      error
		sess     session.Session
		username string
		password string
		result   *message.Response
		profile  *entity.UserProfile
	)

	username = c.PostForm("username")
	password = c.PostForm("password")
	result = service.Login(username, password)
	if !result.Success {
		goto finish
	}

	sess, err = session.Manager.NewSession(c.Writer, c.Request)
	if err != nil {
		goto fail
	}

	profile, err = service.GetUserProfile(username)
	if err != nil {
		goto fail
	}
	_ = sess.Set("username", username)
	_ = sess.Set("userId", profile.Id)
finish:
	c.JSON(http.StatusOK, result)
	return
fail:
	c.JSON(http.StatusOK, message.Fail(message.RequestFail))
}

func Logout(c *gin.Context) {
	if session.Manager.CheckSession(c.Request) {
		log.Println("Destroying session...")
		session.Manager.DestroySession(c.Writer, c.Request)
		c.JSON(http.StatusOK, message.Success(message.LogoutSucceed))
	} else {
		c.JSON(http.StatusOK, message.Fail(message.UserHasNotLoginYet))
	}
}
