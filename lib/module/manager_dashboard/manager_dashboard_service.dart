import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class ManagerDashboardService {
  static ManagerDashboardService instance = ManagerDashboardService._();
  ManagerDashboardService._();
  factory ManagerDashboardService() => instance;
  final _baseService = BaseService.instance;
  Future<List<SupervisorEmployeeResponse>> getSupervisorEmployee(
      int employeeId) async {
    try {
      final response = await _baseService.get(
        '/api/Employee/SuperVisorEmployees?id=$employeeId',
        responseDecoder: (response) {
          log('response: $response');
          return (response as List)
              .map((e) => SupervisorEmployeeResponse.fromJson(e))
              .toList();
        },
      );
      print('response: $response');
      return response;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
