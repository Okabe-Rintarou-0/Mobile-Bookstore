package mongo

import (
	"bookstore-backend/config"
	"context"
	"fmt"
	db "go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"time"
)

var Cli *db.Client

func init() {
	cfg := config.Global.Mongo

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var err error

	opt := options.Client().ApplyURI(fmt.Sprintf("mongodb://%s:%d", cfg.Host, cfg.Port))
	if len(cfg.Username) > 0 && len(cfg.Password) > 0 {
		credential := options.Credential{
			Username: cfg.Username,
			Password: cfg.Password,
		}
		opt.SetAuth(credential)
	}
	Cli, err = db.Connect(ctx, opt)
	if err != nil {
		panic(err)
	}

	//bc := &entity.BookComments{}
	//cur, err := Cli.Database(constants.BookStoreMongoDbName).
	//	Collection(constants.BookCommentsMongoCollectionName).
	//	Find(ctx, bson.D{{"id", 1}})
	//cur.Next(ctx)
	//_ = cur.Decode(bc)
	//fmt.Printf("%+v, %+v\n", bc, err)
}
