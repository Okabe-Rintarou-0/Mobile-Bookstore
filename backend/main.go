package main

import (
	"bookstore-backend/app"
)

func main() {
	instance := app.New()
	instance.Run("0.0.0.0", 8080)
}
