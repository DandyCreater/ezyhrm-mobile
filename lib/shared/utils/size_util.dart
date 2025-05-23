import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../di.dart';

class SizeUtil {
  static double f(double size) {
    var width = Get.width;

    if (width < 425) {
      return size;
    } else if (width > 425 && width < 768) {
      var p = (width * 100) / 425;

      p = p - (p / 3);

      var r = (size * p) / 100;

      if (r < size) return size;
      return r;
    } else {
      return (size * 120) / 100;
    }
  }

  static double g4(double size) {
    if (Get.width > Get.height || Get.width > 500) {
      return f(100);
    }
    return size;
  }

  static double cfw() {
    var width = Get.width * .7;
    if (Get.width > Get.height) {
      width = Get.height * .4;
    }
    return width;
  }

  static double topSpaceBar() {
    var padding = MediaQuery.of(Get.context!).padding;
    return padding.top + (Get.height * .13);
  }

  static double sr(double percent) {
    var def = Get.width * percent;
    if (DependencyInjection.isLandscape.value) {
      def = Get.height * percent;
    }
    return def;
  }
}
