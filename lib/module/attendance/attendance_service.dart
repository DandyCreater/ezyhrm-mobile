import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/attendance/request/attendance_request.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_create_response.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_response.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/face_detection_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

import 'request/face_detection_request.dart';

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

  Future<bool> startFaceDetection(
      String? imagePath1, String? imagePath2) async {
    try {
      final params = FaceDetectionRequest(
        imageBytes1: imagePath1 ?? '',
        imageBytes2: imagePath2 ?? '',
      );

      final response = await _baseService.postFormData(
          '/api/FaceRecognitionAPI/CompareFaces',
          body: await params.toFormData(), responseDecoder: (dynamic response) {
        log('response faceDetections: $response');
        final result = FaceDetectionResponse.fromJson(response);

        if (result.results != null) {
          return result.results;
        } else {
          return false;
        }
      });
      log('response faceDetection: $response');
      return response;
    } catch (e) {
      log(' error response faceDetections: $e');
      return false;
    }
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
