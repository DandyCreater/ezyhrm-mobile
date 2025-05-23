import 'dart:convert';

import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';

AttendanceCreateResponse attendanceCreateResponseFromJson(String str) =>
    AttendanceCreateResponse.fromJson(json.decode(str));

String attendanceCreateResponseToJson(AttendanceCreateResponse data) =>
    json.encode(data.toJson());

class AttendanceCreateResponse {
  String? message;
  AttendanceData? data;

  AttendanceCreateResponse({
    this.message,
    this.data,
  });

  factory AttendanceCreateResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceCreateResponse(
        message: json["message"],
        data:
            json["data"] == null ? null : AttendanceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}
