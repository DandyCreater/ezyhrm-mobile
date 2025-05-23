import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/api_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:get_storage/get_storage.dart';

class BaseService {
  static BaseService instance = BaseService._();
  BaseService._();
  factory BaseService() => instance;

  static final storage = GetStorage();
  final sessionService = SessionService.instance;

  static const Map<String, dynamic> formData = {
    Headers.contentTypeHeader: Headers.multipartFormDataContentType,
  };

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: ApiConstant.API_TIMEOUT),
    ),
  );

  static final Dio _dioFormData = Dio(
    BaseOptions(
      baseUrl: ApiConstant.BASE_URL,
      connectTimeout: const Duration(seconds: ApiConstant.API_TIMEOUT),
      headers: formData,
    ),
  );

  static final Dio _dioFormData2 = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: ApiConstant.API_TIMEOUT),
      headers: formData,
    ),
  );

  Future<T> _retry<T>(Future<T> Function() request, int retries) async {
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        return await request();
      } catch (e) {
        if (attempt == retries - 1) {
          rethrow;
        }

        await Future.delayed(const Duration(seconds: 2));
      }
    }
    CommonWidget.showErrorNotif("Something went wrong, please refresh");
    throw Exception('Max retry attempts exceeded');
  }

  Future<dynamic> post(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
    showErrorMessage = true,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();

        result = await _dio.post(
          _getFullUrl(path),
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  Future<dynamic> postBase(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
    showErrorMessage = true,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();
        result = await _dio.post(
          path,
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  Future<dynamic> put(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
    showErrorMessage = true,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();
        result = await _dio.put(
          _getFullUrl(path),
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  Future<dynamic> postForm(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
    String? url,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();
        result = await _dioFormData.post(
          path ?? "",
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
    }, 10);
  }

  Future<dynamic> postForm2(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
    String? url,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dioFormData2.options.headers = {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
        };
        result = await _dioFormData2.post(
          path,
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
    }, 10);
  }

  Future<dynamic> get(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();
        result = await _dio.get(
          _getFullUrl(path),
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  Future<dynamic> delete(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dio.options.headers = _getHeaders();
        result = await _dio.delete(
          _getFullUrl(path),
          data: body,
        );
      } on DioException catch (e) {
        _handleException(e, path);
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  Future<dynamic> faceSimilarity(
    String path, {
    dynamic body,
    required dynamic Function(dynamic response) responseDecoder,
    Map<String, dynamic>? headers,
    String? url,
  }) async {
    return _retry(() async {
      Response<dynamic>? result;
      try {
        _dioFormData2.options.headers = {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
        };
        result = await _dioFormData2.post(
          path,
          data: body,
        );
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          CommonWidget.showErrorNotif(
            "Timeout, check your internet connection and try again",
          );
          rethrow;
        }
        if (e.response != null) {
          if (e.response?.statusCode == 401) {
            CommonWidget.showErrorNotif("Session Expired, please login again");
            sessionService.clearSession();
            Future.delayed(Duration.zero, () {
              RouteUtil.offAll("/login");
            });
          } else if (e.response?.statusCode == 400) {
            CommonWidget.showErrorNotif(e.response?.data['detail']);
          }
        }
        rethrow;
      }
      return responseDecoder(result.data);
    }, 10);
  }

  String _getFullUrl(String path) {
    return Uri.parse(
      "${ApiConstant.BASE_URL}$path",
    ).toString();
  }

  Map<String, dynamic> _getHeaders() {
    return {
      Headers.acceptHeader: Headers.jsonContentType,
      Headers.contentTypeHeader: Headers.jsonContentType,
      "Authorization": "Bearer ${storage.read("token") ?? ""}",
      "X-Instance": storage.read('selectedInstance') == null
          ? ""
          : Instance.fromJson(storage.read("selectedInstance")).instanceCode,
    };
  }

  void _handleException(DioException e, String path) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      CommonWidget.showErrorNotif(
        "Timeout, check your internet connection and try again",
      );
      return;
    }
    if (e.response != null) {
      if (path.contains("validatetotp") && e.response?.statusCode == 500) {
        CommonWidget.showErrorNotif("Wrong OTP, please check your input");
      } else if (e.response?.statusCode == 401 &&
          sessionService.getIsLoggedIn() == true) {
        CommonWidget.showErrorNotif("Session Expired, please login again");
        sessionService.clearSession();
        sessionService.saveIsLoggedIn(false);
        Future.delayed(Duration.zero, () {
          RouteUtil.offAll("/login");
        });
      }
    }
  }
}
