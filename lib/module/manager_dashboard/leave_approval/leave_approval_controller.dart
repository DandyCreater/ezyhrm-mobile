import 'dart:async';

import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_detail_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_hrms_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/variable_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveApprovalC extends Bindings {
  static const route = '/leave-approval';
  static final page = GetPage(
    name: route,
    page: () => const LeaveApprovalPage(),
    binding: LeaveApprovalC(),
  );

  static const detailRoute = '/leave-approval-detail';
  static final detailPage = GetPage(
    name: detailRoute,
    page: () => const LeaveApprovalDetailPage(),
    binding: LeaveApprovalC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<LeaveApprovalController>(() => LeaveApprovalController());
  }
}

class LeaveApprovalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  BuildContext? context;

  final isLoading = false.obs;
  final months = VariableUtil.months.obs;
  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  final leaveTypeList = Rxn<List<LeaveTypeResponse>>();

  final sessionService = SessionService.instance;
  final LeaveRequestService leaveRequestService = LeaveRequestService.instance;
  final ManagerDashboardService managerDashboardService =
      ManagerDashboardService.instance;
  final profileService = ProfileService.instance;

  final employeeList = Rxn<List<SupervisorEmployeeResponse>>();
  final leaveApprovalDto = Rxn<List<LeaveApprovalDto>>();
  final currentLeaveApproval = Rxn<LeaveApprovalDto>();
  final currentEmployee = Rxn<SupervisorEmployeeResponse>();
  final currentApprovalPerson = Rxn<ProfileHrmsResponse>();
  final isWaitingApproval = true.obs;
  final tabIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    await getLeaveType();
    await getEmployeeList();
    await getEmployeeLeave(
        employeeList.value!.map((e) => e.employeeid).toList());
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

  Future<void> getEmployeeLeave(List<String> employeeIds) async {
    List<LeaveApprovalDto> tmpList = [];
    var responses = await Future.wait(employeeIds.map((e) =>
        leaveRequestService.getEmployeeLeaveByYearMonth(
            int.parse(e), selectedYear.value, selectedMonthNumber.value)));
    for (var i = 0; i < responses.length; i++) {
      final responseList = responses[i];
      for (var j = 0; j < responseList.length; j++) {
        final response = responseList[j];
        final emp = employeeList.value?.firstWhere(
          (element) => int.parse(element.employeeid) == response.employeeId,
        );
        final dto = LeaveApprovalDto(
          employeeLeaveResponse: response,
          employeeList: emp,
        );
        tmpList.add(dto);
      }
    }

    final tmpNewList = tmpList
        .where((element) =>
            element.employeeLeaveResponse!.status == selectedStatusNumber.value)
        .toList();
    tmpList = tmpNewList;
    leaveApprovalDto.value = tmpList;
    leaveApprovalDto.refresh();
  }

  Future<void> getLeaveType() async {
    final response = await leaveRequestService.getLeaveType();
    leaveTypeList.value = response;
  }

  LeaveTypeResponse findById(int id) {
    if (leaveTypeList.value == null) {
      return LeaveTypeResponse();
    }
    return leaveTypeList.value!.firstWhere((element) => element.id == id);
  }

  Future<void> setCurrentLeaveApproval(LeaveApprovalDto dto) async {
    try {
      final res = await profileService.getProfileHrms(
          (dto.employeeLeaveResponse?.confirmedBy ?? 0).toInt());
      currentApprovalPerson.value = res;
      currentLeaveApproval.value = dto;
      Get.toNamed(
        "/leave-approval-detail",
        arguments: dto.employeeLeaveResponse,
      );
    } catch (e) {
      print(e);
      CommonWidget.showErrorNotif("Something went wrong, please try again");
    } finally {
      isLoading.value = false;
    }
  }

  void setYearList() {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

  void setYear(int year) {
    selectedYear.value = year;
    getData();
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    selectedMonthNumber.value = VariableUtil.getMonthNumber(month);
    getData();
  }

  void setCurrentEmployee(SupervisorEmployeeResponse employee) {
    currentEmployee.value = employee;
    final tmpNewList = leaveApprovalDto.value!
        .where((element) =>
            element.employeeList!.employeeid == employee.employeeid)
        .toList();
    leaveApprovalDto.value = tmpNewList;
    leaveApprovalDto.refresh();
  }

  final statuses = [
    'Pending',
    'Cancelled',
    'Approved',
    'Rejected',
  ].obs;
  final selectedStatus = "Pending".obs;
  final selectedStatusNumber = 2.obs;

  void setStatus(String status) {
    int x = 0;
    selectedStatus.value = status;
    if (status == "Inactive") {
      x = 0;
    } else if (status == 'Active') {
      x = 1;
    } else if (status == 'Pending') {
      x = 2;
    } else if (status == 'Cancelled') {
      x = 3;
    } else if (status == 'Approved') {
      x = 4;
    } else if (status == 'Rejected') {
      x = 5;
    }
    selectedStatusNumber.value = x;
    getData();
  }

  String getStatus(int status) {
    switch (status) {
      case 0:
        return "INACTIVE";
      case 1:
        return "ACTIVE";
      case 2:
        return "PENDING";
      case 3:
        return "CANCELED";
      case 4:
        return "APPROVED";
      case 5:
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }

  MaterialColor getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      case 4:
        return Colors.green;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getBackgrounStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey[50]!;
      case 1:
        return Colors.green[50]!;
      case 2:
        return Colors.orange[50]!;
      case 3:
        return Colors.red[50]!;
      case 4:
        return Colors.green[50]!;
      case 5:
        return Colors.red[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  String getLeaveId(int id) {
    if (id == 2) {
      return 'AM';
    } else if (id == 3) {
      return 'PM';
    } else {
      return 'Whole Day';
    }
  }

  void approveLeave() async {
    try {
      isLoading.value = true;
      currentLeaveApproval.value?.employeeLeaveResponse?.confirmedBy =
          sessionService.getEmployeeId();

      currentLeaveApproval.value?.employeeLeaveResponse?.updatedAt =
          DateTime.now();
      currentLeaveApproval.value?.employeeLeaveResponse?.updatedBy =
          sessionService.getEmployeeId();
      currentLeaveApproval.value?.employeeLeaveResponse?.status = 4;
      final response = await leaveRequestService.updateLeaveRequest(
        currentLeaveApproval.value!.employeeLeaveResponse!,
      );
    } catch (e) {
      print(e);
    } finally {
      getData();
      RouteUtil.back();
      CommonWidget.showNotif('Leave request has been approved',
          color: Colors.green);
      isLoading.value = false;
    }
  }

  void rejectLeave() async {
    try {
      isLoading.value = true;
      currentLeaveApproval.value?.employeeLeaveResponse?.confirmedBy =
          sessionService.getEmployeeId();

      currentLeaveApproval.value?.employeeLeaveResponse?.updatedAt =
          DateTime.now();
      currentLeaveApproval.value?.employeeLeaveResponse?.updatedBy =
          sessionService.getEmployeeId();
      currentLeaveApproval.value?.employeeLeaveResponse?.status = 5;
      final response = await leaveRequestService.updateLeaveRequest(
        currentLeaveApproval.value!.employeeLeaveResponse!,
      );
    } catch (e) {
      print(e);
    } finally {
      getData();
      RouteUtil.back();
      CommonWidget.showNotif('Leave request has been rejected',
          color: Colors.red);
      isLoading.value = false;
    }
  }

  void filterWaitingApproval() async {
    isWaitingApproval.value = true;
    await getData();
  }

  void filterApproved() async {
    isWaitingApproval.value = false;
    await getData();
  }

  void filterRejected() async {
    await getData();
  }
}
