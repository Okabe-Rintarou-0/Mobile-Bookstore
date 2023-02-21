package entity

import "encoding/json"

type BookDetails struct {
	Id       uint32   `json:"id"`
	Title    string   `json:"title"`
	Price    uint32   `json:"price"`
	OrgPrice uint32   `json:"orgPrice"`
	Author   string   `json:"author"`
	Sales    uint32   `json:"sales"`
	Covers   []string `json:"covers"`
}

func (d *BookDetails) ToJsonString() string {
	marshalled, _ := json.Marshal(d)
	return string(marshalled)
}

type BookSnapshot struct {
	Id     uint32 `json:"id"`
	Title  string `json:"title"`
	Author string `json:"author"`
	Price  uint32 `json:"price"`
	Sales  uint32 `json:"sales"`
	Cover  string `json:"cover"`
}

func (s *BookSnapshot) ToJsonString() string {
	marshalled, _ := json.Marshal(s)
	return string(marshalled)
}
