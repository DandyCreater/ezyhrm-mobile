import 'dart:developer';

import 'package:ezyhr_mobile_apps/shared/services/init_app_service.dart';
import 'package:get/get.dart';

import 'splash_screen.dart';

class SplashC extends Bindings {
  static const route = '/';
  static final page = GetPage(
    name: route,
    page: () => const SplashScreen(),
    binding: SplashC(),
  );

  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _initAppService.initApp(false, isSplash: true);
    log('onReady');
  }

  final _initAppService = InitAppService.instance;
}
