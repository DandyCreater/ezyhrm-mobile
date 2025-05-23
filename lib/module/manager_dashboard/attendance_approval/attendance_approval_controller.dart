import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_detail.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/variable_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceApprovalC extends Bindings {
  static const route = '/attendance-approval';
  static final page = GetPage(
    name: route,
    page: () => const AttendanceApprovalPage(),
    binding: AttendanceApprovalC(),
  );

  static const detailRoute = '/attendance-approval-detail';
  static final detailPage = GetPage(
    name: detailRoute,
    page: () => const AttendanceApprovalDetailScreen(),
    binding: AttendanceApprovalC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<AttendanceApprovalController>(
        () => AttendanceApprovalController());
  }
}

class AttendanceApprovalController extends GetxController {
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

  final employeeList = Rxn<List<SupervisorEmployeeResponse>>();
  final attendanceApprovalDto = Rxn<List<AttendanceApprovalDto>>();

  final currentAttendanceApprovalDto = Rxn<AttendanceApprovalDto>();
  final currentEmployee = Rxn<SupervisorEmployeeResponse>();
  final isWaitingAPproval = true.obs;

  final profilePicture = "https://ezyhr.rmagroup.com.sg/img/blank.png".obs;
  void onReady() async {
    super.onReady();
    try {
      if (Get.arguments["attendanceApprovalDto"] != null) {
        currentAttendanceApprovalDto.value =
            Get.arguments["attendanceApprovalDto"];
        currentAttendanceApprovalDto.refresh();
      }
    } catch (e) {
      print(e);
    }
    await getData();
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
        return null;
      }
    }).toList();

    var profilePictureResponses =
        await Future.wait(profilePictureFutures, eagerError: false);

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
          ));
        }
      }
    }

    attendanceApprovalDto.value = attendanceApprovalDtoList;
    attendanceApprovalDto.refresh();
  }

  void setCurrentAttendanceApprovalDto(AttendanceApprovalDto dto) {
    currentAttendanceApprovalDto.value = dto;
    currentAttendanceApprovalDto.refresh();
  }

  void setYearList() {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

  void setYear(int year) {
    selectedYear.value = year;
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    selectedMonthNumber.value = VariableUtil.getMonthNumber(month);
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
