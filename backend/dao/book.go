package dao

import (
	"bookstore-backend/db/mysql"
	"bookstore-backend/entity"
	"fmt"
	"strings"
)

func GetBookDetailsById(bookId uint32) (*entity.BookDetails, error) {
	var covers string
	var d entity.BookDetails
	err := mysql.Db.QueryRow("select id, covers, title, author, price, orgPrice, sales from book where book.id = ?", bookId).
		Scan(&d.Id, &covers, &d.Title, &d.Author, &d.Price, &d.OrgPrice, &d.Sales)

	d.Covers = strings.Split(covers, " ")

	return &d, err
}

func GetBookSnapshotById(bookId uint32) (*entity.BookSnapshot, error) {
	var covers string
	var s entity.BookSnapshot
	err := mysql.Db.QueryRow("select id, covers, title, author, price, sales from book where book.id = ?", bookId).
		Scan(&s.Id, &covers, &s.Title, &s.Author, &s.Price, &s.Sales)

	blankIdx := strings.Index(covers, " ")
	if blankIdx != -1 {
		s.Cover = covers[:blankIdx]
	} else {
		s.Cover = covers
	}

	return &s, err
}

func GetRangedBookSnapshots(startIdx, endIdx uint32) ([]*entity.BookSnapshot, error) {
	if startIdx > endIdx {
		return nil, fmt.Errorf("startIdx should less equal to endIdx")
	}
	var snapshots []*entity.BookSnapshot
	rows, err := mysql.Db.Query("select id, covers, title, author, price, sales from book where book.id >= ? and book.id <= ?", startIdx, endIdx)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var covers string
		var s entity.BookSnapshot
		if err = rows.Scan(&s.Id, &covers, &s.Title, &s.Author, &s.Price, &s.Sales); err != nil {
			return nil, err
		}

		blankIdx := strings.Index(covers, " ")
		if blankIdx != -1 {
			s.Cover = covers[:blankIdx]
		} else {
			s.Cover = covers
		}

		snapshots = append(snapshots, &s)
	}

	return snapshots, err
}
