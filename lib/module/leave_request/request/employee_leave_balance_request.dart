import 'dart:convert';

EmployeeLeaveBalanceRequest employeeLeaveBalanceRequestFromJson(String str) =>
    EmployeeLeaveBalanceRequest.fromJson(json.decode(str));

String employeeLeaveBalanceRequestToJson(EmployeeLeaveBalanceRequest data) =>
    json.encode(data.toJson());

class EmployeeLeaveBalanceRequest {
  int? employeeId;
  int? year;
  int? createdBy;

  EmployeeLeaveBalanceRequest({
    this.employeeId,
    this.year,
    this.createdBy,
  });

  factory EmployeeLeaveBalanceRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveBalanceRequest(
        employeeId: json["employeeId"],
        year: json["year"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "year": year,
        "created_by": createdBy,
      };
}
