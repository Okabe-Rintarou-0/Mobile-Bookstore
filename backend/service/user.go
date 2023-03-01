package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/entity"
)

func GetUserProfile(username string) (*entity.UserProfile, error) {
	var (
		profile *entity.UserProfile
		err     error
	)

	if profile, err = dao.GetUserProfileFromRedis(username); err != nil {
		return nil, err
	} else if profile != nil {
		return profile, nil
	}

	if profile, err = dao.GetUserProfile(username); err != nil {
		return nil, err
	}

	if profile != nil {
		_, _ = dao.SaveUserProfileToRedis(profile)
	}
	return profile, nil
}

// UpdateUserAvatar avatarUrl should be like: "/static/xxx.png
func UpdateUserAvatar(username, avatarUrl string) (err error) {
	return dao.UpdateUserAvatar(username, avatarUrl)
}

func GetUserSavedAddresses(userId uint32) ([]string, error) {
	return dao.GetUserAddresses(userId)
}

func SaveUserAddress(userId uint32, addr string) (bool, error) {
	return dao.SaveUserAddress(userId, addr)
}
