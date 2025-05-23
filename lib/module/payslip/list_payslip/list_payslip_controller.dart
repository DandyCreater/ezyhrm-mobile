import 'package:ezyhr_mobile_apps/module/leave_request/response/payslip_history_response.dart';
import 'package:ezyhr_mobile_apps/module/payslip/detail_payslip/detail_payslip_controller.dart';
import 'package:ezyhr_mobile_apps/module/payslip/payslip_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_payslip_screen.dart';

class PayslipC extends Bindings {
  static const route = '/payslip';
  static final page = GetPage(
    name: route,
    page: () => const PayslipScreen(),
    binding: PayslipC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<PayslipController>(() => PayslipController());
    Get.lazyPut<DetailPayslipController>(() => DetailPayslipController());
  }
}

class PayslipController extends GetxController {
  final isLoading = false.obs;
  final payslipService = PayslipService.instance;
  final sessionService = SessionService.instance;
  final payslipHistory = Rxn<PayslipHistoryResponse>();

  final yearList = Rxn<List<String>>();

  final selectedYear = DateTime.now().year.obs;

  BuildContext? context;

  @override
  void onReady() {
    super.onReady();
    setYearList();

    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    getPayslipHistory();
  }

  void getPayslipHistory() async {
    try {
      isLoading.value = true;
      final response = await payslipService
          .getPayslipHistory(sessionService.getEmployeeId());
      final result = response.result!
          .where((element) => element.year == selectedYear.value)
          .toList();
      response.result = result;
      payslipHistory.value = response;
    } catch (e) {
      print(e);
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
}
