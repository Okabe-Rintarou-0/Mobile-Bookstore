package dao

import (
	"bookstore-backend/constants"
	"bookstore-backend/db/mysql"
	"bookstore-backend/db/redis"
	"bookstore-backend/entity"
	"context"
	"database/sql"
	"encoding/json"
	"log"
)

func RemoveUserProfileCache(username string) (bool, error) {
	ctx := context.Background()
	cmd := redis.Cli.HDel(ctx, constants.UserProfilesKey, username)
	cnt, err := cmd.Uint64()
	return cnt == 1, err
}

func UpdateUserAvatar(username, avatarUrl string) error {
	stmt, err := mysql.Db.Prepare("update user set avatar = ? where username = ?")
	if err != nil {
		return err
	}
	log.Println(avatarUrl)
	if _, err = stmt.Exec(avatarUrl, username); err == nil {
		_, _ = RemoveUserProfileCache(username)
	}
	return err
}

func GetUserAuthByUserName(username string) *entity.UserAuth {
	row := mysql.Db.QueryRow("select * from user_auth where name=?", username)
	var auth entity.UserAuth
	if err := row.Scan(&auth.Id, &auth.Name, &auth.Password, &auth.Email); err != nil {
		return nil
	}
	return &auth
}

func GetUserProfileFromRedis(username string) (*entity.UserProfile, error) {
	ctx := context.Background()
	var profile entity.UserProfile
	cmd := redis.Cli.HGet(ctx, constants.UserProfilesKey, username)
	if result, err := cmd.Result(); err != nil {
		if err == redis.Nil {
			return nil, nil
		} else {
			return nil, err
		}
	} else {
		if err = json.Unmarshal([]byte(result), &profile); err != nil {
			return nil, err
		}
		return &profile, nil
	}
}

func SaveUserProfileToRedis(profile *entity.UserProfile) (bool, error) {
	ctx := context.Background()
	cmd := redis.Cli.HSet(ctx, constants.UserProfilesKey, profile.Username, profile.ToJsonString())
	cnt, err := cmd.Uint64()
	return cnt == 1, err
}

func GetUserProfile(username string) (*entity.UserProfile, error) {
	var p entity.UserProfile
	var err error
	row := mysql.Db.QueryRow("select id, username, nickname, avatar from user where user.username = ?", username)
	if err = row.Scan(&p.Id, &p.Username, &p.Nickname, &p.Avatar); err != nil {
		return nil, err
	}
	return &p, nil
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

func SetUser(auth uint, username, nickname, avatar string) error {
	stmt, err := mysql.Db.Prepare("insert into `user`(auth, username, nickname, avatar) values(?,?,?,?)")
	if err != nil {
		return err
	}

	_, err = stmt.Exec(auth, username, nickname, avatar)
	return err
}
