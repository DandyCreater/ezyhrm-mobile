import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_response.dart';

class ReimbursementApprovalDto {
  SupervisorEmployeeResponse? employee;
  ReimbursementResponse? reimbursementList;

  ReimbursementApprovalDto({this.employee, this.reimbursementList});
}
