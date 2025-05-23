import 'package:dio/dio.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/request/employee_leave_balance_request.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/request/employee_leave_request.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_prorate_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/update_leave_response.dart';

final dio = Dio();

class LeaveRequestService {
  static LeaveRequestService instance = LeaveRequestService._();
  LeaveRequestService._();
  factory LeaveRequestService() => instance;

  final _baseService = BaseService.instance;

  Future<List<EmployeeLeaveResponse>> getEmployeeLeave(int employeeId) async {
    final response = await _baseService.get(
      '${ApiConstant.EMPLOYEE_LEAVE_HISTORY_URL}/$employeeId',
      responseDecoder: (dynamic response) {
        return ListEmployeeLeaveResponseFromJson(response);
      },
    );
    print('response getEmployeeLeave: $response');

    return response;
  }

  Future<List<EmployeeLeaveResponse>> getEmployeeLeaveByYear(
      int employeeId, int year) async {
    final response = await _baseService.get(
      '/api/EmployeeLeave/ByEmployeeIdAndYear/$employeeId/$year',
      responseDecoder: (dynamic response) {
        return ListEmployeeLeaveResponseFromJson(response);
      },
    );
    print('response getEmployeeLeaveByYear: $response');

    return response;
  }

  Future<List<EmployeeLeaveResponse>> getEmployeeLeaveByYearMonth(
      int employeeId, int year, int month) async {
    final response = await _baseService.get(
      '/api/EmployeeLeave/ByEmployeeIdAndYearAndMonth/$employeeId/$year/$month',
      responseDecoder: (dynamic response) {
        return ListEmployeeLeaveResponseFromJson(response);
      },
    );
    print('response getEmployeeLeaveByYear: $response');

    return response;
  }

  Future<List<LeaveTypeResponse>> getLeaveType() async {
    final response = await _baseService.get(
      '${ApiConstant.EMPLOYEE_LEAVE_TYPE_URL}',
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
        return leaveTypeResponseFromJson(response);
      },
    );
    print('response getLeaveType: $response');

    return response;
  }

  Future<EmployeeLeaveResponse> createLeaveRequest(
      EmployeeLeaveRequest employeeLeaveRequest) async {
    final response = await _baseService.post(
      '/api/EmployeeLeave',
      body: employeeLeaveRequest.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          print('response @ createLeaveRequest : $response');
          return EmployeeLeaveResponse.fromJson(response);
        } catch (e) {
          print('error @ createLeaveRequest : $e');
          CommonWidget.showErrorNotif('Not enough leave balance');
        }
      },
      showErrorMessage: false,
    );
    return response;
  }

  Future<EmployeeLeaveBalanceResponse> getEmployeeLeaveBalance(
      int employeeId, int year, int createdBy) async {
    final response = await _baseService.post(
      "${ApiConstant.EMPLOYEE_LEAVE_BALANCE_URL}",
      body: EmployeeLeaveBalanceRequest(
        employeeId: employeeId,
        year: year,
        createdBy: createdBy,
      ).toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        return EmployeeLeaveBalanceResponse.fromJson(response);
      },
    );
    return response;
  }

  Future<List<LeaveBalanceResponse>> getLeaveBalance() async {
    final response = await _baseService.get(
      "/api/EmployeeLeaveBalance",
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        return listleaveBalanceResponseFromJson(response);
      },
    );
    return response;
  }

  Future<LeaveBalanceProrateResponse> getLeaveBalanceProrate(
      int employeeId) async {
    final response = await _baseService.get(
      "/api/EmployeeLeaveBalance/GetProratedLeave/$employeeId",
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        return LeaveBalanceProrateResponse.fromJson(response);
      },
    );
    return response;
  }

  Future<UpdateLeaveResponse> updateLeaveRequest(
      EmployeeLeaveResponse employeeLeaveResponse) async {
    final response = await _baseService.put(
      "/api/EmployeeLeave/${employeeLeaveResponse.id}",
      body: employeeLeaveResponse.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        return response;
      },
    );
    return response;
  }
}
