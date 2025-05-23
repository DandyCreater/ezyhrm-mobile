import 'dart:convert';

EmployeeLeaveRequest employeeLeaveRequestFromJson(String str) =>
    EmployeeLeaveRequest.fromJson(json.decode(str));

String employeeLeaveRequestToJson(EmployeeLeaveRequest data) =>
    json.encode(data.toJson());

class EmployeeLeaveRequest {
  int? leaveTypeId;
  int? employeeId;
  int? year;
  DateTime? date;
  DateTime? startDate;
  int? startLeaveType;
  DateTime? endDate;
  int? endLeaveType;
  double? dayCount;
  String? leaveDocument;
  int? confirmedBy;
  int? status;
  String? remark;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  EmployeeLeaveRequest({
    this.leaveTypeId,
    this.employeeId,
    this.year,
    this.date,
    this.startDate,
    this.startLeaveType,
    this.endDate,
    this.endLeaveType,
    this.dayCount,
    this.leaveDocument,
    this.confirmedBy,
    this.status,
    this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory EmployeeLeaveRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveRequest(
        leaveTypeId: json["leaveTypeId"],
        employeeId: json["employeeId"],
        year: json["year"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        startLeaveType: json["start_leave_type"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endLeaveType: json["end_leave_type"],
        dayCount: json["day_count"],
        leaveDocument: json["leave_document"],
        confirmedBy: json["confirmed_by"],
        status: json["status"],
        remark: json["remark"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "leaveTypeId": leaveTypeId,
        "employeeId": employeeId,
        "year": year,
        "date": date?.toIso8601String(),
        "start_date": startDate?.toIso8601String(),
        "start_leave_type": startLeaveType,
        "end_date": endDate?.toIso8601String(),
        "end_leave_type": endLeaveType,
        "day_count": dayCount,
        "leave_document": leaveDocument,
        "confirmed_by": confirmedBy,
        "status": status,
        "remark": remark,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
