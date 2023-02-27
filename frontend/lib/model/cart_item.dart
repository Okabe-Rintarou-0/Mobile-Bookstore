// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
    required this.id,
    required this.number,
    required this.bookId,
    required this.title,
    required this.author,
    required this.price,
    required this.sales,
    required this.cover,
  });

  int id;
  int number;
  int bookId;
  String title;
  String author;
  int price;
  int sales;
  String cover;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        number: json["number"],
        bookId: json["bookId"],
        title: json["title"],
        author: json["author"],
        price: json["price"],
        sales: json["sales"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "bookId": bookId,
        "title": title,
        "author": author,
        "price": price,
        "sales": sales,
        "cover": cover,
      };
}
