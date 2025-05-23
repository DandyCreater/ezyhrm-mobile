import 'package:ezyhr_mobile_apps/module/profile/app_info/app_info_page.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoC extends Bindings {
  static const route = '/appInfo';
  static final page = GetPage(
    name: route,
    page: () => const AppInfoPage(),
    binding: AppInfoC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<AppInfoController>(() => AppInfoController());
  }
}

class AppInfoController extends GetxController {
  Rxn<String> appName = Rxn<String>();
  Rxn<String> packageName = Rxn<String>();
  Rxn<String> version = Rxn<String>();
  Rxn<String> buildNumber = Rxn<String>();
  @override
  void onInit() {
    super.onInit();
    _getAppInfo();
  }

  void _getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    appName.value = info.appName;
    packageName.value = info.packageName;
    version.value = info.version;
    buildNumber.value = info.buildNumber;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
