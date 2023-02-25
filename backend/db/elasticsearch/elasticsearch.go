package elasticsearch

import (
	"bookstore-backend/config"
	"fmt"
	"github.com/elastic/go-elasticsearch/v8"
	"io/ioutil"
	"log"
)

var Cli *elasticsearch.Client

func init() {
	var (
		err  error
		cert []byte
	)
	cfg := config.Global.Elasticsearch

	cert, err = ioutil.ReadFile(cfg.Cert)
	Cli, err = elasticsearch.NewClient(elasticsearch.Config{
		CACert:    cert,
		Username:  cfg.Username,
		Password:  cfg.Password,
		Addresses: []string{fmt.Sprintf("https://%s:%d", cfg.Host, cfg.Port)},
	})
	if err != nil {
		panic(err)
	}

	res, err := Cli.Info()
	if err != nil {
		log.Fatalf("Error getting response: %s", err)
	}

	defer res.Body.Close()
	log.Println(res)
}
