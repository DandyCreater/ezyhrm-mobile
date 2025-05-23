import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_request.dart';
import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class ChangePasswordService {
  static ChangePasswordService instance = ChangePasswordService._();
  ChangePasswordService._();
  factory ChangePasswordService() => instance;
  final _baseService = BaseService.instance;

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    final response = await _baseService.post(
      '/api/Mail/ChangePasswordEmployee',
      body: changePasswordRequest.toJson(),
      responseDecoder: (dynamic response) {
        return ChangePasswordResponse.fromJson(response);
      },
    );
    return response;
  }

  String? isPasswordValid(String password) {
    if (password.length < 8)
      return "Password must be at least 8 characters long";

    final RegExp upperCasePattern = RegExp(r'[A-Z]');
    final RegExp lowerCasePattern = RegExp(r'[a-z]');
    final RegExp numberPattern = RegExp(r'[0-9]');
    final RegExp specialCharacterPattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    bool hasUpperCase = upperCasePattern.hasMatch(password);
    bool hasLowerCase = lowerCasePattern.hasMatch(password);
    bool hasNumber = numberPattern.hasMatch(password);
    bool hasSpecialCharacter = specialCharacterPattern.hasMatch(password);

    if (!hasUpperCase) {
      return "Password must contain at least one uppercase letter";
    }
    ;
    if (!hasLowerCase) {
      return "Password must contain at least one lowercase letter";
    }
    ;
    if (!hasNumber) {
      return "Password must contain at least one number";
    }
    ;
    if (!hasSpecialCharacter) {
      return "Password must contain at least one special character";
    }
    ;

    return null;
  }
}
