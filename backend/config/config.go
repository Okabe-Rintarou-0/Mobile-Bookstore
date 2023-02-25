package config

import (
	"gopkg.in/yaml.v3"
	"io/ioutil"
	"os"
)

var Global *Config = nil

type MysqlConfig struct {
	User     string `yaml:"user"`
	Password string `yaml:"password"`
	Protocol string `yaml:"protocol"`
	Host     string `yaml:"host"`
	Port     uint   `yaml:"port"`
	Db       string `yaml:"db"`
}

type RedisConfig struct {
	Host     string `yaml:"host"`
	Port     uint   `yaml:"port"`
	Username string `yaml:"username"`
	Password string `yaml:"password"`
	Db       int    `yaml:"db"`
}

type MongoConfig struct {
	Host     string `yaml:"host"`
	Port     uint   `yaml:"port"`
	Username string `yaml:"username"`
	Password string `yaml:"password"`
}

type ElasticsearchConfig struct {
	Host     string `yaml:"host"`
	Port     uint   `yaml:"port"`
	Username string `yaml:"username"`
	Password string `yaml:"password"`
	Cert     string `yaml:"cert"`
}

type SessionConfig struct {
	Lifetime uint64 `yaml:"lifetime"`
}

type FrontendConfig struct {
	BooksPerPage uint32 `yaml:"booksPerPage"`
}

type Config struct {
	Mysql         MysqlConfig         `yaml:"mysql"`
	Redis         RedisConfig         `yaml:"redis"`
	Mongo         MongoConfig         `yaml:"mongo"`
	Elasticsearch ElasticsearchConfig `yaml:"elasticsearch"`
	Session       SessionConfig       `yaml:"session"`
	Frontend      FrontendConfig      `yaml:"frontend"`
}

func ReadConfig(path string) (*Config, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}

	var content []byte
	content, err = ioutil.ReadAll(file)

	var config Config
	err = yaml.Unmarshal(content, &config)
	if err != nil {
		return nil, err
	}

	return &config, nil
}

func init() {
	var err error
	Global, err = ReadConfig("./config.yml")
	if err != nil {
		panic(err)
	}
}
