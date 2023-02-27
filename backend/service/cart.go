package service

import (
	"bookstore-backend/dao"
	"bookstore-backend/entity"
	"database/sql"
	"fmt"
)

func AddToCart(bookId uint32, userId uint32) (bool, error) {
	var (
		err error
		r   *entity.UserCartRecord
	)

	cartItem := &entity.CartItem{
		BookId: bookId,
		Number: 1,
	}

	if r, err = dao.GetCartRecordByBookId(bookId, userId); err != nil && err != sql.ErrNoRows {
		return false, err
	}

	if r == nil {
		return true, dao.SaveCartItem(cartItem, userId)
	}

	fmt.Printf("%+v\n", r)

	return false, nil
}

func GetAllUserCartItems(userId uint32) ([]*entity.CartItemWithBook, error) {
	var (
		records []*entity.UserCartRecord
		items   []*entity.CartItemWithBook
		item    *entity.CartItemWithBook
		err     error
	)
	if records, err = dao.GetAllCartRecords(userId); err != nil {
		return nil, err
	}

	for _, record := range records {
		if item, err = dao.GetCartItem(record.CartItemId); err != nil {
			return nil, err
		}
		items = append(items, item)
	}
	return items, nil
}

func UpdateCartItemNumber(cartItemId, number uint32) error {
	return dao.UpdateCartItemNumber(cartItemId, number)
}

func RemoveCartItem(carItemId uint32) error {
	return dao.RemoveCartItem(carItemId)
}
