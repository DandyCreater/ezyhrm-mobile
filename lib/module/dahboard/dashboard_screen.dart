import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const homeActive = 'assets/v2/bottom_menu/home_active.svg';
    const homeInactive = 'assets/v2/bottom_menu/home_inactive.svg';

    const calendarActive = 'assets/v2/bottom_menu/calendar_active.svg';
    const calendarInactive = 'assets/v2/bottom_menu/calendar_inactive.svg';

    const requestActive = 'assets/v2/bottom_menu/request_active.svg';
    const requestInactive = 'assets/v2/bottom_menu/request_inactive.svg';

    const dashboardActive = 'assets/v2/bottom_menu/movement_active.svg';
    const dashboardInactive = 'assets/v2/bottom_menu/movement_inactive.svg';

    const profileActive = 'assets/v2/bottom_menu/profile_active.svg';
    const profileInactive = 'assets/v2/bottom_menu/profile_inactive.svg';
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        body: Obx(() => Stack(
              children: <Widget>[
                controller.pages[controller.pageIdx.value],
              ],
            )),
        bottomNavigationBar: Obx(() => Container(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(213, 211, 211, 1),
                ),
              ),
              child: BottomNavigationBar(
                iconSize: 24,
                selectedLabelStyle: const TextStyle(
                  color: Color(0xFF545454),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Color(0xFF545454),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                selectedFontSize: 12,
                unselectedFontSize: 12,
                backgroundColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                onTap: controller.changePage,
                items: [
                  bottomMenu(homeActive, homeInactive, 'Home'),
                  bottomMenu(calendarActive, calendarInactive, "Calendar"),
                  bottomMenu(requestActive, requestInactive, "Request"),
                  bottomMenu(dashboardActive, dashboardInactive, " Movement"),
                  bottomMenu(profileActive, profileInactive, "Profile"),
                ],
                currentIndex: controller.pageIdx.value,
                selectedItemColor: Colors.green,
              ),
            )),
      ),
    );
  }
}

BottomNavigationBarItem bottomMenu(
    String activeIcon, String inactiveIcon, String label) {
  return BottomNavigationBarItem(
    icon: CommonWidget.imageWidget(
      path: inactiveIcon,
      imgPathType: ImgPathType.asset,
    ),
    label: label,
    activeIcon: CommonWidget.imageWidget(
      path: activeIcon,
      imgPathType: ImgPathType.asset,
    ),
  );
}

Widget bottomIcon(String icon) {
  return Container(
    child: CommonWidget.imageWidget(
      path: icon,
      imgPathType: ImgPathType.asset,
      width: 24,
      height: 24,
    ),
  );
}
