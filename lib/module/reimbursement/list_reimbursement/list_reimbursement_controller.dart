import 'package:ezyhr_mobile_apps/module/reimbursement/list_reimbursement/reimbursement_balance_page.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_detail_page.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/nhc_reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'list_reimbursement_screen.dart';

class ReimbursementC extends Bindings {
  static const route = '/reimbursement';
  static final page = GetPage(
    name: route,
    page: () => const ReimbursementScreen(),
    binding: ReimbursementC(),
  );
  static const routeDetails = '/reimbursement-details';
  static final pageDetails = GetPage(
    name: routeDetails,
    page: () => const ReimbursementDetailPage(),
    binding: ReimbursementC(),
  );

  static const reimbursementBalance = '/reimbursement-balance';
  static final reimbursementBalancePage = GetPage(
    name: reimbursementBalance,
    page: () => const ReimbursementBalancePage(),
    binding: ReimbursementC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ReimbursementController>(() => ReimbursementController());
  }
}

class ReimbursementController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    setYearList();
    getData();
  }

  Future<void> getData() async {
    await getReimbursementType();
    await getRimbursmentFilter();
    await getNhcReimbursement();
    await getRimbursmentFilterNow();
    isLoading.value = false;
  }

  final isApproved = true.obs;
  void setApproved() {
    isApproved.value = true;
  }

  void setRequest() {
    isApproved.value = false;
  }

  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  BuildContext? context;

  void setYearList() {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

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

  void setYear(int year) {
    selectedYear.value = year;
    getData();
  }

  final currentReimbursement = ReimbursementResponse().obs;

  void setCurrentReimbursement(int id) {
    currentReimbursement.value = reimbursmentList.value!.firstWhere(
      (element) => element.id == id,
    );
    RouteUtil.to(
      ReimbursementC.routeDetails,
    );
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

  final statuses = [
    'Inactive',
    'Active',
    'Pending',
    'Cancelled',
    'Approved',
    'Rejected',
  ].obs;

  final isLoading = true.obs;
  final reimbursmentService = ReimbursementService.instance;
  final sessionService = SessionService.instance;
  final reimbursmentList = Rxn<List<ReimbursementResponse>>();
  final reimbursmentTypeList = Rxn<List<ReimbursementTypeResponse>>();
  final nhcReimbursement = Rxn<NhcReimbursementResponse>();
  final reimbursmentListNow = Rxn<List<ReimbursementResponse>>();
  final isThereReimbursement = false.obs;

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

  Future<void> getReimbursementType() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getReimbursementType();
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

  Future<void> getRimbursmentFilter() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getReimbursementFilter(
        sessionService.getEmployeeId(),
        selectedMonthNumber.value,
        selectedYear.value,
        selectedStatusNumber.value,
      );
      reimbursmentList.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRimbursmentFilterNow() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getReimbursementFilter(
        sessionService.getEmployeeId(),
        DateTime.now().month,
        DateTime.now().year,
        4,
      );
      reimbursmentListNow.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNhcReimbursement() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getNhcReimbursement(
        sessionService.getEmployeeId(),
      );
      nhcReimbursement.value = response;
      if (nhcReimbursement.value?.result!.allowanceAmountType == null) {
        isThereReimbursement.value = false;
      } else {
        double tmpAmount = 0.0;
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCommunication ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCounterfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCountervariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountHousingfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement.value?.result
                ?.allowanceAmountType?.amountNightshiftallowance ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMvcvariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountNightcourtfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountShiftallowance ??
            "0");
        tmpAmount += double.parse(
            nhcReimbursement.value?.result?.allowanceAmountType?.amountOthers ??
                "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountTransportfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountTransportvariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMealallowance ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMobileallowance ??
            "0");
        tmpAmount += double.parse(
            nhcReimbursement.value?.result?.allowanceAmountType?.amountDental ??
                "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountEntertainment ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountOutpatient ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMedical ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountOvertime ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMileage ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountStationeries ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountGroceries ??
            "0");
        if (tmpAmount == 0) {
          isThereReimbursement.value = false;
        } else {
          isThereReimbursement.value = true;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  String getApprovedAmmount(String claimType) {
    num sum = 0;
    if (reimbursmentTypeList.value == null) {
      return '0';
    }
    final claimTypeId = reimbursmentTypeList.value!.firstWhere(
        (element) => element.name == claimType,
        orElse: () => ReimbursementTypeResponse(id: -1));
    if (claimTypeId.id == -1) {
      return '0';
    }

    if (reimbursmentListNow.value == null) {
      return '0';
    }
    final int approvedAmmount = reimbursmentListNow.value!
        .where(
          (element) => element.claimTypeId == claimTypeId.id,
        )
        .toList()
        .length;
    if (approvedAmmount == 0) {
      return '0';
    }
    for (var i = 0; i < reimbursmentListNow.value!.length; i++) {
      sum += reimbursmentListNow.value![i].approvedAmount!;
    }

    return sum.toString();
  }
}
