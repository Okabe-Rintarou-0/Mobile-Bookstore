package scheduler

import (
	"bookstore-backend/dao"
	"time"
)

func doJob() {
	//log.Println("[Redis daemon] do job")
	_ = dao.DumpLikeRecordToDb()
}

func RedisDaemon() {
	PeriodicalWithDelay(time.Second*5, time.Second*10, doJob)
}
