import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_pageable_response.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';

class StaffMovementService {
  static StaffMovementService instance = StaffMovementService._();
  StaffMovementService._();
  factory StaffMovementService() => instance;
  final _baseService = BaseService.instance;

  Future<StaffMovementPageableResponse> getStaffMovement(
      int pageNumber, int pageSize) async {
    final response = await _baseService.get(
      '/api/EmployeeMovement/list?pageNumber=$pageNumber&pageSize=$pageSize',
      responseDecoder: (response) {
        return StaffMovementPageableResponse.fromJson(response);
      },
    );
    return response;
  }

  Future<StaffMovementResponse> createStaffMovement(
      StaffMovementResponse staffMovementResponse) async {
    final response = await _baseService.post(
      '/api/EmployeeMovement/create',
      body: staffMovementResponse.toJson(),
      responseDecoder: (response) {
        return StaffMovementResponse.fromJson(response);
      },
    );
    return response;
  }
}
