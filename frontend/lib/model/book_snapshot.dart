// To parse this JSON data, do
//
//     final bookSnapshot = bookSnapshotFromJson(jsonString);

import 'dart:convert';

BookSnapshot bookSnapshotFromJson(String str) =>
    BookSnapshot.fromJson(json.decode(str));

String bookSnapshotToJson(BookSnapshot data) => json.encode(data.toJson());

class BookSnapshot {
  BookSnapshot({
    this.id = -1,
    this.title = "",
    this.author = "",
    this.price = 0,
    this.sales = 0,
    this.cover = "",
  });

  int id;
  String title;
  String author;
  int price;
  int sales;
  String cover;

  factory BookSnapshot.fromJson(Map<String, dynamic> json) => BookSnapshot(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        price: json["price"],
        sales: json["sales"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "price": price,
        "sales": sales,
        "cover": cover,
      };
}
