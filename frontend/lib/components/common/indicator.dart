import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

Widget? defaultIndicatorBuilder(BuildContext context, IndicatorStatus status) {
  switch (status) {
    case IndicatorStatus.loadingMoreBusying:
    case IndicatorStatus.fullScreenBusying:
      return IndicatorWidget(status, text: "加载中...");
    case IndicatorStatus.empty:
      return IndicatorWidget(status, text: "无结果");
    case IndicatorStatus.error:
    case IndicatorStatus.fullScreenError:
      return IndicatorWidget(status, text: "加载错误，请稍后再试！");
    case IndicatorStatus.noMoreLoad:
      return IndicatorWidget(status, text: "没有更多啦~");
    case IndicatorStatus.none:
      return null;
  }
}
