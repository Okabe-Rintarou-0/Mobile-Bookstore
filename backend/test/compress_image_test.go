package test

import (
	"bookstore-backend/utils"
	"io/ioutil"
	"os"
	"testing"
)

func TestImageCompress(t *testing.T) {
	file, _ := os.Open("../static/test.png")
	defer file.Close()
	data, _ := ioutil.ReadAll(file)
	compressed := utils.CompressImageResource(data)
	file, _ = os.Create("../static/tmp.jpeg")
	defer file.Close()
	_, _ = file.Write(compressed)
}
