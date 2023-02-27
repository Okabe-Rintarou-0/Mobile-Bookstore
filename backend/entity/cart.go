package entity

type CartItem struct {
	Id     uint32 `json:"id"`
	BookId uint32 `json:"bookId"`
	Number uint32 `json:"number"`
}

type UserCartRecord struct {
	CartItemId uint32 `json:"cartItemId"`
	UserId     uint32 `json:"userId"`
}

type CartItemWithBook struct {
	Id     uint32 `json:"id"`
	Number uint32 `json:"number"`
	BookId uint32 `json:"bookId"`
	Title  string `json:"title"`
	Author string `json:"author"`
	Price  uint32 `json:"price"`
	Sales  uint32 `json:"sales"`
	Cover  string `json:"cover"`
}
