import 'package:flutter/material.dart';

import 'common/texts.dart';

class BookDetailsCard extends StatelessWidget {
  const BookDetailsCard(
      {super.key,
      required this.price,
      required this.orgPrice,
      required this.title,
      required this.author,
      required this.sales});

  final int price;
  final int orgPrice;
  final String title;
  final String author;
  final int sales;

  Widget _priceText() {
    final List<Widget> priceTexts = [PriceText(price: price)];
    if (price != orgPrice) {
      priceTexts.add(const SizedBox(width: 10));
      priceTexts.add(PriceText(
        price: orgPrice,
        lineThrough: true,
        color: Colors.grey,
      ));
    }
    return Row(children: priceTexts);
  }

  TextButton _iconBtn(IconData icon, String text, void Function()? onPressed) =>
      TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.grey, size: 15),
          label: Text(text, style: const TextStyle(color: Colors.grey)));

  @override
  Widget build(BuildContext context) {
    final double parentWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: parentWidth,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_priceText(), SalesText(sales: sales)]),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                    child: Text(title,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),))
              ],
            ),
            Row(
              children: [
                Text("作者：$author",
                    style: const TextStyle(fontSize: 15, color: Colors.grey))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconBtn(Icons.recommend, "推荐", () {}),
                _iconBtn(Icons.share, "分享", () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
