import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/attendance/list_attendance/attendance_detail_screen.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'list_attendance_screen.dart';

class ListAttendanceC extends Bindings {
  static const route = '/list-attendance';
  static final page = GetPage(
    name: route,
    page: () => const ListAttendanceScreen(),
    binding: ListAttendanceC(),
  );

  static const attendanceDetailsRoute = '/attendance-details';
  static final attendanceDetailsPage = GetPage(
    name: attendanceDetailsRoute,
    page: () => const AttendanceDetailsPage(),
    binding: ListAttendanceC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ListAttendanceController>(() => ListAttendanceController());
  }
}

class ListAttendanceController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    setYearList();

    getData();
  }

  @override
  void onInit() {
    super.onInit();
    setYearList();

    getData();
  }

  Future<void> getData() async {
    await getAttendance();
  }

  final isApproved = true.obs;
  void setApproved() {
    isApproved.value = true;
  }

  void setRequest() {
    isApproved.value = false;
  }

  void setCurrentAttendance(AttendanceData attandance) {
    currentAttendance.value = attandance;
  }

  void setYear(int year) {
    selectedYear.value = year;
    getData();
  }

  void setMonth(String month) {
    int x = 0;
    selectedMonth.value = month;
    if (month == 'January') {
      x = 1;
    } else if (month == 'February') {
      x = 2;
    } else if (month == 'March') {
      x = 3;
    } else if (month == 'April') {
      x = 4;
    } else if (month == 'May') {
      x = 5;
    } else if (month == 'June') {
      x = 6;
    } else if (month == 'July') {
      x = 7;
    } else if (month == 'August') {
      x = 8;
    } else if (month == 'September') {
      x = 9;
    } else if (month == 'October') {
      x = 10;
    } else if (month == 'November') {
      x = 11;
    } else if (month == 'December') {
      x = 12;
    }
    selectedMonthNumber.value = x;
    getData();
  }

  final isLoading = true.obs;

  final attendanceService = AttendanceService.instance;
  final sessionService = SessionService.instance;

  final attendance = Rxn<AttendanceResponse>();
  final currentAttendance = Rxn<AttendanceData>();

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  final RxList<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ].obs;

  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;

  BuildContext? context;

  void setYearList() {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

  Future<void> getAttendance() async {
    try {
      isLoading.value = true;
      final response =
          await attendanceService.getAttendance(sessionService.getEmployeeId());
      final x = response.data!.where((element) =>
          element.checkinDate!.year == selectedYear.value &&
          element.checkinDate!.month == selectedMonthNumber.value);
      response.data = x.toList();
      attendance.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void getAttendanceApproved() async {
    try {
      isLoading.value = true;
      final response =
          await attendanceService.getAttendance(sessionService.getEmployeeId());
      final responseData =
          response.data!.where((element) => element.status == 3);
      response.data = responseData.toList();
      attendance.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void getNonApprovedAttendance() async {
    try {
      isLoading.value = true;
      final response =
          await attendanceService.getAttendance(sessionService.getEmployeeId());
      final responseData =
          response.data!.where((element) => element.status != 3);
      response.data = responseData.toList();
      attendance.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
