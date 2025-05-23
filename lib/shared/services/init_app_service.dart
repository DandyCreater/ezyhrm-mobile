import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';

class InitAppService {
  static InitAppService instance = InitAppService._();
  InitAppService._();
  factory InitAppService() => instance;

  Future<void> initApp(bool isOfflinePage, {bool isSplash = false}) async {
    if (isSplash) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    await RouteUtil.offAll(DashboardC.route);
  }
}
