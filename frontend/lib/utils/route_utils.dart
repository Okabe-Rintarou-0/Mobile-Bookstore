import 'package:flutter/cupertino.dart';

class RouteUtils {
  static void routeToStatic(BuildContext context, String path) =>
      Navigator.of(context).pushNamed(path);
}
