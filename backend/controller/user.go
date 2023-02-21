package controller

import (
	"bookstore-backend/service"
	"bookstore-backend/session"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetUserProfile(c *gin.Context) {
	c.JSON(http.StatusOK, service.GetUserProfile(session.Manager.GetUsername(c.Request)))
}
