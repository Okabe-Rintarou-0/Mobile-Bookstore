import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText(
      {super.key,
      required this.price,
      this.lineThrough = false,
      this.symbolSize = 15,
      this.textSize = 25,
      this.color = const Color(0xffff6600)});

  String _formatPrice(int price) {
    return price % 100 == 0
        ? (price ~/ 100).toString()
        : (price / 100).toString();
  }

  final int price;
  final bool lineThrough;
  final double symbolSize;
  final double textSize;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text("¥",
              style: TextStyle(
                fontSize: symbolSize,
                color: color,
              )),
          Text(_formatPrice(price),
              style: TextStyle(
                  fontSize: textSize,
                  color: color,
                  decoration: lineThrough ? TextDecoration.lineThrough : null))
        ],
      );
}

class SalesText extends StatelessWidget {
  const SalesText(
      {super.key,
      required this.sales,
      this.textSize = 15,
      this.color = Colors.grey});

  final int sales;
  final double textSize;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Text("销量 $sales", style: TextStyle(fontSize: textSize, color: color));
}
