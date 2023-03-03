import 'package:flutter/material.dart';

class TextAvatar extends StatelessWidget {
  const TextAvatar(
      {super.key,
      required this.colors,
      required this.text,
      required this.textColor,
      this.height = 50,
      this.fontSize});

  final List<Color> colors;

  final double height;

  final Color textColor;

  final String text;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
      child: Center(
          child: Text(text,
              style: TextStyle(color: textColor, fontSize: fontSize))),
    );
  }
}

class DefaultAddressAvatar extends StatelessWidget {
  const DefaultAddressAvatar(
      {super.key,
      required this.colors,
      this.iconColor = Colors.white,
      this.height = 50,
      this.iconSize});

  final List<Color> colors;

  final double height;

  final Color iconColor;

  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
      child: Center(child: Icon(Icons.home, color: iconColor, size: iconSize)),
    );
  }
}
