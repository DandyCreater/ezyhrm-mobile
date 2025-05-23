import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/auth/login/login_request.dart';
import 'package:ezyhr_mobile_apps/module/auth/login/login_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class LoginService {
  static LoginService instance = LoginService._();
  LoginService._();
  factory LoginService() => instance;

  final _baseService = BaseService.instance;

  Future<LoginResponse> login(LoginRequest request) async {
    final res = await _baseService.post(
      ApiConstant.LOGIN_URL,
      body: request.toJson(),
      responseDecoder: (dynamic response) {
        return LoginResponse.fromJson(response);
      },
    );
    log('response: $res');

    return res;
  }
}
