import 'dart:convert';

List<LeaveBalanceResponse> listleaveBalanceResponseFromJson(
        List<dynamic> str) =>
    List<LeaveBalanceResponse>.from(
        str.map((x) => LeaveBalanceResponse.fromJson(x)));
List<LeaveBalanceResponse> leaveBalanceResponseFromJson(String str) =>
    List<LeaveBalanceResponse>.from(
        json.decode(str).map((x) => LeaveBalanceResponse.fromJson(x)));

String leaveBalanceResponseToJson(List<LeaveBalanceResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveBalanceResponse {
  int? id;
  int? leaveTypeId;
  int? employeeId;
  DateTime? startWorkingDate;
  DateTime? startWorkingDateOriginal;
  double? leaveEntitle;
  double? leaveTaken;
  double? leaveBalance;
  int? year;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  LeaveBalanceResponse({
    this.id,
    this.leaveTypeId,
    this.employeeId,
    this.startWorkingDate,
    this.startWorkingDateOriginal,
    this.leaveEntitle,
    this.leaveTaken,
    this.leaveBalance,
    this.year,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory LeaveBalanceResponse.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceResponse(
        id: json["id"],
        leaveTypeId: json["leaveTypeId"],
        employeeId: json["employeeId"],
        startWorkingDate: json["start_working_date"] == null
            ? null
            : DateTime.parse(json["start_working_date"]),
        startWorkingDateOriginal: json["start_working_date_original"] == null
            ? null
            : DateTime.parse(json["start_working_date_original"]),
        leaveEntitle: json["leave_entitle"],
        leaveTaken: json["leave_taken"]?.toDouble(),
        leaveBalance: json["leave_balance"]?.toDouble(),
        year: json["year"],
        status: json["status"],
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
        "id": id,
        "leaveTypeId": leaveTypeId,
        "employeeId": employeeId,
        "start_working_date": startWorkingDate?.toIso8601String(),
        "start_working_date_original":
            startWorkingDateOriginal?.toIso8601String(),
        "leave_entitle": leaveEntitle,
        "leave_taken": leaveTaken,
        "leave_balance": leaveBalance,
        "year": year,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
