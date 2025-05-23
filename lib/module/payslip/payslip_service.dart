import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/payslip_history_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/payslip_response.dart';

class PayslipService {
  static PayslipService instance = PayslipService._();
  PayslipService._();
  factory PayslipService() => instance;
  final _baseService = BaseService.instance;

  Future<PayslipHistoryResponse> getPayslipHistory(int employeeId) async {
    final response = await _baseService.get(
      '${ApiConstant.PAYSLIP_HISTORY_URL}/$employeeId',
      responseDecoder: (dynamic response) {
        return PayslipHistoryResponse.fromJson(response);
      },
    );
    print('response: $response');

    return response;
  }

  Future<PayslipResponse> getPayslip(
      int employeeId, int year, int month) async {
    try {
      final response = await _baseService.get(
        '${ApiConstant.PAYSLIP_URL}/$employeeId/$year/$month',
        responseDecoder: (dynamic response) {
          return PayslipResponse.fromJson(response);
        },
      );
      print('response @getPayslip: $response.');
      return response;
    } catch (e) {
      print("error @getPayslip: $e");
      throw e;
    }
  }
}
