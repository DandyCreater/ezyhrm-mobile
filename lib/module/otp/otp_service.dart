import 'dart:developer';

import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_error_response.dart';
import 'package:ezyhr_mobile_apps/module/otp/request/otp_request.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';

class OtpService {
  static OtpService instance = OtpService._();
  OtpService._();
  factory OtpService() => instance;

  final _baseService = BaseService.instance;

  Future<dynamic> otpVerification(OtpRequest request) async {
    final Response = await _baseService.post(
      ApiConstant.OTP_URL,
      body: request.toJson(),
      responseDecoder: (dynamic response) {
        log('response: $response');
        if (response['message'] != "") {
          return OtpErrorResponse.fromJson(response);
        } else {
          return OtpResponse.fromJson(response);
        }
      },
    );
    print('response@otpVerificationService: ${Response.toJson()}');

    return Response;
  }

  Future<dynamic> otpVerificationV2(
      String email, String verificationCode) async {
    final Response = await _baseService.post(
      "${ApiConstant.OTP_URL_V2}?compEmail=$email&validationCode=$verificationCode",
      responseDecoder: (dynamic response) {
        return OtpResponse.fromJson(response);
      },
    );
    print('response@otpVerificationService: ${Response.toJson()}');

    return Response;
  }
}
