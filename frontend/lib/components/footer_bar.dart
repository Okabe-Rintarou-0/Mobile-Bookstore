import 'package:flutter/material.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

class _BottomBtnAttrs {
  _BottomBtnAttrs(
      {required this.text,
      required this.section,
      required this.defaultIcon,
      required this.activatedIcon,
      this.defaultColor = const Color(0xFF505050),
      this.activatedColor = const Color(0xffff6600)});

  final Color defaultColor;
  final Color activatedColor;
  final String text;
  final String section;
  final IconData defaultIcon;
  final IconData activatedIcon;
// final void Function()? onPressed;
}

class FooterBar extends StatelessWidget {
  const FooterBar({super.key, required this.activatedSection});

  final String activatedSection;

  Widget _textBtn(
          String text,
          IconData defaultIcon,
          Color defaultColor,
          void Function()? onPressed,
          bool activated,
          Color activatedColor,
          IconData activatedIcon) =>
      TextButton.icon(
          label: Text(text,
              style:
                  TextStyle(color: activated ? activatedColor : defaultColor)),
          icon: Icon(activated ? activatedIcon : defaultIcon,
              color: activated ? activatedColor : defaultColor),
          onPressed: onPressed);

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _BottomBtnAttrs(
            text: "主页",
            section: "home",
            defaultIcon: Icons.home_outlined,
            activatedIcon: Icons.home),
        _BottomBtnAttrs(
            text: "购物车",
            section: "shopping_cart",
            defaultIcon: Icons.shopping_cart_checkout_outlined,
            activatedIcon: Icons.shopping_cart_checkout),
        _BottomBtnAttrs(
            text: "设置",
            section: "settings",
            defaultIcon: Icons.settings_outlined,
            activatedIcon: Icons.settings),
      ]
          .map((attr) => _textBtn(
              attr.text,
              attr.defaultIcon,
              attr.defaultColor,
              activatedSection == attr.section
                  ? null
                  : () => RouteUtils.routeToStatic(context, "/${attr.section}"),
              activatedSection == attr.section,
              attr.activatedColor,
              attr.activatedIcon))
          .toList());
}
