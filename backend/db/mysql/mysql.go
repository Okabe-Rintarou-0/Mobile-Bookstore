package mysql

import (
	"bookstore-backend/config"
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"time"
)

var Db *sql.DB

func init() {
	cfg := config.Global.Mysql
	dataSource := fmt.Sprintf("%s:%s@%s(%s:%d)/%s", cfg.User, cfg.Password, cfg.Protocol, cfg.Host, cfg.Port, cfg.Db)
	var err error
	Db, err = sql.Open("mysql", dataSource)
	if err != nil {
		panic(err)
	}
	// See "Important settings" section.
	Db.SetConnMaxLifetime(time.Minute * 3)
	Db.SetMaxOpenConns(10)
	Db.SetMaxIdleConns(10)
}
