import 'package:ezyhr_mobile_apps/module/leave_request/list_leave_request/leave_balance_page.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_prorate_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/list_leave_request/leave_request_detail.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/table_leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_leave_request_screen.dart';

class LeaveRequestC extends Bindings {
  static const route = '/leave';
  static final page = GetPage(
    name: route,
    page: () => const LeaveRequestScreen(),
    binding: LeaveRequestC(),
  );

  static const leaveRequestDetailsRoute = '/leave-details';
  static final leaveRequestDetailsPage = GetPage(
    name: leaveRequestDetailsRoute,
    page: () => const LeaveRequestDetailsPage(),
    binding: LeaveRequestC(),
  );
  static const leaveBalanceRoute = '/leave-balance';
  static final leaveBalancePage = GetPage(
    name: leaveBalanceRoute,
    page: () => const LeaveBalancePage(),
    binding: LeaveRequestC(),
  );
  @override
  void dependencies() {
    Get.lazyPut<LeaveRequestController>(() => LeaveRequestController());
  }
}

class LeaveRequestController extends GetxController {
  final isLoading = false.obs;
  final leaveRequestService = LeaveRequestService.instance;
  final sessionService = SessionService.instance;
  final employeeLeaveBalance = Rxn<EmployeeLeaveBalanceResponse>();
  final employeeLeave = Rxn<List<EmployeeLeaveResponse>>();
  final employeeLeaveType = Rxn<List<LeaveTypeResponse>>();
  final leaveBalanceProrate = Rxn<LeaveBalanceProrateResponse>();
  final listLeaveBalance = Rxn<List<LeaveBalanceResponse>>();
  final tableLeaveBalance = Rxn<List<TableLeaveBalanceResponse>>();

  final currentLeave = Rxn<EmployeeLeaveResponse>();

  BuildContext? context;
  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>(["2024", "2023"]);
  void setYear(int year) {
    selectedYear.value = year;
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    await getLeaveType();
    await getEmployeeLeaveByYear();
    await getLeaveBalanceProrate();
  }

  Future<void> mapToTable() async {
    final list = employeeLeaveType.value?.map((e) {
      final leaveBalance =
          leaveBalanceProrate.value?.leaveBalanceList?.firstWhere(
        (element) => element.leaveTypeId == e.id,
        orElse: () => LeaveBalanceList(
          leaveTypeId: e.id,
          leaveBalance: 0,
          leaveTaken: 0,
          leaveEntitle: 0,
        ),
      );
      return TableLeaveBalanceResponse(
        id: e.id,
        name: e.name,
        leaveTypeId: leaveBalance?.leaveTypeId,
        leaveEntitle: leaveBalance?.leaveEntitle,
        leaveTaken: leaveBalance?.leaveTaken,
        leaveBalance: leaveBalance?.leaveBalance,
      );
    }).toList();

    list?.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    tableLeaveBalance.value = list;
    isLoading.value = false;
  }

  List<TableLeaveBalanceResponse> getLeaveTypeList() {
    final eligibleLeaveType = tableLeaveBalance.value!
        .where((element) => element.leaveBalance! > 0)
        .toList();

    return eligibleLeaveType;
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

  void toLeaveDetails(int id) {
    currentLeave.value = employeeLeave.value!.firstWhere((element) {
      return element.id == id;
    });
    Get.toNamed(LeaveRequestC.leaveRequestDetailsRoute);
  }

  void cancelLeave() async {
    try {
      isLoading.value = true;
      currentLeave.value?.status = 3;
      final response =
          await leaveRequestService.updateLeaveRequest(currentLeave.value!);
    } catch (e) {
      print(e);
    } finally {
      getData();
      RouteUtil.back();
      CommonWidget.showNotif('Leave request has been canceled',
          color: Colors.green);
    }
  }

  void setYearList() {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

  Future<void> getLeaveBalanceProrate() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getLeaveBalanceProrate(
        sessionService.getEmployeeId(),
      );
      leaveBalanceProrate.value = response;
    } catch (e) {
      print(e);
    } finally {
      mapToTable();
    }
  }

  Future<void> getEmployeeLeave() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService
          .getEmployeeLeave(sessionService.getEmployeeId());

      employeeLeave.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEmployeeLeaveByYear() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getEmployeeLeaveByYear(
          sessionService.getEmployeeId(), selectedYear.value);

      employeeLeave.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLeaveType() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getLeaveType();
      print('response leaveRequestService.getLeaveType: $response');
      employeeLeaveType.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
