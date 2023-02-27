import 'package:flutter/material.dart';
import 'package:mobile_bookstore/model/cart_item.dart';

import '../pages/book_details_page.dart';
import '../utils/route_utils.dart';
import 'common/texts.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(
      {super.key, required this.cartItem, this.onCheck, this.onCancel, this.checked = false});

  final bool checked;

  final CartItem cartItem;

  final void Function(CartItem)? onCheck;

  final void Function(CartItem)? onCancel;

  @override
  State<StatefulWidget> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int number = widget.cartItem.number;

  late bool checked = widget.checked;

  @override
  Widget build(BuildContext context) {
    Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              widget.cartItem.title,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text("作者：${widget.cartItem.author}",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)))
          ],
        ),
        Row(
          children: [
            PriceText(price: widget.cartItem.price),
            const SizedBox(width: 10),
          ],
        )
      ],
    );

    info = Expanded(
        child: Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      child: info,
    ));

    Widget checkBox = Checkbox(
        shape: const CircleBorder(),
        value: widget.checked,
        onChanged: (checked) {
          if (checked == null) return;
          widget.cartItem.number = number;
          if (checked && widget.onCheck != null) {
            widget.onCheck!(widget.cartItem);
          }
          if (!checked && widget.onCancel != null) {
            widget.onCancel!(widget.cartItem);
          }
        });

    final img = GestureDetector(
        onTap: () => RouteUtils.routeToDynamic(
            context, BookDetailsPage(id: widget.cartItem.bookId)),
        child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child:
                Image.network(widget.cartItem.cover, width: 120, height: 120)));

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [checkBox, img, info],
      ),
    );
  }
}
