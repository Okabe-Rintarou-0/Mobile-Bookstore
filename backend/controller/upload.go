package controller

import (
	"bookstore-backend/constants"
	"bookstore-backend/message"
	"bookstore-backend/service"
	"bookstore-backend/session"
	"bookstore-backend/utils"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"io"
	"io/ioutil"
	"log"
	"mime/multipart"
	"net/http"
	"os"
	"path"
)

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

		if format, err = utils.GuessImageFormat(file); err != nil {
			log.Println(err.Error())
			goto uploadFail
		}

		if format == "" {
			goto invalidFileFormat
		}

		var data []byte
		_, err = file.Seek(0, io.SeekStart)
		if err != nil {
			log.Println(err.Error())
			goto uploadFail
		}

		data, err = ioutil.ReadAll(file)
		if err != nil {
			log.Println(err.Error())
			goto uploadFail
		}

		imgName = fmt.Sprintf("%s.%s", uuid.NewString(), format)
		// using relative path
		dest := path.Join(".", constants.UploadPath, imgName)
		if err = utils.CompressAndSaveImage(data, dest); err != nil {
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
