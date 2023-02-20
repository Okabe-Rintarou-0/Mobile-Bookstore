// To parse this JSON data, do
//
//     final bookDetails = bookDetailsFromJson(jsonString);

import 'dart:convert';

BookDetails bookDetailsFromJson(String str) =>
    BookDetails.fromJson(json.decode(str));

String bookDetailsToJson(BookDetails data) => json.encode(data.toJson());

class BookDetails {
  BookDetails({
    this.id = -1,
    this.title = "UNKNOWN",
    this.price = 0,
    this.orgPrice = 0,
    this.author = "UNKNOWN",
    this.sales = 0,
    this.covers = const [],
  });

  int id;
  String title;
  int price;
  int orgPrice;
  String author;
  int sales;
  List<String> covers;

  factory BookDetails.fromJson(Map<String, dynamic> json) => BookDetails(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        orgPrice: json["orgPrice"],
        author: json["author"],
        sales: json["sales"],
        covers: List<String>.from(json["covers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "orgPrice": orgPrice,
        "author": author,
        "sales": sales,
        "covers": List<dynamic>.from(covers.map((x) => x)),
      };
}
