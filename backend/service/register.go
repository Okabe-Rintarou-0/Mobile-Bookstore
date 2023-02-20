package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/db/mysql"
	"bookstore-backend/message"
	"fmt"
	"github.com/dlclark/regexp2"
	"regexp"
	"unicode/utf8"
)

var (
	usernameRegex *regexp.Regexp
	emailRegex    *regexp.Regexp
	passwordRegex *regexp2.Regexp
)

func init() {
	usernameRegex, _ = regexp.Compile("[0-9a-zA-Z]{1,15}")
	emailRegex, _ = regexp.Compile("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$")
	passwordRegex, _ = regexp2.Compile("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$", regexp2.None)
}

func checkRegisterParams(username, nickname, email, password string) (message.RegisterResult, bool) {
	if !usernameRegex.MatchString(username) {
		return message.InvalidUsername, false
	}

	if !emailRegex.MatchString(email) {
		return message.InvalidEmail, false
	}

	if ok, err := passwordRegex.MatchString(password); !ok || err != nil {
		return message.InvalidPassword, false
	}

	if count := utf8.RuneCountInString(nickname); count > 15 || count < 1 {
		return message.InvalidNickname, false
	}

	return "", true
}

func Register(username, nickname, email, password string) (*message.Response, error) {
	if auth := dao.GetUserAuthByUserName(username); auth == nil {
		if errorMsg, ok := checkRegisterParams(username, nickname, email, password); !ok {
			return message.Fail(errorMsg), nil
		}

		tx, err := mysql.Db.Begin()
		var authId uint
		if err != nil && tx != nil {
			fmt.Printf("begin trans failed, err:%v\n", err)
			goto Rollback
		}

		if authId, err = dao.SetUserAuth(username, email, password); err != nil {
			fmt.Printf("begin trans failed, err:%v\n", err)
			goto Rollback
		}

		if err = dao.SetUser(authId, nickname); err != nil {
			fmt.Printf("begin trans failed, err:%v\n", err)
			goto Rollback
		}

		if err = tx.Commit(); err == nil {
			return message.Success(message.RegisterSucceed), nil
		} else {
			fmt.Printf("begin trans failed, err:%v\n", err)
			goto Rollback
		}

	Rollback:
		_ = tx.Rollback()
		return nil, err
	} else {
		return message.Fail(message.UserExists), nil
	}
}
