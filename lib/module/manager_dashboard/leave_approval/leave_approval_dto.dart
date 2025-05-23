import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_response.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';

class LeaveApprovalDto {
  SupervisorEmployeeResponse? employeeList;
  EmployeeLeaveResponse? employeeLeaveResponse;

  LeaveApprovalDto({this.employeeList, this.employeeLeaveResponse});
}
