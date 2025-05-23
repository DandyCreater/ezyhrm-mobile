import 'dart:io';

import 'package:ezyhr_mobile_apps/module/notification/notification_service.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'shared/constant/color_constant.dart';
import 'shared/utils/common_util.dart';

class DependencyInjection {
  static String envName = '';
  static String versionApp = '';
  static String packageName = '';

  static const envLocal = 'LOCAL';
  static const envDev = 'DEV';
  static const envProd = 'PROD';

  static final isPortrait = false.obs;
  static final isLandscape = false.obs;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    tz.initializeTimeZones();
    initializeDateFormatting('id');
    HttpOverrides.global = _MyHttpOverrides();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    debugPrint('packageName=$packageName');

    await GetStorage.init();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.primaryDark,
      statusBarIconBrightness: Brightness.light,
    ));

    NotificationService.init();
  }
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

enum EnvEnum {
  local,
  dev,
  prod,
}

Future<EnvEnum> _loadEnv(String packageName) async {
  DependencyInjection.envName = DependencyInjection.envLocal;
  var envFile = "assets/env/.env_local";
  EnvEnum envEnum = EnvEnum.local;

  if (CommonUtil.equalsIgnoreCase(packageName, CommonConstant.devPackageId)) {
    DependencyInjection.envName = DependencyInjection.envDev;
    envFile = "assets/env/.env_dev";
    envEnum = EnvEnum.dev;
  } else if (CommonUtil.equalsIgnoreCase(
      packageName, CommonConstant.prodPackageId)) {
    DependencyInjection.envName = DependencyInjection.envProd;
    envFile = "assets/env/.env_prod";
    envEnum = EnvEnum.prod;
  }
  await dotenv.load(fileName: envFile);

  return envEnum;
}
