import 'dart:convert';

StaffMovementResponse staffMovementResponseFromJson(String str) =>
    StaffMovementResponse.fromJson(json.decode(str));

String staffMovementResponseToJson(StaffMovementResponse data) =>
    json.encode(data.toJson());

class StaffMovementResponse {
  int? employeeId;
  String? fullName;
  DateTime? dateFrom;
  DateTime? dateTo;
  String? remarks;
  int? status;
  int? id;
  DateTime? lastModifiedDateTime;

  StaffMovementResponse({
    this.employeeId,
    this.fullName,
    this.dateFrom,
    this.dateTo,
    this.remarks,
    this.status,
    this.id,
    this.lastModifiedDateTime,
  });

  StaffMovementResponse copyWith({
    int? employeeId,
    String? fullName,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? remarks,
    int? status,
    int? id,
    DateTime? lastModifiedDateTime,
  }) =>
      StaffMovementResponse(
        employeeId: employeeId ?? this.employeeId,
        fullName: fullName ?? this.fullName,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        remarks: remarks ?? this.remarks,
        status: status ?? this.status,
        id: id ?? this.id,
        lastModifiedDateTime: lastModifiedDateTime ?? this.lastModifiedDateTime,
      );

  factory StaffMovementResponse.fromJson(Map<String, dynamic> json) =>
      StaffMovementResponse(
        employeeId: json["employeeId"],
        fullName: json["fullName"],
        dateFrom:
            json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
        dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
        remarks: json["remarks"],
        status: json["status"],
        id: json["id"],
        lastModifiedDateTime: json["lastModifiedDateTime"] == null
            ? null
            : DateTime.parse(json["lastModifiedDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "fullName": fullName,
        "dateFrom": dateFrom?.toIso8601String(),
        "dateTo": dateTo?.toIso8601String(),
        "remarks": remarks,
        "status": status,
        "id": id,
        "lastModifiedDateTime": lastModifiedDateTime?.toIso8601String(),
      };
}
