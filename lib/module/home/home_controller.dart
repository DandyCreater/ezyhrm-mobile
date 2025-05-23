import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_response.dart';
import 'package:ezyhr_mobile_apps/module/home/home_screen.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/nhc_form_details_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_hrms_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeC extends Bindings {
  static const route = '/home';
  static final page = GetPage(
    name: route,
    page: () => const HomeScreen(),
    binding: HomeC(),
  );
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.put(ProfileController());
  }
}

class HomeController extends GetxController {
  BuildContext? context;

  final sessionService = SessionService.instance;

  final isLoading = false.obs;
  final profileService = ProfileService.instance;
  final profileHrms = Rxn<ProfileHrmsResponse>();
  final profilePicture = "https://ezyhr.rmagroup.com.sg/img/blank.png".obs;
  final nhcFormDetails = Rxn<NhcFormDetailsResponse>();
  var currentTime = DateTime.now().obs;

  final attendanceService = AttendanceService.instance;
  final managerDashboardService = ManagerDashboardService.instance;

  final attendance = Rxn<AttendanceResponse>();
  final currentAttendance = Rxn<AttendanceData>();
  final supervisoredEmployee = Rxn<List<SupervisorEmployeeResponse>>();

  @override
  void onReady() {
    super.onReady();
    OtpResponse? otpResponse = sessionService.getOtpResponse();
    log("otpResponse: ${otpResponse?.toJson()}");
    getData();
  }

  var isVisible = true.obs;

  void toggleVisibility() {
    isVisible(!isVisible.value);
  }

  @override
  void onInit() {
    updateTime();
    super.onInit();
  }

  void updateTime() {
    Future.delayed(Duration(seconds: 1), () {
      currentTime.value = DateTime.now();
      updateTime();
    });
  }

  Future<void> getData() async {
    getProfile();
    getSupervisoredEmployee();
    getNhcFormDetails();
    getAttendance();
  }

  Future<void> getSupervisoredEmployee() async {
    try {
      isLoading.value = true;
      final response = await managerDashboardService
          .getSupervisorEmployee(sessionService.getEmployeeId());
      supervisoredEmployee.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final response =
          await profileService.getProfileHrms(sessionService.getEmployeeId());
      final profilePictureResponse = await profileService
          .getProfilePicture(sessionService.getEmployeeId());
      profileHrms.value = response;
      profilePicture.value = profilePictureResponse!;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNhcFormDetails() async {
    try {
      isLoading.value = true;
      final response = await profileService.getNhcFormDetails(
        sessionService.getEmployeeId(),
      );
      nhcFormDetails.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (DateTime.now().hour >= 6 && DateTime.now().hour < 12) {
      return 'Morning';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  Future<void> getAttendance() async {
    try {
      isLoading.value = true;
      final response =
          await attendanceService.getAttendance(sessionService.getEmployeeId());
      if (response.data == null) {
        return;
      }
      attendance.value = response;
      final x = response.data?.where((element) =>
          element.checkinDate?.year == DateTime.now().year &&
          element.checkinDate?.month == DateTime.now().month &&
          element.checkinDate?.day == DateTime.now().day);
      response.data = x?.toList();
      attendance.value = response;

      final pp = attendance.value != null;
      final ww = attendance.value?.data?.isNotEmpty ?? false;
      print('pp ${pp}');
      print('ww ${ww}');
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  bool isUserCheckIn() {
    try {
      return attendance.value!.data!.first.checkoutDate == null;
    } catch (e) {
      return false;
    }
  }

  String getStatus(int status) {
    switch (status) {
      case 0:
        return "New";
      case 1:
        return "Init";
      case 2:
        return "Checkin Only";
      case 3:
        return "Complete";
      default:
        return "New";
    }
  }

  Color getBackgroundStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue[50]!;
      case 1:
        return Colors.grey[50]!;
      case 2:
        return Colors.pink[50]!;
      case 3:
        return Colors.green[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  MaterialColor getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.pink;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getInstanceByCode(String instanceCode) {
    if (instanceCode == "IF") {
      return "Infoworks";
    } else if (instanceCode == "PR") {
      return "Projects";
    } else if (instanceCode == "CTR") {
      return "Contracts";
    } else if (instanceCode == "CST") {
      return "Consultants";
    } else if (instanceCode == "SL") {
      return "Solusi";
    } else if (instanceCode == "LTE") {
      return "LTE";
    } else if (instanceCode == "SG") {
      return "RMA Singapore";
    } else if (instanceCode == "MY") {
      return "RMA Malaysia";
    } else if (instanceCode == "VN") {
      return "RMA Vietnam";
    } else if (instanceCode == "ID") {
      return "RMA Indonesia";
    } else if (instanceCode == "SL") {
      return "Solusi";
    } else if (instanceCode == "IF") {
      return "Infoworks";
    }
    return instanceCode;
  }
}
