import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:timezone/standalone.dart' as tz;
import 'package:uuid/uuid.dart';

class CommonUtil {
  static String initialName(String name) {
    if (isBlank(name)) {
      return '';
    }
    final s = name.trim().toUpperCase().split(' ');
    String r = '';
    for (final e in s) {
      r = r + e.substring(0, 1);
    }
    return r;
  }

  static String displyForEditPhone(String par) {
    var phone = '';
    if (par.substring(0, 1) == '0') {
      phone = par.replaceRange(0, 1, '');
    }
    return phone;
  }

  static void unFocus({BuildContext? context}) {
    FocusScopeNode currentFocus = FocusScope.of(context ?? Get.context!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String dateIdnToStr({
    DateTime? dateTime,
    String format = 'dd MMMM yyyy',
    bool isConvertZone = false,
    String zoneName = 'Asia/Jakarta',
  }) {
    var t = dateTime ?? DateTime.now();
    if (isConvertZone) {
      final zone = tz.getLocation(zoneName);
      final tc = tz.TZDateTime.from(t, zone);
      debugPrint("timeLocal=$t timeConverted=$tc");
      return DateFormat(format, 'id_ID').format(tc);
    }
    return DateFormat(format, 'id_ID').format(t);
  }

  static DateTime strToDate(String date,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateTime.parse(date);
  }

  static String strDateToStr(String date,
      {String formatResult = 'yyyy-MM-dd HH:mm:ss'}) {
    return dateIdnToStr(dateTime: strToDate(date), format: formatResult);
  }

  static List<TextInputFormatter> inputFormatNumber() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
      TextInputFormatter.withFunction((oldValue, newValue) {
        try {
          final text = newValue.text;
          if (text.isNotEmpty) double.parse(text);
          return newValue;
        } catch (e) {
          debugPrint('$e');
        }
        return oldValue;
      }),
    ];
  }

  static bool equalsIgnoreCase(String source, String target) {
    return source.toLowerCase() == target.toLowerCase();
  }

  static bool containsIgnoreCase(String text, String containing) {
    return text.toLowerCase().contains(containing.toLowerCase());
  }

  static Future<void> delay({int millisecond = 1000}) async {
    await Future.delayed(Duration(milliseconds: millisecond));
  }

  static String generateUuid() {
    return const Uuid().v4();
  }

  static const upC = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final lowC = upC.toLowerCase();
  static const numr = '1234567890';

  static String getRandomString(
      {int length = 5, List<String> ch = const [upC, numr]}) {
    final c = ch.join();
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => c.codeUnitAt(r.nextInt(c.length))));
  }

  static String getExtensionFile(String path) {
    return p.extension(path);
  }

  static String formatTimer(int seconds) {
    if (seconds >= 3600) {
      return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
    }
    return '${(Duration(seconds: seconds))}'
        .split('.')[0]
        .padLeft(8, '0')
        .substring(3);
  }

  static T? firstWhereEqStr<T>(
      Iterable<T?>? list, String? Function(T? t) sourceAttrEq, String? eq,
      {bool isEqIgnCs = true}) {
    Iterable<T?>? r = [];
    if (isEqIgnCs) {
      r = list?.where(
              (e) => equalsIgnoreCase(sourceAttrEq(e) ?? 'x', eq ?? 'y')) ??
          [];
    } else {
      r = list?.where((e) => (sourceAttrEq(e) ?? 'x') == (eq ?? 'y')) ?? [];
    }
    if (r.isEmpty) {
      return null;
    }
    return r.first;
  }

  static bool isNotBlank(dynamic data) {
    if (data != null) {
      if ((data is String && data.isEmpty) || (data is List && data.isEmpty)) {
        return false;
      }
      return true;
    }
    return false;
  }

  static bool isBlank(dynamic data) {
    if (data != null) {
      if ((data is String && data.isEmpty) || (data is List && data.isEmpty)) {
        return true;
      }
      return false;
    }
    return true;
  }

  static bool isNull(dynamic data) {
    return data == null;
  }

  static bool isEmpty(dynamic data) {
    if (data != null) {
      if ((data is String && data.isEmpty) || (data is List && data.isEmpty)) {
        return true;
      }
      return false;
    }
    return false;
  }

  static bool eqIgnoreCaseOr(String source, List<String> target) {
    bool b = false;
    for (final t in target) {
      if (equalsIgnoreCase(source, t)) {
        b = true;
        break;
      }
    }
    return b;
  }

  static String removePrefixPhone(String phone) {
    phone = phone.trim();
    for (final e in ['+62', '62', '0']) {
      if (phone.startsWith(e)) {
        phone = phone.replaceFirst(e, '');
        break;
      }
    }
    return phone;
  }
}

extension ObjectRxnExtension<T> on Rxn<T> {
  bool get isEmpty => CommonUtil.isEmpty(value);

  bool get isNotBlank => CommonUtil.isNotBlank(value);

  bool get isBlank => CommonUtil.isBlank(value);

  bool get isNull => CommonUtil.isNull(value);
}

extension ObjectExtension<T> on T {
  bool get isEmpty => CommonUtil.isEmpty(this);

  bool get isNotBlank => CommonUtil.isNotBlank(this);

  bool get isBlank => CommonUtil.isBlank(this);

  bool get isNull => CommonUtil.isNull(this);
}
