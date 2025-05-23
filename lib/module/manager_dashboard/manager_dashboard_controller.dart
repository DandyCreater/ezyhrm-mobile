import 'dart:async';
import 'dart:core';

import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/variable_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerDashboardC extends Bindings {
  static const route = '/manager-dashboard';
  static final page = GetPage(
    name: route,
    page: () => const ManagerDashboardScreen(),
    binding: ManagerDashboardC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ManagerDashboardController>(() => ManagerDashboardController());
  }
}

class ManagerDashboardController extends GetxController {
  BuildContext? context;

  final isLoading = false.obs;
  final months = VariableUtil.months.obs;
  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  final sessionService = SessionService.instance;
  final AttendanceService attendanceService = AttendanceService.instance;
  final ManagerDashboardService managerDashboardService =
      ManagerDashboardService.instance;
  final profileService = ProfileService.instance;
  final timesheetService = TimesheetService.instance;

  final employeeList = Rxn<List<SupervisorEmployeeResponse>>();
  final attendanceApprovalDto = Rxn<List<AttendanceApprovalDto>>();

  final currentAttendanceApprovalDto = Rxn<AttendanceApprovalDto>();
  final currentEmployee = Rxn<SupervisorEmployeeResponse>();
  final isWaitingAPproval = true.obs;

  final totalWorkHour = 0.0.obs;
  final totalOtHour = 0.0.obs;

  final profilePicture = "https://ezyhr.rmagroup.com.sg/img/blank.png".obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onReady() async {
    super.onReady();
    await getData();
  }

  void startTimer() {
    const duration = Duration(seconds: 15);
    _timer = Timer.periodic(duration, (_) {
      getData();
    });
  }

  Future<void> getData() async {
    isLoading.value = true;
    await getEmployeeList();
    await getAttendanceToday();
    isLoading.value = false;
  }

  Future<void> getEmployeeList() async {
    try {
      isLoading.value = true;
      final response = await managerDashboardService
          .getSupervisorEmployee(sessionService.getEmployeeId());
      employeeList.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setCurrentAttendanceApproval(
      AttendanceApprovalDto attendanceApprovalDto) {
    currentAttendanceApprovalDto.value = attendanceApprovalDto;
    currentEmployee.value = attendanceApprovalDto.employeeList;
  }

  Future<void> getAttendanceToday() async {
    List<AttendanceApprovalDto> attendanceApprovalDtoList = [];

    if (employeeList.value == null) {
      return;
    }

    var responsesFutures = employeeList.value!.map((e) async {
      try {
        return await attendanceService.getAttendance(int.parse(e.employeeid));
      } catch (error) {
        return null;
      }
    }).toList();

    var attendanceResponses =
        await Future.wait(responsesFutures, eagerError: false);

    var profilePictureFutures = employeeList.value!.map((e) async {
      try {
        return await profileService.getProfilePicture(int.parse(e.employeeid));
      } catch (error) {
        return "https://ezyhr.rmagroup.com.sg/img/blank.png";
      }
    }).toList();

    var profilePictureResponses =
        await Future.wait(profilePictureFutures, eagerError: false);

    var timesheetFutures = employeeList.value!.map((e) async {
      try {
        return await timesheetService
            .getTimesheetWorkHour(int.parse(e.employeeid));
      } catch (e) {
        return null;
      }
    }).toList();

    var timesheetResponses =
        await Future.wait(timesheetFutures, eagerError: false);

    var tmpTotalWorkHourAll = 0.0;
    var tmpTotalOtHourAll = 0.0;
    for (var i = 0; i < employeeList.value!.length; i++) {
      var attendanceResponse = attendanceResponses[i];
      var profilePictureResponse = profilePictureResponses[i];

      if (attendanceResponse != null && attendanceResponse.data != null) {
        for (var attendanceData in attendanceResponse.data!) {
          if (!isToday(attendanceData.checkinDate!)) {
            continue;
          }
          attendanceApprovalDtoList.add(AttendanceApprovalDto(
            employeeList: employeeList.value![i],
            attendanceResponse: attendanceData,
            profilePicture: profilePictureResponse,
            timesheetWorkHourResponse: timesheetResponses[i],
          ));
          if (attendanceData.status == 3 &&
              attendanceData.checkinDate != null &&
              attendanceData.checkoutDate != null) {
            var tmpWorkMin = attendanceData.checkoutDate!
                .difference(attendanceData.checkinDate!)
                .inMinutes;
            var tmpWorkHour = tmpWorkMin / 60;
            if (timesheetResponses[i]?.hourlyType != "Weekly") {
              if (timesheetResponses[i]?.workHour != null) {
                if (tmpWorkHour > timesheetResponses[i]!.workHour!) {
                  tmpTotalOtHourAll +=
                      tmpWorkHour - timesheetResponses[i]!.workHour!;
                }
              } else {
                if (tmpWorkHour > 8) {
                  tmpTotalOtHourAll += tmpWorkHour - 8;
                }
              }
            }
            tmpTotalWorkHourAll += tmpWorkHour;
          }
        }
      }
    }

    totalWorkHour.value = tmpTotalWorkHourAll;
    totalOtHour.value = tmpTotalOtHourAll;

    attendanceApprovalDto.value = attendanceApprovalDtoList;
    attendanceApprovalDto.refresh();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
  }

  MaterialColor getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color getBackgroundStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue[50]!;
      case 1:
        return Colors.grey[50]!;
      case 2:
        return Colors.blue[50]!;
      case 3:
        return Colors.green[50]!;
      default:
        return Colors.grey[50]!;
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
}
