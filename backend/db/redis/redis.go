package redis

import (
	"bookstore-backend/config"
	"fmt"
	"github.com/go-redis/redis/v8"
)

var Cli *redis.Client

const Nil = redis.Nil

type Z = redis.Z

func init() {
	cfg := config.Global.Redis
	Cli = redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:%d", cfg.Host, cfg.Port),
		Username: cfg.Username,
		Password: cfg.Password,
		DB:       cfg.Db,
	})
}
