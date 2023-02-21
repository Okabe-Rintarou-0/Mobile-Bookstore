package controller

import (
	"bookstore-backend/constants"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"log"
	"mime"
	"mime/multipart"
	"net/http"
	"os"
	"path"
)

// Guess image format from gif/jpeg/png/webp
func guessImageFormat(r io.Reader) (format string, err error) {
	_, format, err = image.DecodeConfig(r)
	return
}

// Guess image mime types from gif/jpeg/png/webp
func guessImageMimeTypes(r io.Reader) string {
	format, _ := guessImageFormat(r)
	if format == "" {
		return ""
	}
	return mime.TypeByExtension("." + format)
}

func UploadImage(c *gin.Context) {
	f, err := c.FormFile("file")
	if err != nil {
		log.Println(err.Error())
		goto uploadFail
	} else {
		if err != nil {
			log.Println(err.Error())
		}
		var file multipart.File
		var format, imgName string
		file, err = f.Open()
		defer file.Close()
		if err != nil {
			log.Println(err.Error())
			goto uploadFail
		}
		if format, err = guessImageFormat(file); err != nil {
			log.Println(err.Error())
			goto uploadFail
		}

		if format == "" {
			goto invalidFileFormat
		}

		imgName = fmt.Sprintf("%s.%s", uuid.NewString(), format)
		// using relative path
		dest := path.Join(".", constants.UploadPath, imgName)
		if err = c.SaveUploadedFile(f, dest); err != nil {
			goto uploadFail
		}

		avatarUrl := path.Join(constants.UploadPath, imgName)
		if err = service.UpdateUserAvatar(session.Manager.GetUsername(c.Request), avatarUrl); err != nil {
			// recover
			_ = os.Remove(path.Join(".", avatarUrl))
			goto uploadFail
		}
	}
	c.JSON(http.StatusOK, message.Success(message.UploadSucceed))
	return
uploadFail:
	c.JSON(http.StatusOK, message.Fail(message.UploadFail))
	return
invalidFileFormat:
	c.JSON(http.StatusOK, message.Fail(message.InvalidFileFormat))
}
