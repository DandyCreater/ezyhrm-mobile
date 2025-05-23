import 'dart:developer';

import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/bank_account_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_particular_response.dart';

class PersonalDetailsService {
  static PersonalDetailsService instance = PersonalDetailsService._();
  PersonalDetailsService._();
  factory PersonalDetailsService() => instance;

  final _baseService = BaseService.instance;

  Future<PersonalDetailsResponse> getPersonalDetails(int employeeId) async {
    final response = await _baseService.get(
      '/api/Employee/read?id=$employeeId',
      responseDecoder: (dynamic response) {
        return PersonalDetailsResponse.fromJson(response);
      },
    );
    log('response getPersonalDetails: $response');

    return response;
  }

  Future<PersonalDetailsResponse> updatePersonalDetails(
      PersonalDetailsResponse personalDetailsResponse) async {
    log("personalDetailsResponse: ${personalDetailsResponse.toJson()}");
    final response = await _baseService.post(
      '/api/Employee/update',
      body: personalDetailsResponse.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          log('response @ updatePersonalDetails : $response');
          return PersonalDetailsResponse.fromJson(response);
        } catch (e) {
          log('error @ updatePersonalDetails : $e');
        }
      },
    );
    log('response updatePersonalDetails: $response');

    return response;
  }

  Future<PersonalParticularResponse> getPersonalParticular(
      int employeeId) async {
    final response = await _baseService.get(
      '/api/PersonalParticular?employee_id=${employeeId}',
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          log('response @ getPersonalParticular : $response');
          return PersonalParticularResponse.fromJson(response);
        } catch (e) {
          log('error @ getPersonalParticular : $e');
        }
      },
    );
    log('response getPersonalParticular: $response');

    return response;
  }

  Future<PersonalParticularResponse> updatePersonalParticular(
      PersonalParticularResponse personalParticularResponse) async {
    final x = personalParticularResponse.toJson();
    log("x=> ${x}");
    final response = await _baseService.post(
      '/api/PersonalParticular/update',
      body: personalParticularResponse.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          log('response @ updatePersonalParticular : $response');
          return PersonalParticularResponse.fromJson(response);
        } catch (e) {
          log('error @ updatePersonalParticular : $e');
        }
      },
    );
    log('response updatePersonalParticular: $response');

    return response;
  }

  Future<PersonalParticularResponse> createPersonalparticular(
      PersonalParticularResponse personalParticularResponse) async {
    final response = await _baseService.post(
      '/api/PersonalParticular/create',
      body: personalParticularResponse.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          log('response @ createPersonalparticular : $response');
          return PersonalParticularResponse.fromJson(response);
        } catch (e) {
          log('error @ createPersonalparticular : $e');
        }
      },
    );
    log('response createPersonalparticular: $response');

    return response;
  }

  Future<List<BankCodeResponse>> getBankCode() async {
    final response = await _baseService.get(
      '/api/BankCode',
      headers: {
        "Content-Type": "application/json",
      },
      responseDecoder: (dynamic response) {
        try {
          log('response @ getBankCode : $response');
          return bankCodeResponseFromJson(response);
        } catch (e) {
          log('error @ getBankCode : $e');
        }
      },
    );
    log('response getBankCode: $response');

    return response;
  }
}
