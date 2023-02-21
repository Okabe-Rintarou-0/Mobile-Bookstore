package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/entity"
	"bookstore-backend/message"
)

func GetUserProfile(username string) *message.Response {
	var profile *entity.UserProfile
	var err error

	if profile, err = dao.GetUserProfileFromRedis(username); err != nil {
		goto fail
	} else if profile != nil {
		goto succeed
	}

	if profile, err = dao.GetUserProfile(username); err != nil {
		goto fail
	}

	_, _ = dao.SaveUserProfileToRedis(profile)

succeed:
	return message.Success(message.RequestSucceed).WithPayload(profile)
fail:
	return message.Fail(err.Error())
}

// UpdateUserAvatar avatarUrl should be like: "/static/xxx.png
func UpdateUserAvatar(username, avatarUrl string) (err error) {
	return dao.UpdateUserAvatar(username, avatarUrl)
}
