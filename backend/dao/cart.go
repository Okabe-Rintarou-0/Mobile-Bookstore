package dao

import (
	"bookstore-backend/db/mysql"
	"bookstore-backend/entity"
	"database/sql"
	"fmt"
	"strings"
)

func GetCartItem(cartItemId uint32) (*entity.CartItemWithBook, error) {
	var (
		i      entity.CartItemWithBook
		err    error
		covers string
	)

	err = mysql.Db.QueryRow(`select cart_item.id, number, b.id, title, author, price, sales, covers 
from cart_item join book b 
on b.id = cart_item.book_id 
where cart_item.id = ?`, cartItemId).
		Scan(&i.Id, &i.Number, &i.BookId, &i.Title, &i.Author, &i.Price, &i.Sales, &covers)

	blankIdx := strings.Index(covers, " ")
	if blankIdx != -1 {
		i.Cover = covers[:blankIdx]
	} else {
		i.Cover = covers
	}

	return &i, err
}

func GetCartRecordByBookId(bookId, userId uint32) (*entity.UserCartRecord, error) {
	var (
		r   entity.UserCartRecord
		err error
	)
	err = mysql.Db.QueryRow(`select cart_item_id, user_id 
from user_cart_record 
join cart_item 
on user_cart_record.cart_item_id = cart_item.id
where book_id = ? and user_id = ?`, bookId, userId).Scan(&r.CartItemId, &r.UserId)
	if err != nil {
		return nil, err
	}
	return &r, nil
}

func GetAllCartRecords(userId uint32) ([]*entity.UserCartRecord, error) {
	var (
		records []*entity.UserCartRecord
		err     error
		rows    *sql.Rows
	)
	rows, err = mysql.Db.Query(`select cart_item_id, user_id 
from user_cart_record 
join cart_item 
on user_cart_record.cart_item_id = cart_item.id
where user_id = ?`, userId)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var r entity.UserCartRecord
		if err = rows.Scan(&r.CartItemId, &r.UserId); err != nil {
			return nil, err
		}
		records = append(records, &r)
	}

	_ = rows.Close()

	return records, err
}

func UpdateCartItemNumber(cartItemId, number uint32) (err error) {
	_, err = mysql.Db.Exec(`update cart_item set number = ? where id = ?`, number, cartItemId)
	return err
}

// RemoveCartItem should be transactional
func RemoveCartItem(cartItemId uint32) error {
	var err error
	err = mysql.Transact(func(tx *sql.Tx) error {
		_, err = mysql.Db.Exec(`delete from user_cart_record where cart_item_id = ?`, cartItemId)
		if err != nil {
			return err
		}
		_, err = mysql.Db.Exec(`delete from cart_item where id = ?`, cartItemId)
		return err
	})
	return err
}

func SaveCartItem(cartItem *entity.CartItem, userId uint32) error {
	var (
		r   sql.Result
		tx  *sql.Tx
		err error
		id  int64
	)

	tx, err = mysql.Db.Begin()
	if err != nil && tx != nil {
		fmt.Printf("begin trans failed, err:%v\n", err)
		goto Rollback
	}

	r, err = tx.Exec("insert into cart_item (book_id, number) value (?, ?)", cartItem.BookId, cartItem.Number)
	if id, err = r.LastInsertId(); err != nil {
		fmt.Printf("begin trans failed, err:%v\n", err)
		goto Rollback
	}

	_, err = tx.Exec("insert into user_cart_record (cart_item_id, user_id) value (?, ?)", id, userId)
	if err != nil {
		fmt.Printf("begin trans failed, err:%v\n", err)
		goto Rollback
	}

	if err = tx.Commit(); err == nil {
		return nil
	} else {
		fmt.Printf("begin trans failed, err:%v\n", err)
		goto Rollback
	}

Rollback:
	_ = tx.Rollback()
	return err
}
