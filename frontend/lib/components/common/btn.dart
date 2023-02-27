import 'package:flutter/material.dart';

class GradientColorButton extends StatelessWidget {
  const GradientColorButton(
      {super.key,
      required this.colors,
      this.onPressed,
      required this.text,
      required this.borderRadius,
      this.padding = const EdgeInsets.all(0)});

  final List<Color> colors;

  final Text text;

  final BorderRadius borderRadius;

  final void Function()? onPressed;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(colors: colors),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: text,
        ),
      );
}
