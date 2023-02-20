package test

import (
	"bookstore-backend/dao"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestGetUserAuthByUserName(t *testing.T) {
	userAuth := dao.GetUserAuthByUserName("okabe")
	assert.NotNil(t, userAuth)

	userAuth = dao.GetUserAuthByUserName("123")
	assert.Nil(t, userAuth)
}
