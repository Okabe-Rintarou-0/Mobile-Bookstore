package main

import (
	"bookstore-backend/app"
	_ "bookstore-backend/db/mongo"
)

func main() {
	instance := app.New()
	instance.Run("0.0.0.0", 8080)
}
