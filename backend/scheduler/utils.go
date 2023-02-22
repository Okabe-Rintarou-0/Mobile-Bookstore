package scheduler

import "time"

func PeriodicalWithDelay(delay, period time.Duration, handler func()) {
	<-time.After(delay)
	Periodical(period, handler)
}

func Periodical(period time.Duration, handler func()) {
	for range time.Tick(period) {
		handler()
	}
}
