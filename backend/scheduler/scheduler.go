package scheduler

import (
	"bookstore-backend/dao"
	"time"
)

func redisBackgroundJob() {
	//log.Println("[Redis daemon] do job")
	_ = dao.DumpLikeRecordToDb()
}

func RedisDaemon() {
	PeriodicalWithDelay(time.Second*5, time.Second*10, redisBackgroundJob)
}

func BackgroundJob() {
	//if err := dao.DumpBookDocumentToElasticSearch(); err != nil {
	//	log.Printf("get error: %+v\n", err)
	//}
}
