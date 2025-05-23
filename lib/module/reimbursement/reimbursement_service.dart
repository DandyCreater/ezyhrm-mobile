import 'package:ezyhr_mobile_apps/module/reimbursement/request/reimbursement_request.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/nhc_reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class ReimbursementService {
  static ReimbursementService instance = ReimbursementService._();
  ReimbursementService._();
  factory ReimbursementService() => instance;

  final _baseService = BaseService.instance;

  Future<List<ReimbursementTypeResponse>> getReimbursementType() async {
    final response = await _baseService.get(
      '${ApiConstant.REIMBURSMENT_TYPE_URL}',
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
        return ListReimbursementTypeResponseFromJson(response);
      },
    );
    print('response getReimbursementType: $response');

    return response;
  }

  Future<List<ReimbursementResponse>> getReimbursement() async {
    final response = await _baseService.get(
      '${ApiConstant.REIMBURSMENT_HISTORY_URL}',
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
        return ListReimbursementResponseFromJson(response);
      },
    );
    print('response getReimbursement: $response');

    return response;
  }

  Future<ReimbursementResponse> createReimbursement(
      ReimbursementRequest reimbursmentRequest) async {
    final response = await _baseService.post(
      '${ApiConstant.REIMBURSMENT_CREATE_URL}',
      body: reimbursmentRequest.toJson(),
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
        return ReimbursementResponse.fromJson(response);
      },
    );
    print('response createReimbursement: $response');

    return response;
  }

  Future<void> updateReimbursement(
      ReimbursementResponse reimbursmentRequest) async {
    final response = await _baseService.put(
      '${ApiConstant.REIMBURSMENT_CREATE_URL}/${reimbursmentRequest.id}',
      body: reimbursmentRequest.toJson(),
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
      },
    );
    print('response createReimbursement: $response');
  }

  Future<List<ReimbursementResponse>> getReimbursementFilter(
      int employeeId, int month, int year, int status) async {
    final x = {
      "employeeId": [employeeId],
      "month": month,
      "year": year,
      "status": status
    };

    final response = await _baseService.post(
      "/api/EmployeeClaim/GetEmployeeClaimByEmpoyeeIds",
      body: {
        "employeeId": [employeeId],
        "month": month,
        "year": year,
        "status": status
      },
      responseDecoder: (dynamic response) {
        print('responseDecoder getReimbursementFilter: $response');
        return ListReimbursementResponseFromJson(response);
      },
    );
    print('response getReimbursementFilter: $response');
    return response;
  }

  Future<NhcReimbursementResponse> getNhcReimbursement(int employeeId) async {
    final response = await _baseService.get(
      '/api/NHCLibrary/getnhcreimbursementbyempid/$employeeId',
      responseDecoder: (dynamic response) {
        print('response responseDecoder: $response');
        return NhcReimbursementResponse.fromJson(response);
      },
    );
    print('response getNhcReimbursement: $response');

    return response;
  }
}
