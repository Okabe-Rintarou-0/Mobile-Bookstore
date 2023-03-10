package app

import (
	"bookstore-backend/controller"
	"bookstore-backend/scheduler"
	"fmt"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

type App struct{}

func New() *App {
	return &App{}
}

func CorsHandler() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method
		origin := c.Request.Header.Get("Origin") //请求头部
		if origin != "" {
			//接收客户端发送的origin （重要！）
			c.Writer.Header().Set("Access-Control-Allow-Origin", origin)
			//服务器支持的所有跨域请求的方法
			c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE,UPDATE")
			//允许跨域设置可以返回其他子段，可以自定义字段
			c.Header("Access-Control-Allow-Headers", "Authorization, Content-Length, X-CSRF-Token, Token,session")
			// 允许浏览器（客户端）可以解析的头部 （重要）
			c.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers")
			//设置缓存时间
			c.Header("Access-Control-Max-Age", "172800")
			//允许客户端传递校验信息比如 cookie (重要)
			c.Header("Access-Control-Allow-Credentials", "true")
		}

		//允许类型校验
		if method == "OPTIONS" {
			c.JSON(http.StatusOK, "ok!")
		}

		defer func() {
			if err := recover(); err != nil {
				log.Printf("Panic info is: %v", err)
			}
		}()

		c.Next()
	}
}

func (app *App) Run(host string, port uint) {
	r := gin.Default()

	r.Use(CorsHandler())
	r.StaticFS("/static", http.Dir("./static"))

	r.POST("/login", controller.Login)
	r.POST("/register", controller.Register)
	r.POST("/books/:id/comments", controller.UploadBookComment)
	r.POST("/books/:id/cart", controller.AddToCart)

	r.GET("/logout", controller.Logout)
	r.GET("/checkSession/", controller.CheckSession)

	// TODO fix to /books/:id/api
	r.GET("/books/details/:id", controller.GetBookDetailsById)
	r.GET("/books/snapshot/:id", controller.GetBookSnapshotById)
	//

	r.GET("/books/search", controller.SearchBook)
	r.GET("/books/snapshots/", controller.GetRangedBookSnapshots)
	r.GET("/books/:id/comments/snapshot", controller.GetBookCommentsSnapshot)
	r.GET("/users/profile", controller.GetUserProfile)
	r.GET("/comments/:id/like", controller.LikeOrCancelLike)
	r.GET("/comments/:id/liked", controller.GetIsLiked)
	r.GET("/user/addresses", controller.GetUserSavedAddresses)

	r.POST("/user/addresses", controller.SaveUserAddress)

	r.GET("/cart", controller.GetUserCartItems)

	r.PUT("/cart/:id/number/:number", controller.UpdateCartItemNumber)
	r.PUT("/user/addresses/default", controller.ChangeUserDefaultAddress)
	r.DELETE("/user/addresses/:id", controller.DeleteUserAddress)
	r.DELETE("/cart/:id", controller.RemoveCartItem)

	r.POST("/upload/image", controller.UploadImage)

	go scheduler.RedisDaemon()
	go scheduler.BackgroundJob()

	addr := fmt.Sprintf("%s:%d", host, port)
	if err := r.Run(addr); err != nil {
		panic(err)
	}
}
