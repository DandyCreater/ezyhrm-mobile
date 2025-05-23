import 'dart:math';

import 'package:flutter/material.dart';

class ColorConstant {
  static const backgroundColor = Color(0xffF6F6F6);
  static const greenBackground = Color(0xFFD8EAC8);
  static final primary = hexToColor('#FF739F4B');

  static final primaryDark = hexToColor('#0563C1');
  static final primaryLight = hexToColor('#F2FBFF');
  static final pendingColor = hexToColor('#FFEDFAFF');

  static final black80 = hexToColor("#303030");
  static final black60 = hexToColor("#000000");

  static final red60 = hexToColor('#DE1B1B');
  static final red50 = hexToColor('#FAF0F0');

  static final yellow80 = hexToColor('#F59F00');
  static final yellow50 = hexToColor('#FF920A');
  static final yellow10 = hexToColor('#FFF9DB');

  static final green80 = hexToColor('#74B816');
  static final green10 = hexToColor('#F4FCE3');
  static final green90 = hexToColor('#FF739F4B');

  static final sky50 = hexToColor('#229BD8');
  static final sky10 = hexToColor('#EDF4F7');

  static final grey100 = hexToColor('#000000');
  static final grey90 = hexToColor('#424242');
  static final grey80 = hexToColor('#616161');
  static final grey70 = hexToColor('#757575');
  static final grey60 = hexToColor('#9E9E9E');
  static final grey50 = hexToColor('#BDBDBD');
  static final grey40 = hexToColor('#E0E0E0');
  static final grey30 = hexToColor('#EEEEEE');
  static final grey20 = hexToColor('#F5F5F5');
  static final grey05 = hexToColor('#F3F3F3');
  static final grey10 = hexToColor('#FAFAFA');
  static final grey0 = hexToColor('#FFFFFF');
  static final grey1000 = hexToColor('#FFD8D8D8');

  static Color hexToColor(String hex) {
    assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
        'hex color must be #rrggbb or #rrggbbaa');

    return Color(
      int.parse(hex.substring(1), radix: 16) +
          (hex.length == 7 ? 0xff000000 : 0x00000000),
    );
  }

  static int randHex() {
    Random random = Random();
    double randomDouble = random.nextDouble();
    return (randomDouble * 0xFFFFFF).toInt();
  }

  static Color generateRandomColor({int? hex, double opacity = 1.0}) {
    return Color(hex ?? randHex()).withOpacity(opacity);
  }
}
