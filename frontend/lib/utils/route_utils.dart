import 'package:flutter/material.dart';

class RouteUtils {
  static void routeToStatic(BuildContext context, String path) =>
      Navigator.of(context).pushNamed(path);

  static void routeToDynamic(BuildContext context, Widget page) =>
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ));
}
