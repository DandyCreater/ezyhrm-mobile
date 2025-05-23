import 'dart:developer';

import 'package:get/get.dart';

class RouteUtil {
  static Future<void> offAll(String routeName, {dynamic arguments}) async {
    log('offAll: $routeName');
    await Get.offAllNamed(routeName, arguments: arguments);
  }

  static Future<void> to(String routeName,
      {dynamic arguments, Function()? onBack}) async {
    arguments ??= {};
    if (onBack != null) {
      arguments = {
        ...arguments,
        'onBack': onBack,
      };
    }
    await Get.toNamed(routeName, arguments: arguments);
  }

  static void back({dynamic arg, bool withDoBack = false}) {
    if (withDoBack) {
      _doBack(arg: arg);
      return;
    }
    Get.back();
  }

  static void _doBack({dynamic arg}) {
    final a = (arg != null ? arg['onBack'] : null);
    final ga = Get.arguments != null ? Get.arguments['onBack'] : null;
    Function()? doBack = a ?? ga;

    if (doBack != null) {
      doBack();
    } else {
      Get.back();
    }
  }
}
