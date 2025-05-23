import 'dart:convert';

import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';

AttendanceResponse attendanceResponseFromJson(String str) =>
    AttendanceResponse.fromJson(json.decode(str));

String attendanceResponseToJson(AttendanceResponse data) =>
    json.encode(data.toJson());

class AttendanceResponse {
  String? message;
  List<AttendanceData>? data;

  AttendanceResponse({
    this.message,
    this.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AttendanceData>.from(
                json["data"]!.map((x) => AttendanceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
  void sortByLatestCheckinDate() {
    data?.sort((a, b) => b.checkinDate!.compareTo(a.checkinDate!));
  }
}
