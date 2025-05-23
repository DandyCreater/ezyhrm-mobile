import 'dart:convert';

EmployeeLeaveBalanceResponse employeeLeaveBalanceResponseFromJson(String str) =>
    EmployeeLeaveBalanceResponse.fromJson(json.decode(str));

String employeeLeaveBalanceResponseToJson(EmployeeLeaveBalanceResponse data) =>
    json.encode(data.toJson());

class EmployeeLeaveBalanceResponse {
  int? id;
  int? employeeId;
  DateTime? startWorkingDate;
  int? annualCount;
  int? medicalCount;
  int? hospitalisationCount;
  int? finishedProbation;
  int? year;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  EmployeeLeaveBalanceResponse({
    this.id,
    this.employeeId,
    this.startWorkingDate,
    this.annualCount,
    this.medicalCount,
    this.hospitalisationCount,
    this.finishedProbation,
    this.year,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory EmployeeLeaveBalanceResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveBalanceResponse(
        id: json["id"],
        employeeId: json["employeeId"],
        startWorkingDate: json["start_working_date"] == null
            ? null
            : DateTime.parse(json["start_working_date"]),
        annualCount: json["annual_count"],
        medicalCount: json["medical_count"],
        hospitalisationCount: json["hospitalisation_count"],
        finishedProbation: json["finished_probation"],
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
        "employeeId": employeeId,
        "start_working_date": startWorkingDate?.toIso8601String(),
        "annual_count": annualCount,
        "medical_count": medicalCount,
        "hospitalisation_count": hospitalisationCount,
        "finished_probation": finishedProbation,
        "year": year,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
