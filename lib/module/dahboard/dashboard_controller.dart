import 'dart:core';

import 'package:ezyhr_mobile_apps/module/calendar/calendar_controller.dart';
import 'package:ezyhr_mobile_apps/module/calendar/calendar_page.dart';
import 'package:ezyhr_mobile_apps/module/home/home_controller.dart';
import 'package:ezyhr_mobile_apps/module/home/home_screen.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_screen.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_controller.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_page.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_screen.dart';

class DashboardC extends Bindings {
  static const route = '/dashboard';
  static final page = GetPage(
    name: route,
    page: () => const DashboardScreen(),
    binding: DashboardC(),
  );

  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(CalendarControllerMain());
    Get.put(HomeController());
    Get.put(ManagerDashboardC());
    Get.put(StaffMovementController());
    Get.put(ProfileController());
  }
}

class DashboardController extends GetxController {
  final requestWidget = RequestWidget();
  List<Widget> get pages {
    List<Widget> menus = [
      const HomeScreen(),
      const CalendarScreen(),
      const HomeScreen(),
      const StaffMovementView(),
      const ProfileScreen(),
    ];
    return menus;
  }

  final pageIdx = 0.obs;

  void changePage(int index) {
    if (index == 2) {
      requestWidget.showRequest();
    } else {
      pageIdx.value = index;
    }
  }

  DateTime? currentBackPressTime;
  BuildContext? context;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: CommonWidget.textPrimaryWidget('Back again to exit'),
          duration: const Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class RequestWidget {
  void showRequest() {
    Get.bottomSheet(Container(
      height: SizeUtil.f(Get.height * .34),
      padding: const EdgeInsets.only(top: 18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        color: ColorConstant.grey0,
      ),
      child: Column(children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  'Request',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ColorConstant.grey70,
                ),
                const Spacer(),
                GestureDetector(
                  child: const Icon(
                    Icons.close,
                    size: 24,
                  ),
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  RouteUtil.to("/leave-request");
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: SizeUtil.f(50),
                        width: SizeUtil.f(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorConstant.grey20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                              child: Icon(Icons.calendar_today_outlined,
                                  color: ColorConstant.primary, size: 24)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: CommonWidget.textPrimaryWidget(
                          'Request Leave',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  RouteUtil.to("/attendance");
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: SizeUtil.f(50),
                        width: SizeUtil.f(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorConstant.grey20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                              child: Icon(Icons.how_to_reg,
                                  color: ColorConstant.primary, size: 24)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: CommonWidget.textPrimaryWidget(
                          'Attendance',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  RouteUtil.to("/reimbursement-form");
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: SizeUtil.f(50),
                        width: SizeUtil.f(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorConstant.grey20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                              child: Icon(Icons.attach_money_outlined,
                                  color: ColorConstant.primary, size: 24)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: CommonWidget.textPrimaryWidget(
                          'Reimbursement',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  RouteUtil.to("/timesheetList");
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: SizeUtil.f(50),
                        width: SizeUtil.f(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorConstant.grey20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                              child: Icon(Icons.more_time_rounded,
                                  color: ColorConstant.primary, size: 24)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: CommonWidget.textPrimaryWidget(
                          'Manual Timesheet',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ))
      ]),
    ));
  }
}
