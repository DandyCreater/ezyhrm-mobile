import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_create_response.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SessionService extends GetxService {
  static SessionService instance = SessionService._();
  SessionService._();
  factory SessionService() => instance;

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  static final storage = GetStorage();

  static const _sessionKey = 'sessionKey';

  static const emailKey = 'email';
  static const otpKey = 'otp';
  static const checkInKey = 'checkIn';
  static const tokenKey = "token";
  static const imagePath = "imagePath";
  static const isLoggedIn = "isLoggedIn";
  static const lastEmail = "lastEmail";
  static const selectedInstance = "selectedInstance";

  Future<void> saveEmail(String email) async {
    await storage.write(emailKey, email);
  }

  String? getEmail() {
    final res = storage.read(emailKey);
    return res;
  }

  Future<void> saveOtpResponse(OtpResponse otpResponse) async {
    await storage.write(otpKey, otpResponseToJson(otpResponse));
  }

  OtpResponse? getOtpResponse() {
    final res = storage.read(otpKey);
    if (res == null) return null;
    return otpResponseFromJson(res);
  }

  void removeOtpResponse() {
    storage.remove(otpKey);
  }

  Future<void> saveCheckIn(
      AttendanceCreateResponse attendanceCreateResponse) async {
    await storage.write(
        checkInKey, attendanceCreateResponseToJson(attendanceCreateResponse));
  }

  AttendanceCreateResponse? getCheckIn() {
    try {
      final res = storage.read(checkInKey);
      if (res == null) return null;
      return attendanceCreateResponseFromJson(res);
    } catch (e) {
      return null;
    }
  }

  Future<void> removeCheckIn() async {
    await storage.remove(checkInKey);
  }

  int getEmployeeId() {
    final res = storage.read(selectedInstance);
    if (res == null) {
      removeOtpResponse();
      Future.delayed(Duration.zero, () {
        RouteUtil.offAll("/login");
      });
    }

    String employeeId = getSelectedInstance()?.userId ?? "0";
    return int.parse(employeeId);
  }

  String getInstanceName() {
    final res = storage.read(otpKey);
    if (res == null) {
      removeOtpResponse();
      Future.delayed(Duration.zero, () {
        RouteUtil.offAll("/login");
      });
    }
    return getSelectedInstance()?.instanceCode ?? "";
  }

  void saveSelectedInstance(Instance instance) {
    storage.write(selectedInstance, instance.toJson());
  }

  Instance? getSelectedInstance() {
    final res = storage.read(selectedInstance);

    return Instance.fromJson(res);
  }

  Future<void> saveInstances(List<Instance> instances) async {
    await storage.write("instances", instances.map((e) => e.toJson()).toList());
  }

  List<Instance> getInstances() {
    final res = storage.read("instances");
    final List<Instance> results = [];

    if (res == null) return results;

    for (var item in res) {
      results.add(Instance.fromJson(item));
    }

    return results;
  }

  Future<void> saveToken(String token) async {
    await storage.write(tokenKey, token);
  }

  String? getToken() {
    final res = storage.read(tokenKey);
    if (res == null) return null;
    return res;
  }

  Future<void> saveImage(String image) async {
    await storage.write("image", image);
  }

  String? getImage() {
    final res = storage.read("image");
    if (res == null) return null;
    return res;
  }

  Future<void> saveIsLoggedIn(bool isLoggedIn) async {
    await storage.write(SessionService.isLoggedIn, isLoggedIn);
  }

  bool? getIsLoggedIn() {
    final res = storage.read(SessionService.isLoggedIn);
    if (res == null) return null;
    return res;
  }

  Future<void> saveLastEmail(String email) async {
    await storage.write(lastEmail, email);
  }

  String? getLastEmail() {
    final res = storage.read(lastEmail);
    if (res == null) return null;
    return res;
  }

  Future<void> saveImageUrl(String imageUrl) async {
    var dio = Dio();
    var response = await dio.get(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    Directory appDocDir = await getTemporaryDirectory();
    String path =
        '${appDocDir.path}/${Uuid().v1()}.${imageUrl.split('.').last}';
    storage.write(imagePath, path);
    File file = File(path);
    file.writeAsBytesSync(response.data);
  }

  Future<String> saveImageUrlWithReturn(String imageUrl) async {
    var dio = Dio();
    var response = await dio.get(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    Directory appDocDir = await getTemporaryDirectory();
    String path =
        '${appDocDir.path}/${Uuid().v1()}.${imageUrl.split('.').last}';
    storage.write(imagePath, path);
    File file = File(path);
    file.writeAsBytesSync(response.data);
    return path;
  }

  Future<String> saveImageUrlWithReturn2(String imageUrl) async {
    var dio = Dio();
    var response = await dio.get(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    Directory appDocDir = await getTemporaryDirectory();
    String extension = imageUrl.split('?').first.split('.').last;
    String path = '${appDocDir.path}/${Uuid().v4()}.$extension';

    File file = File(path);
    await file.writeAsBytes(response.data);
    return path;
  }

  String getImageUrl() {
    final res = storage.read(imagePath);
    if (res == null) return "";
    return res;
  }

  Future<void> removeSession() async {
    await storage.remove(_sessionKey);
  }

  static const _printerBlueKey = 'printerBlueKey';

  Future<void> savePrinterBluetoothAddress(String address, String name) async {
    await storage.write(_printerBlueKey, {"address": address, "name": name});
  }

  Map<String, dynamic>? getPrinterBluetoothAddress() {
    final res = storage.read(_printerBlueKey);
    return res;
  }

  Future<void> removePrinterBluetoothAddress() async {
    await storage.remove(_printerBlueKey);
  }

  void clearSession() {
    storage.erase();
  }
}
