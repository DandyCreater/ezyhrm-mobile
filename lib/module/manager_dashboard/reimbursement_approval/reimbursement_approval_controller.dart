import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_service.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_detail.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_page.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/variable_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReimbursementApprovalC extends Bindings {
  static const route = '/reimbursement-approval';
  static final page = GetPage(
    name: route,
    page: () => const ReimbursementApprovalPage(),
    binding: ReimbursementApprovalC(),
  );

  static const detailRoute = '/reimbursement-approval-detail';
  static final detailPage = GetPage(
    name: detailRoute,
    page: () => const ReimbursementApprovalDetailPage(),
    binding: ReimbursementApprovalC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ReimbursementApprovalController>(
        () => ReimbursementApprovalController());
  }
}

class ReimbursementApprovalController extends GetxController {
  BuildContext? context;

  final isLoading = false.obs;
  final months = VariableUtil.months.obs;
  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

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

  String getReimbursementProgress(int status) {
    switch (status) {
      case 0:
        return 'Inactive';
      case 1:
        return 'Active';
      case 2:
        return 'Pending';
      case 3:
        return 'Cancelled';
      case 4:
        return 'Approved';
      case 5:
        return 'Rejected';
      default:
        return 'Inactive';
    }
  }

  final sessionService = SessionService.instance;
  final reimbursementService = ReimbursementService.instance;
  final ManagerDashboardService managerDashboardService =
      ManagerDashboardService.instance;

  final employeeList = Rxn<List<SupervisorEmployeeResponse>>();
  final currentEmployee = Rxn<SupervisorEmployeeResponse>();

  final reimbursmentTypeList = Rxn<List<ReimbursementTypeResponse>>();

  final reimbursementApprovalList = Rxn<List<ReimbursementApprovalDto>>();
  final currentReimbursementApproval = Rxn<ReimbursementApprovalDto>();

  final isWaitingApproval = true.obs;
  final tabIndex = 0.obs;
  late TabController tabController;

  @override
  void onReady() {
    super.onReady();
    initYearList();
    getData();
  }

  Future<void> getData() async {
    isLoading.value = true;
    await getEmployeeList();
    await getReimbursementApprovalList();
    await getReimbursementType();
    isLoading.value = false;
  }

  Future<void> getReimbursementType() async {
    try {
      isLoading.value = true;
      final response = await reimbursementService.getReimbursementType();
      reimbursmentTypeList.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  ReimbursementTypeResponse getReimbursementTypeById(int id) {
    final reimbursmentType =
        reimbursmentTypeList.value?.firstWhere((element) => element.id == id);
    return reimbursmentType ??
        ReimbursementTypeResponse(
          id: 0,
          name: '',
          description: '',
          status: 0,
          createdBy: 0,
          updatedBy: 0,
        );
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

  Future<void> getReimbursementApprovalList() async {
    try {
      isLoading.value = true;
      List<ReimbursementApprovalDto> tmpList = [];
      var responses = await Future.wait(
        employeeList.value!.map(
          (e) => reimbursementService.getReimbursementFilter(
            int.parse(e.employeeid),
            selectedMonthNumber.value,
            selectedYear.value,
            selectedStatusNumber.value,
          ),
        ),
      );

      for (var i = 0; i < responses.length; i++) {
        final responseList = responses[i];
        for (var j = 0; j < responseList.length; j++) {
          final response = responseList[j];
          final emp = employeeList.value?.firstWhere(
            (element) => int.parse(element.employeeid) == response.employeeId,
          );
          final dto = ReimbursementApprovalDto(
            reimbursementList: response,
            employee: emp,
          );
          tmpList.add(dto);
        }

        reimbursementApprovalList.value = tmpList;
        reimbursementApprovalList.refresh();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void initYearList() {
    final year = DateTime.now().year;
    final yearListVal = List.generate(3, (index) => year - 1 + index);
    yearList.value = yearListVal.map((e) => e.toString()).toList();
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    selectedMonthNumber.value = VariableUtil.getMonthNumber(month);
    getReimbursementApprovalList();
  }

  void setYear(int year) {
    selectedYear.value = year;
    getReimbursementApprovalList();
  }

  void setCurrentEmployee(SupervisorEmployeeResponse employee) {
    currentEmployee.value = employee;
    final tmpNewList = reimbursementApprovalList.value!
        .where((element) => element.employee?.employeeid == employee.employeeid)
        .toList();
    reimbursementApprovalList.value = tmpNewList;
    reimbursementApprovalList.refresh();
  }

  void setCurrentReimbursement(ReimbursementApprovalDto reimbursement) {
    currentReimbursementApproval.value = reimbursement;
    Get.toNamed(
      ReimbursementApprovalC.detailRoute,
    );
  }

  getReimbursementColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.blue;
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

  getReimbursementColorBackground(int status) {
    switch (status) {
      case 0:
        return Colors.grey[100];
      case 1:
        return Colors.blue[100];
      case 2:
        return Colors.blue[100];
      case 3:
        return Colors.red[100];
      case 4:
        return Colors.green[100];
      case 5:
        return Colors.red[100];
      default:
        return Colors.grey[100];
    }
  }

  void approveReimbursement() async {
    try {
      isLoading.value = true;
      final tmpReq =
          currentReimbursementApproval.value!.reimbursementList!.copyWith();
      tmpReq!.status = 4;
      tmpReq.approvedDate = DateTime.now();
      tmpReq.updatedAt = DateTime.now();
      tmpReq.approvedAmount = tmpReq.claimAmount;
      await reimbursementService.updateReimbursement(tmpReq);
      await getData();
      RouteUtil.back();
      CommonWidget.showNotif('Reimbursement has been approved',
          color: Colors.green);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void rejectReimbursement() async {
    try {
      isLoading.value = true;
      final tmpReq =
          currentReimbursementApproval.value!.reimbursementList!.copyWith();
      tmpReq!.status = 5;
      tmpReq.rejectedDate = DateTime.now();
      tmpReq.updatedAt = DateTime.now();
      await reimbursementService.updateReimbursement(
        tmpReq,
      );
      await getData();
      RouteUtil.back();
      CommonWidget.showNotif('Reimbursement has been rejected',
          color: Colors.green);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
