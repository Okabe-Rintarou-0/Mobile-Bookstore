import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_bookstore/model/response.dart';

class ResponseUtils {
  static void handleResponse(BuildContext context, Response? res,
      {void Function()? onSucceed, void Function()? onFail}) {
    if (res == null) {
      BrnToast.show("未知错误", context);
      return;
    }
    if (res.success) {
      BrnToast.show(res.message, context);
      if (onSucceed != null) {
        onSucceed();
      }
    } else {
      BrnToast.show(res.err, context);
      if (onFail != null) {
        onFail();
      }
    }
  }
}
