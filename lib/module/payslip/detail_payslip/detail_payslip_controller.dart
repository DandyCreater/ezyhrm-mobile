import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/payslip_response.dart';
import 'package:ezyhr_mobile_apps/module/payslip/detail_payslip/detail_payslip.dart';
import 'package:ezyhr_mobile_apps/module/payslip/list_payslip/list_payslip_controller.dart';
import 'package:ezyhr_mobile_apps/module/payslip/payslip_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_work_hour_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_service.dart';
import 'package:get/get.dart';

class DetailPayslipC extends Bindings {
  static const route = '/detail-payslip';
  static final page = GetPage(
    name: route,
    page: () => const DetailPayslipScreen(),
    binding: DetailPayslipC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<DetailPayslipController>(() => DetailPayslipController());
    Get.lazyPut<PayslipController>(() => PayslipController());
  }
}

class DetailPayslipController extends GetxController {
  final employeeId = RxInt(0);
  final year = RxInt(0);
  final month = RxInt(0);
  final isLoading = true.obs;
  final leaveRequestService = LeaveRequestService.instance;
  final timesheetService = TimesheetService.instance;
  final payslipService = PayslipService.instance;
  final payslip = Rxn<PayslipResponse>();
  final reimbursementService = ReimbursementService.instance;
  final reimbursmentList = Rxn<List<ReimbursementResponse>>();
  final reimbursmentTypeList = Rxn<List<ReimbursementTypeResponse>>();
  final employeeLeave = Rxn<List<EmployeeLeaveResponse>>();
  final employeeLeaveType = Rxn<List<LeaveTypeResponse>>();
  final listNoPayLeave = Rxn<List<double>>([]);
  final noPayLeave = 0.0.obs;
  final timesheetWorkHour = Rxn<TimesheetWorkHourResponse>();

  final totalAllowance = 0.0.obs;
  final totalDeduction = 0.0.obs;
  final totalAdditional = 0.0.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    final x = Get.arguments;
    await getReimbursementType();
    await getLeaveType();
    await getTimesheetWorkHour(Get.arguments['employeeId']);
    await getPlaySlipWithArgs(Get.arguments['employeeId'],
        Get.arguments['year'], Get.arguments['month']);
    await getReimbursement(Get.arguments['employeeId'], Get.arguments['year'],
        Get.arguments['month'], 4);
    await getEmployeeLeaveByYear(Get.arguments['employeeId'],
        Get.arguments['year'], Get.arguments['month']);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setArgument(int employeeId, int year, int month) {
    this.employeeId.value = employeeId;
    this.year.value = year;
    this.month.value = month;
  }

  Future<void> getTimesheetWorkHour(
    int employeeId,
  ) async {
    try {
      isLoading.value = true;
      final response = await timesheetService.getTimesheetWorkHour(
        employeeId,
      );
      timesheetWorkHour.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEmployeeLeaveByYear(
      int employeeId, int year, int month) async {
    try {
      isLoading.value = true;
      final response =
          await leaveRequestService.getEmployeeLeaveByYear(employeeId, year);

      final noLeave = response
          .where((element) => element.leaveTypeId == 4)
          .where((element) => element.startDate?.month == month)
          .toList();

      employeeLeave.value = noLeave;

      var tmpNoPayLeave2 = 0.0;

      if (noLeave.isNotEmpty) {
        for (var i = 0; i < noLeave.length; i++) {
          final num x = payslip.value?.result?.pay?.hourlyPayRate ?? 0.0;
          final num y = noLeave[i].dayCount ?? 0;
          final num z = x * y;
          final num a = z * 9;

          tmpNoPayLeave2 += a;
        }
      }

      noPayLeave.value = tmpNoPayLeave2;
      totalDeduction.value = totalDeduction.value + tmpNoPayLeave2;
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
      employeeLeaveType.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPlaySlipWithArgs(int employeeId, int year, int month) async {
    try {
      isLoading.value = true;
      final PayslipResponse response =
          await payslipService.getPayslip(employeeId, year, month);
      payslip.value = response;
      print('response @getpayslip: ${response.toJson()}');
      double tmpTotalAllowance = 0.0;
      double tmpTotalDeduction = 0.0;

      for (var i = 0; i < response.result!.payDetails!.length; i++) {
        if (response.result!.payDetails![i].pidDirection == 1) {
          tmpTotalAllowance += response.result?.payDetails?[i].amount ?? 0.0;
        } else if (response.result!.payDetails![i].pidDirection == -1) {
          tmpTotalDeduction += response.result?.payDetails?[i].amount ?? 0.0;
        }
      }

      totalAllowance.value = totalAllowance.value + tmpTotalAllowance;
      totalDeduction.value = totalDeduction.value + tmpTotalDeduction;

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.donationCdacAmount ?? 0.0);

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.donationMbmfAmount ?? 0.0);

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.donationSindaAmount ?? 0.0);

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.donationEcfAmount ?? 0.0);

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.donationShareAmount ?? 0.0);

      totalDeduction.value = totalDeduction.value -
          (response.result?.pay?.employeeContribution ?? 0.0);

      totalDeduction.value =
          totalDeduction.value - (response.result?.pay?.totalNsLeave ?? 0.0);

      print('response @getpayslip: ${response.toJson()}');
    } catch (e) {
      print("error @detailcontroller: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getReimbursement(
    int employeeId,
    int year,
    int month,
    int status,
  ) async {
    try {
      isLoading.value = true;
      final response = await reimbursementService.getReimbursementFilter(
          employeeId, month, year, status);
      reimbursmentList.value = response;
      double tmpTotalAllowance = 0.0;
      double tmpTotalAdditional = 0.0;
      for (var i = 0; i < response.length; i++) {
        if (response[i].remark2 == "Allowance" ||
            response[i].remark2 == "allowance") {
          tmpTotalAllowance += response[i].claimAmount!;
        } else if (response[i].remark2 == "Claim" ||
            response[i].remark2 == "Claim") {
          tmpTotalAdditional += response[i].claimAmount!;
        }
      }
      totalAllowance.value = totalAllowance.value + tmpTotalAllowance;
      totalAdditional.value = totalAdditional.value + tmpTotalAdditional;
    } catch (e) {
      print("error @detailcontroller: $e");
    } finally {
      isLoading.value = false;
    }
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

  double getTotalAllowance() {
    if (isLoading.value) {
      return 0.0;
    }
    double total = 0.0;
    payslip.value?.result?.payDetails?.map((e) => {
          if (e.pidDirection == 1) {total += e.amount ?? 0.0}
        });
    return total;
  }
}
