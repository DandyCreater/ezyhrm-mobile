import 'dart:async';

import 'package:ezyhr_mobile_apps/di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import 'module/splash/splash_controller.dart';
import 'shared/routes/app_pages.dart';
import 'shared/theme/default_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await DependencyInjection.init();
    runApp(_app);
  }, _onError);
}

Widget get _app => OverlaySupport.global(
      child: GetMaterialApp(
        title: 'EZYHRM',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashC.route,
        getPages: AppPages.routes,
        theme: DefaultTheme.light,
        defaultTransition: Transition.fade,
      ),
    );

void _onError(Object error, StackTrace stack) {
  debugPrint('error run zone: $error');
  debugPrint('error stack zone: $stack');
}
