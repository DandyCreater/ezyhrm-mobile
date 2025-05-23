import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';

class ReimbursementOptionsResponse {
  ReimbursementTypeResponse reimbursmentTypeResponse;
  String balance;
  String remarkOrBalance;

  ReimbursementOptionsResponse({
    required this.reimbursmentTypeResponse,
    required this.balance,
    required this.remarkOrBalance,
  });
}
