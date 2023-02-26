import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag(
      {super.key,
      required this.text,
      this.onTap,
      this.padding = const EdgeInsets.all(5),
      this.bgColor = const Color(0xFFF0F0F0),
      this.radius = 5,
      this.onLongPress});

  final String text;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsets padding;
  final Color bgColor;
  final double radius;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(radius)),
          child: Text(text),
        ),
      );
}
