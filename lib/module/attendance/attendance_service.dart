import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/attendance/request/attendance_request.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_create_response.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class AttendanceService {
  static AttendanceService instance = AttendanceService._();
  AttendanceService._();
  factory AttendanceService() => instance;

  final _baseService = BaseService.instance;

  Future<AttendanceResponse> getAttendance(int employeeId) async {
    try {
      final response = await _baseService.get(
        '${ApiConstant.ATTENDANCE_HISTORY_URL}?employeeId=$employeeId',
        responseDecoder: (dynamic response) {
          if (response == null) {
            return AttendanceResponse();
          }
          final tmpRes = AttendanceResponse.fromJson(response);

          tmpRes.sortByLatestCheckinDate();
          return tmpRes;
        },
      );
      log('response getAttendance: $response');

      return response;
    } catch (e) {
      log('error getAttendance: $e');
      return AttendanceResponse();
    }
  }

  Future<AttendanceCreateResponse> checkIn(AttendanceRequest request) async {
    final response = await _baseService.post(
      '${ApiConstant.ATTENDANCE_CHECKIN_URL}',
      body: request.toJson(),
      responseDecoder: (dynamic response) {
        if (response == null) {
          return AttendanceCreateResponse();
        }
        return AttendanceCreateResponse.fromJson(response);
      },
    );
    log('response createAttendance: $response');

    return response;
  }

  Future<AttendanceCreateResponse> checkOut(AttendanceRequest request) async {
    final response = await _baseService.post(
      '${ApiConstant.ATTENDANCE_CHECKOUT_URL}',
      body: request.toJson(),
      responseDecoder: (dynamic response) {
        if (response == null) {
          return AttendanceCreateResponse();
        }
        return AttendanceCreateResponse.fromJson(response);
      },
    );
    log('response createAttendance: $response');

    return response;
  }
}
