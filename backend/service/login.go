package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/message"
)

func Login(username, password string) *message.Response {
	if auth := dao.GetUserAuthByUserName(username); auth != nil {
		if auth.Password == password {
			return message.Success(message.LoginSucceed)
		} else {
			return message.Fail(message.WrongPassword)
		}
	}

	return message.Fail(message.NonExistentUser)
}
