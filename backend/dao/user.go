package dao

import (
	"bookstore-backend/db/mysql"
	"bookstore-backend/entity"
	"database/sql"
)

func GetUserAuthByUserName(username string) *entity.UserAuth {
	row := mysql.Db.QueryRow("select * from user_auth where name=?", username)
	var auth entity.UserAuth
	if err := row.Scan(&auth.Id, &auth.Name, &auth.Password, &auth.Email); err != nil {
		return nil
	}
	return &auth
}

func SetUserAuth(username, email, password string) (uint, error) {
	stmt, err := mysql.Db.Prepare("insert into user_auth (name, password, email) values(?,?,?)")
	if err != nil {
		return 0, err
	}

	var result sql.Result
	result, err = stmt.Exec(username, password, email)
	if err != nil {
		return 0, err
	}

	var authId int64
	authId, err = result.LastInsertId()
	if err != nil {
		return 0, err
	}

	return uint(authId), nil
}

func SetUser(auth uint, nickname string) error {
	stmt, err := mysql.Db.Prepare("insert into `user`(auth, nickname) values(?,?)")
	if err != nil {
		return err
	}

	_, err = stmt.Exec(auth, nickname)
	return err
}
