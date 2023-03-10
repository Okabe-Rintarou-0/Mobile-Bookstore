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
	if _, err = stmt.Exec(avatarUrl, username); err == nil {
		_, _ = RemoveUserProfileCache(username)
	}
	return err
}

func GetUserAuthByUserName(username string) *entity.UserAuth {
	row := mysql.Db.QueryRow("select * from user_auth where name=?", username)
	var auth entity.UserAuth
	if err := row.Scan(&auth.Id, &auth.Name, &auth.Password, &auth.Email); err != nil {
		log.Println(err.Error())
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
	result, err := mysql.Db.Exec("insert into user_auth (name, password, email) values(?,?,?)", username, password, email)
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
	_, err := mysql.Db.Exec("insert into `user`(auth, username, nickname, avatar) values(?,?,?,?)", auth, username, nickname, avatar)
	return err
}

func GetUserAddresses(userId uint32) ([]*entity.AddressInfo, error) {
	var (
		addresses []*entity.AddressInfo
		err       error
		rows      *sql.Rows
	)

	rows, err = mysql.Db.Query("select a.id, address, name, tel, is_default from  user_address_record u join address_tbl a on u.addr_id = a.id where u.user_id = ?", userId)
	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var addr entity.AddressInfo
		if err = rows.Scan(&addr.Id, &addr.Address, &addr.Name, &addr.Tel, &addr.IsDefault); err != nil {
			return nil, err
		}
		addresses = append(addresses, &addr)
	}

	err = rows.Close()
	return addresses, err
}

func CountUserAddresses(userId uint32) (uint32, error) {
	var (
		count uint32 = 0
		err   error
		row   *sql.Row
	)
	row = mysql.Db.QueryRow("select COUNT(*) from user_address_record where user_id = ?", userId)

	err = row.Scan(&count)
	return count, err
}

func ChangeUserDefaultAddress(oldId int32, newId uint32) error {
	var err error
	err = mysql.Transact(func(tx *sql.Tx) error {
		if oldId > 0 {
			_, err = tx.Exec("update address_tbl a set is_default=false where a.id = ?", oldId)
			if err != nil {
				return err
			}
		}

		_, err = tx.Exec("update address_tbl a set is_default=true where a.id = ?", newId)
		return err
	})

	return err
}

func SaveUserAddress(userId uint32, addr *entity.AddressInfo) (bool, error) {
	var (
		count uint32
		err   error
	)

	if count, err = CountUserAddresses(userId); err != nil {
		return false, err
	}

	if count >= 5 {
		return false, nil
	}

	if count == 0 {
		addr.IsDefault = true
	}

	err = mysql.Transact(func(tx *sql.Tx) error {
		var (
			result sql.Result
			addrId int64
		)
		result, err = tx.Exec("insert into address_tbl(address, name, tel, is_default) values(?,?,?,?)", addr.Address, addr.Name, addr.Tel, addr.IsDefault)
		if err != nil {
			return err
		}
		if addrId, err = result.LastInsertId(); err != nil {
			return err
		}

		_, err = tx.Exec("insert into user_address_record(user_id, addr_id) values(?,?)", userId, addrId)
		return err
	})
	if err != nil {
		return false, err
	}

	return true, nil
}

func DeleteUserAddress(addrId uint32) error {
	var err error

	err = mysql.Transact(func(tx *sql.Tx) error {
		_, err = tx.Exec("delete from user_address_record u where u.addr_id = ?", addrId)
		if err != nil {
			return err
		}

		_, err = tx.Exec("delete from address_tbl a where a.id = ?", addrId)
		return err
	})
	return err
}
