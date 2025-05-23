import 'dart:convert';

AttendanceRequest attendanceRequestFromJson(String str) =>
    AttendanceRequest.fromJson(json.decode(str));

String attendanceRequestToJson(AttendanceRequest data) =>
    json.encode(data.toJson());

class AttendanceRequest {
  int? id;
  int? employeeId;
  int? month;
  int? year;
  DateTime? checkinDate;
  String? photoinTime;
  String? locationinTime;
  DateTime? checkoutDate;
  String? photooutTime;
  String? locationoutTime;
  String? latOutTime;
  String? longOutTime;
  String? latInTime;
  String? longInTime;
  int? status;

  AttendanceRequest({
    this.id,
    this.employeeId,
    this.month,
    this.year,
    this.checkinDate,
    this.photoinTime,
    this.locationinTime,
    this.checkoutDate,
    this.photooutTime,
    this.locationoutTime,
    this.latOutTime,
    this.longOutTime,
    this.latInTime,
    this.longInTime,
    this.status,
  });

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceRequest(
        id: json["id"],
        employeeId: json["employeeId"],
        month: json["month"],
        year: json["year"],
        checkinDate: json["checkinDate"] == null
            ? null
            : DateTime.parse(json["checkinDate"]),
        photoinTime: json["photoinTime"],
        locationinTime: json["locationinTime"],
        checkoutDate: json["checkoutDate"] == null
            ? null
            : DateTime.parse(json["checkoutDate"]),
        photooutTime: json["photooutTime"],
        locationoutTime: json["locationoutTime"],
        latOutTime: json["latOutTime"],
        longOutTime: json["longOutTime"],
        latInTime: json["latInTime"],
        longInTime: json["longInTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "employeeId": employeeId,
        "month": month,
        "year": year,
        "checkinDate": checkinDate?.toIso8601String(),
        "photoinTime": photoinTime,
        "locationinTime": locationinTime,
        "checkoutDate": checkoutDate?.toIso8601String(),
        "photooutTime": photooutTime,
        "locationoutTime": locationoutTime,
        "latOutTime": latOutTime.toString(),
        "longOutTime": longOutTime.toString(),
        "latInTime": latInTime.toString(),
        "longInTime": longInTime.toString(),
        "status": status,
      };
}
