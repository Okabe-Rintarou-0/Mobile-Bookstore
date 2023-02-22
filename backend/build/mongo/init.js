db = db.getSiblingDB("bookstore");
db.createCollection("book_comments");

let bookComments = [];

for (let i = 1; i <= 588; i++) {
    bookComments.push({
        bookId: i,
        commentIds: []
    });
}

db.book_comments.insertMany(bookComments);