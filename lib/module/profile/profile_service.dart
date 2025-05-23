import 'package:dio/dio.dart';
import 'package:ezyhr_mobile_apps/module/profile/nhc_form_details_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_hrms_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_personal_particular_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';

class ProfileService {
  static ProfileService instance = ProfileService._();
  ProfileService._();
  factory ProfileService() => instance;
  static final Dio _dio = Dio();
  final _baseService = BaseService.instance;
  final _sessionService = SessionService.instance;

  Future<ProfileHrmsResponse> getProfileHrms(int employeeId) async {
    final response = await _baseService.get(
      '${ApiConstant.PROFILE_HRMS_URL}?id=$employeeId',
      responseDecoder: (dynamic response) {
        if (response == null) {
          return ProfileHrmsResponse();
        }
        return ProfileHrmsResponse.fromJson(response);
      },
    );
    print('response: $response');
    if (response == null) {
      return ProfileHrmsResponse();
    }

    return response;
  }

  Future<ProfilePersonalParticularResponse> getProfilePersonalParticular(
      int employeeId) async {
    final response = await _baseService.get(
      '${ApiConstant.PROFILE_PERSONAL_PARTICULAR_URL}/?employee_id=$employeeId',
      responseDecoder: (dynamic response) {
        return ProfilePersonalParticularResponse.fromJson(response);
      },
    );
    print('response: $response');

    return response;
  }

  Future<String?> getProfilePicture(int employeeId) async {
    Response<String>? result;

    try {
      result = await _dio.get(
        "https://ezyhr.rmagroup.com.sg/Public/GetUserPhotoURL?route=${_sessionService.getInstanceName()}&userId=$employeeId",
      );
    } on DioException {
      return "https://ezyhr.rmagroup.com.sg/img/blank.png";
    }

    return result.data ?? "";
  }

  Future<NhcFormDetailsResponse> getNhcFormDetails(int employeeId) async {
    final response = await _baseService.get(
      '/api/NHCLibrary/getnhcformdetailsbyempid/$employeeId',
      responseDecoder: (dynamic response) {
        if (response == null) {
          return NhcFormDetailsResponse();
        }
        return NhcFormDetailsResponse.fromJson(response);
      },
    );
    print('response: $response');

    return response;
  }
}
