package entity

import "encoding/json"

type UserAuth struct {
	Id       uint32 `json:"id"`
	Name     string `json:"name"`
	Password string `json:"password"`
	Email    string `json:"email"`
}

type User struct {
	Id       uint32 `json:"id"`
	AuthId   uint32 `json:"authId"`
	Username uint32 `json:"username"`
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`
}

type UserProfile struct {
	Id       uint32 `json:"id"`
	Username string `json:"username"`
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`
}

func (p *UserProfile) ToJsonString() string {
	marshalled, _ := json.Marshal(p)
	return string(marshalled)
}
