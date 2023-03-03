package entity

type AddressInfo struct {
	Id        uint32 `json:"id"`
	Address   string `json:"address"`
	Tel       string `json:"tel"`
	Name      string `json:"name"`
	IsDefault bool   `json:"isDefault"`
}
