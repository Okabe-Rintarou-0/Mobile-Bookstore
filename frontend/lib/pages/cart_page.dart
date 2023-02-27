import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/api/api.dart';
import 'package:mobile_bookstore/components/cart_item_card.dart';
import 'package:mobile_bookstore/components/common/texts.dart';
import 'package:mobile_bookstore/components/footer_bar.dart';
import 'package:mobile_bookstore/model/cart_item.dart';

import '../components/common/btn.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem>? items;

  int total = 0;

  bool selectAll = false;

  Map<int, bool> checkMap = {};

  int computeTotalPrice() {
    if (items == null) {
      return 0;
    }
    int sum = 0;
    for (CartItem item in items!) {
      sum += item.price * item.number;
    }
    return sum;
  }

  void selectOrCancelAll(bool select) {
    setState(() {
      for (var key in checkMap.keys) {
        checkMap[key] = select;
      }
      selectAll = select;
      total = select ? computeTotalPrice() : 0;
    });
  }

  bool checkIsSelectAll() {
    for (var key in checkMap.keys) {
      if (!checkMap[key]!) {
        return false;
      }
    }
    return checkMap.isNotEmpty;
  }

  void removeItem(CartItem item) {
    BrnLoadingDialog.show(context);
    Api.removeCartItem(item.id).then((res) {
      if (res == null) {
        BrnToast.show("未知错误", context);
        BrnLoadingDialog.dismiss(context);
        return;
      }
      BrnLoadingDialog.dismiss(context);
      if (!res.success) {
        BrnToast.show(res.err, context);
        return;
      }

      Api.getCartItems().then((items) {
        setState(() {
          this.items = items;
          bool checked = checkMap[item.id]!;
          checkMap.remove(item.id);
          if (checked) {
            total -= item.price * item.number;
            selectAll = checkIsSelectAll();
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Api.getCartItems().then((items) {
      for (CartItem item in items) {
        checkMap[item.id] = false;
      }
      setState(() {
        this.items = items;
      });
    });
  }

  List<Widget> _cartItems(List<CartItem> items) {
    return items.map((item) {
      return CartItemCard(
        checked: checkMap[item.id]!,
        cartItem: item,
        onCancel: (i) {
          setState(() {
            total -= i.price * i.number;
            checkMap[i.id] = false;
            selectAll = false;
          });
        },
        onCheck: (i) {
          setState(() {
            total += i.price * i.number;
            checkMap[i.id] = true;
            selectAll = checkIsSelectAll();
          });
        },
        onUpdateNumber: (i, oldNumber, newNumber) {
          if (checkMap[i.id]!) {
            setState(() {
              total += (newNumber - oldNumber) * i.price;
            });
          }
        },
        onRemove: removeItem,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const double panelHeight = 55;

    List<Widget> itemWidgets = items != null ? _cartItems(items!) : [];

    Widget cartItems =
        Column(children: [...itemWidgets, const SizedBox(height: panelHeight)]);

    Widget selectAllCheckBox = Row(children: [
      Checkbox(
          shape: const CircleBorder(),
          value: selectAll,
          onChanged: (checked) {
            if (checked == null) return;
            selectOrCancelAll(checked);
          }),
      const Text("全选", style: TextStyle(color: Colors.grey))
    ]);

    Widget submitBtn = GradientColorButton(
        onPressed: () {},
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        text: const Text("结算", style: TextStyle(color: Colors.white)),
        colors: const [Color(0xFFFF7800), Color(0xFFFF4B00)]);

    Widget priceAndSubmit = Row(
      children: [
        const Text("合计：", style: TextStyle(color: Colors.black)),
        PriceText(price: total),
        const SizedBox(width: 20),
        submitBtn
      ],
    );

    Widget bottomPanel = Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: panelHeight,
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [selectAllCheckBox, priceAndSubmit],
        ),
      ),
    );

    Widget body = Visibility(
        visible: items != null && items!.isNotEmpty,
        child: Stack(children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xFFF0F0F0),
            child: SingleChildScrollView(child: cartItems),
          ),
          bottomPanel,
        ]));

    return Scaffold(
        appBar: AppBar(
          title: const Text("购物车", style: TextStyle(color: Colors.black)),
        ),
        body: body,
        bottomNavigationBar:
            const BottomAppBar(child: FooterBar(activatedSection: "cart")));
  }
}
