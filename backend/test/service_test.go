package test

import (
	"bookstore-backend/message"
	"bookstore-backend/service"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestService(t *testing.T) {
	result := service.Login("okabe", "123456")
	assert.Equal(t, message.LoginSucceed, result)

	result = service.Login("okabe2", "123456")
	assert.Equal(t, message.NonExistentUser, result)

	result = service.Login("okabe", "1234567")
	assert.Equal(t, message.WrongPassword, result)
}
