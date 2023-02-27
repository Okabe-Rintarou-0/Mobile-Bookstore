import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/common/number_input.dart';
import 'package:mobile_bookstore/model/cart_item.dart';

import '../api/api.dart';
import '../pages/book_details_page.dart';
import '../utils/route_utils.dart';
import 'common/texts.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.cartItem,
    this.onCheck,
    this.onCancel,
    this.onUpdateNumber,
    this.onRemove,
    this.checked = false,
  });

  final bool checked;

  final CartItem cartItem;

  final void Function(CartItem)? onCheck;

  final void Function(CartItem)? onCancel;

  final void Function(CartItem)? onRemove;

  final void Function(CartItem, int, int)? onUpdateNumber;

  @override
  State<StatefulWidget> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late bool checked = widget.checked;

  void updateCartNumber(BuildContext context, int number) {
    BrnLoadingDialog.show(context);
    Api.updateCartNumber(widget.cartItem.id, number).then((res) {
      BrnLoadingDialog.dismiss(context);
      if (res == null) {
        BrnToast.show("未知错误", context);
        return;
      }
      if (!res.success) {
        BrnToast.show(res.err, context);
        return;
      }
      if (widget.onUpdateNumber != null) {
        widget.onUpdateNumber!(widget.cartItem, widget.cartItem.number, number);
      }
      setState(() {
        widget.cartItem.number = number;
      });
    });
  }

  void removeCartItem() {
    if (widget.onRemove != null) {
      widget.onRemove!(widget.cartItem);
    }
  }

  void showRemoveCartItemModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return BrnCommonActionSheet(
            actions: [
              BrnCommonActionSheetItem(
                '删除',
                actionStyle: BrnCommonActionSheetItemStyle.alert,
              ),
            ],
            clickCallBack: (int index, BrnCommonActionSheetItem actionEle) {
              switch (index) {
                case 0:
                  removeCartItem();
                  Navigator.of(context).pop();
                  break;
              }
            },
          );
        });
  }

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
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text("作者：${widget.cartItem.author}",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)))
          ],
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PriceText(
                price: widget.cartItem.price, textSize: 18, symbolSize: 15),
            EditableNumber(
              number: widget.cartItem.number,
              min: 1,
              max: 10000,
              onAdd: () =>
                  updateCartNumber(context, widget.cartItem.number + 1),
              onRemove: () =>
                  updateCartNumber(context, widget.cartItem.number - 1),
            )
          ],
        ))
      ],
    );

    info = Expanded(
        child: SizedBox(
      height: 100,
      child: info,
    ));

    Widget checkBox = Checkbox(
        shape: const CircleBorder(),
        value: widget.checked,
        onChanged: (checked) {
          if (checked == null) return;
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
                Image.network(widget.cartItem.cover, width: 100, height: 100)));

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          checkBox,
          Expanded(
              child: GestureDetector(
            onLongPress: showRemoveCartItemModal,
            child: Row(children: [img, info]),
          ))
        ],
      ),
    );
  }
}
