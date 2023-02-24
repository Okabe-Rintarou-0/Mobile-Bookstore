package elasticsearch

import (
	"github.com/elastic/go-elasticsearch/v8"
)

var Cli *elasticsearch.Client

func init() {
	//cfg := config.Global.Elasticsearch
	//var err error
	//Cli, err = elasticsearch.NewClient(elasticsearch.Config{
	//	Username:  cfg.Username,
	//	Password:  cfg.Password,
	//	Addresses: []string{fmt.Sprintf("https://%s:%d", cfg.Host, cfg.Port)},
	//})
	//if err != nil {
	//	panic(err)
	//}
	//
	//res, err := Cli.Info()
	//if err != nil {
	//	log.Fatalf("Error getting response: %s", err)
	//}
	//
	//defer res.Body.Close()
	//log.Println(res)
}
