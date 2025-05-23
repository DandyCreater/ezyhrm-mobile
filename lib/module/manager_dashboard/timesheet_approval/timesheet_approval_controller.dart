import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_detail_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_page.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_service.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/variable_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimesheetApprovalC extends Bindings {
  static const route = '/timesheet-approval';
  static final page = GetPage(
    name: route,
    page: () => const TimesheetApprovalPage(),
    binding: TimesheetApprovalC(),
  );

  static const detailRoute = '/timesheet-approval-detail';
  static final detailPage = GetPage(
    name: detailRoute,
    page: () => const TimesheetApprovalDetailPage(),
    binding: TimesheetApprovalC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<TimesheetApprovalController>(
        () => TimesheetApprovalController());
  }
}

class TimesheetApprovalController extends GetxController {
  final sessionService = SessionService.instance;
  final reimbursementService = ReimbursementService.instance;
  final ManagerDashboardService managerDashboardService =
      ManagerDashboardService.instance;
  final timesheetService = TimesheetService.instance;

  BuildContext? context;

  final isLoading = false.obs;
  final months = VariableUtil.months.obs;
  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  final statuses = [
    'Init',
    'Pending',
    'Approved',
    'Permit for update',
    'Rejected',
    'Validated',
    'Rejected HR',
  ].obs;
  final selectedStatus = "Pending".obs;
  final selectedStatusNumber = 1.obs;

  final employeeList = Rxn<List<SupervisorEmployeeResponse>>();
  final currentEmployee = Rxn<SupervisorEmployeeResponse>();
  final timesheetApprovalList = Rxn<List<TimesheetApprovalDto>>();
  final timesheetList = Rxn<List<TimesheetDto>>();
  final currentTimesheetApproval = Rxn<TimesheetApprovalDto>();

  @override
  void onReady() {
    super.onReady();
    initYearList();

    getData();
  }

  void initYearList() {
    final year = DateTime.now().year;
    final yearListVal = List.generate(3, (index) => year - 1 + index);
    yearList.value = yearListVal.map((e) => e.toString()).toList();
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    selectedMonthNumber.value = VariableUtil.getMonthNumber(month);
    getData();
  }

  void setYear(int year) {
    selectedYear.value = year;
    getData();
  }

  void setCurrentEmployee(SupervisorEmployeeResponse employee) async {
    currentEmployee.value = employee;
    await getData();
    final tmpNewList = timesheetApprovalList.value!
        .where((element) => element.employee.employeeid == employee.employeeid)
        .toList();
    timesheetApprovalList.value = tmpNewList;
    timesheetApprovalList.refresh();
  }

  void setStatus(String status) {
    int x = 0;
    selectedStatus.value = status;
    if (status == "Init") {
      x = 0;
    } else if (status == 'Pending') {
      x = 1;
    } else if (status == 'Approved') {
      x = 2;
    } else if (status == 'Permit for update') {
      x = 3;
    } else if (status == 'Rejected') {
      x = 4;
    } else if (status == 'Validated') {
      x = 5;
    } else if (status == 'Rejected HR') {
      x = 6;
    }
    selectedStatusNumber.value = x;
    getData();
  }

  String getStatus(int status) {
    String x = "";
    if (status == 0) {
      x = "Init";
    } else if (status == 1) {
      x = 'Pending';
    } else if (status == 2) {
      x = 'Approved';
    } else if (status == 3) {
      x = 'Permit for update';
    } else if (status == 4) {
      x = 'Rejected';
    } else if (status == 5) {
      x = 'Validated';
    } else if (status == 6) {
      x = 'Rejected HR';
    }
    return x;
  }

  Color getStatusColor(int status) {
    Color x = Colors.black;
    if (status == 0) {
      x = Colors.grey;
    } else if (status == 1) {
      x = Colors.orange;
    } else if (status == 2) {
      x = Colors.green;
    } else if (status == 3) {
      x = Colors.blue;
    } else if (status == 4) {
      x = Colors.red;
    } else if (status == 5) {
      x = Colors.green;
    } else if (status == 6) {
      x = Colors.red;
    }
    return x;
  }

  Color getStatusBackgroundColor(int status) {
    Color x = Colors.grey[50]!;
    if (status == 0) {
      x = Colors.grey[50]!;
    } else if (status == 1) {
      x = Colors.orange[50]!;
    } else if (status == 2) {
      x = Colors.green[50]!;
    } else if (status == 3) {
      x = Colors.blue[50]!;
    } else if (status == 4) {
      x = Colors.red[50]!;
    } else if (status == 5) {
      x = Colors.green[50]!;
    } else if (status == 6) {
      x = Colors.red[50]!;
    }
    return x;
  }

  Future<void> getData() async {
    try {
      isLoading.value = true;
      await getEmployeeList();
      await getTimesheet();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setTimesheetApproval(TimesheetApprovalDto employee) async {
    currentTimesheetApproval.value = employee;
    RouteUtil.to(TimesheetApprovalC.detailRoute);
  }

  Future<void> getEmployeeList() async {
    try {
      isLoading.value = true;
      final response = await managerDashboardService
          .getSupervisorEmployee(sessionService.getEmployeeId());
      employeeList.value = response;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTimesheet() async {
    try {
      isLoading.value = true;
      var responses = await Future.wait(
        employeeList.value!.map(
          (e) => timesheetService.getEmployeeTimesheetByMonth(
            int.parse(e.employeeid),
            selectedMonthNumber.value,
            selectedYear.value,
          ),
        ),
      );
      List<TimesheetApprovalDto> list = [];

      for (var i = 0; i < employeeList.value!.length; i++) {
        if (responses[i].length > 0) {
          final firstResponse = responses[i].first.status ?? 0;
          final statusNum = selectedStatusNumber.value;
          final isTheSameStatus =
              firstResponse == statusNum && firstResponse != 0;
          if (isTheSameStatus) {
            list.add(
              TimesheetApprovalDto(
                status: firstResponse ?? 0,
                employee: employeeList.value![i],
                timesheetApprovalWeeklyDto: groupDaysIntoWeeksWithData(
                  selectedYear.value,
                  selectedMonthNumber.value,
                  responses[i],
                ),
              ),
            );
          }
        }
      }
      timesheetApprovalList.value = list;
      timesheetApprovalList.refresh();
    } catch (e) {
      print(e);
    }
  }

  List<TimesheetApprovalWeeklyDto> groupDaysIntoWeeksWithData(
      int year, int month, List<TimesheetDto> timesheetList) {
    List<TimesheetApprovalWeeklyDto> weeklyTimesheets = [];

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    DateTime currentWeekStart = firstDayOfMonth;
    DateTime currentWeekEnd = currentWeekStart.add(Duration(days: 6));

    while (currentWeekStart.isBefore(lastDayOfMonth) ||
        currentWeekStart.isAtSameMomentAs(lastDayOfMonth)) {
      if (currentWeekEnd.isAfter(lastDayOfMonth)) {
        currentWeekEnd = lastDayOfMonth;
      }

      List<TimesheetApprovalDailyDto> dailyTimesheets = [];
      for (DateTime day = currentWeekStart;
          day.isBefore(currentWeekEnd) || day.isAtSameMomentAs(currentWeekEnd);
          day = day.add(
        Duration(
          days: 1,
        ),
      ),) {
        final timesheet = timesheetList.firstWhere(
          (element) => element.date == day,
          orElse: () => TimesheetDto(
            date: day,
          ),
        );
        dailyTimesheets.add(
          TimesheetApprovalDailyDto(
            date: day,
            timesheet: timesheet,
          ),
        );
      }

      weeklyTimesheets.add(TimesheetApprovalWeeklyDto(
        startDate: currentWeekStart,
        endDate: currentWeekEnd,
        timesheet: dailyTimesheets,
      ));

      currentWeekStart = currentWeekEnd.add(Duration(days: 1));
      currentWeekEnd = currentWeekStart.add(Duration(days: 6));
    }

    return weeklyTimesheets;
  }

  List<TimesheetDto> getCurrentTimesheetSubmit() {
    final List<TimesheetDto> timesheetList = [];
    for (var i = 0; i < timesheetApprovalList.value!.length; i++) {
      final weeklyTimesheet =
          timesheetApprovalList.value![i].timesheetApprovalWeeklyDto;
      for (var j = 0; j < weeklyTimesheet.length; j++) {
        for (var k = 0; k < weeklyTimesheet[j].timesheet.length; k++) {
          final dailyTimesheet = weeklyTimesheet[j].timesheet[k];
          if (dailyTimesheet.timesheet.id == null) {
            dailyTimesheet.timesheet.employeeId =
                int.parse(timesheetApprovalList.value![i].employee.employeeid);
            dailyTimesheet.timesheet.year = weeklyTimesheet[j].startDate.year;
            dailyTimesheet.timesheet.day = dailyTimesheet.date.day;
            dailyTimesheet.timesheet.week =
                weeklyTimesheet[j].startDate.weekday;
            dailyTimesheet.timesheet.workHours = 0;
            dailyTimesheet.timesheet.otHours = 0;
            dailyTimesheet.timesheet.remark = "";
            dailyTimesheet.timesheet.createdBy = sessionService.getEmployeeId();
            dailyTimesheet.timesheet.createdAt = DateTime.now();
            dailyTimesheet.timesheet.updatedBy = sessionService.getEmployeeId();
            dailyTimesheet.timesheet.updatedAt = DateTime.now();
            dailyTimesheet.timesheet.endTime = "00:00";
            dailyTimesheet.timesheet.startTime = "00:00";
            dailyTimesheet.timesheet.breakTime = "0";
            dailyTimesheet.timesheet.docNo = "";
          }
          timesheetList.add(dailyTimesheet.timesheet);
        }
      }
    }
    return timesheetList;
  }

  Future<void> approveTimesheet() async {
    try {
      isLoading.value = true;
      final tmpTimesheetList = getCurrentTimesheetSubmit();
      for (var i = 0; i < tmpTimesheetList.length; i++) {
        tmpTimesheetList[i].status = 2;
      }

      final submittedTimesheet =
          tmpTimesheetList.where((element) => element.id != null).toList();
      final nonSubmittedTimesheet =
          tmpTimesheetList.where((element) => element.id == null).toList();

      final response =
          await timesheetService.createTimesheet(nonSubmittedTimesheet);
      final response2 =
          await timesheetService.updateTimesheet(submittedTimesheet);
      await getData();
      CommonWidget.showNotif(
        "Success approving timesheet",
      );
      Get.back();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectTimesheet() async {
    try {
      isLoading.value = true;
      final tmpTimesheetList = getCurrentTimesheetSubmit();
      for (var i = 0; i < tmpTimesheetList.length; i++) {
        tmpTimesheetList[i].status = 3;
      }

      final submittedTimesheet =
          tmpTimesheetList.where((element) => element.id != null).toList();
      final nonSubmittedTimesheet =
          tmpTimesheetList.where((element) => element.id == null).toList();

      final response =
          await timesheetService.createTimesheet(nonSubmittedTimesheet);
      final response2 =
          await timesheetService.updateTimesheet(submittedTimesheet);
      await getData();
      CommonWidget.showNotif(
        "Success rejecting timesheet",
      );
      Get.back();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
