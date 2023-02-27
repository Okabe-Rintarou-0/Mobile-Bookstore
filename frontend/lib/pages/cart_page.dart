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

  final Map<int, bool> checkMap = {};

  int computeTotalPrice() {
    if (items == null) {
      return 0;
    }
    int sum = 0;
    for (CartItem item in items!) {
      sum += item.price;
    }
    return sum;
  }

  void selectOrCancelAll(bool select) {
    for (var key in checkMap.keys) {
      checkMap[key] = select;
    }
    setState(() {
      selectAll = select;
      total = select ? computeTotalPrice() : 0;
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
    return items
        .map((item) => CartItemCard(
              checked: checkMap[item.id]!,
              cartItem: item,
              onCancel: (item) {
                setState(() {
                  total -= item.price;
                  checkMap[item.id] = false;
                });
              },
              onCheck: (item) {
                setState(() {
                  total += item.price;
                  checkMap[item.id] = true;
                });
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    const double panelHeight = 55;

    Widget cartItems = items != null
        ? Column(children: [..._cartItems(items!), const SizedBox(height: panelHeight)])
        : const SizedBox.shrink();

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

    Widget body = Stack(children: [
      Container(
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        color: const Color(0xFFF0F0F0),
        child: SingleChildScrollView(child: cartItems),
      ),
      bottomPanel
    ]);

    return Scaffold(
        appBar: AppBar(
          title: const Text("购物车", style: TextStyle(color: Colors.black)),
        ),
        body: body,
        bottomNavigationBar:
            const BottomAppBar(child: FooterBar(activatedSection: "cart")));
  }
}
