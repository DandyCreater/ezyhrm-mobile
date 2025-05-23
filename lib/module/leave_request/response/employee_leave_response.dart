import 'dart:convert';

List<EmployeeLeaveResponse> ListEmployeeLeaveResponseFromJson(
        List<dynamic> str) =>
    List<EmployeeLeaveResponse>.from(
        str.map((x) => EmployeeLeaveResponse.fromJson(x)));

String ListEmployeeLeaveResponseToJson(List<EmployeeLeaveResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

EmployeeLeaveResponse employeeLeaveResponseFromJson(String str) =>
    EmployeeLeaveResponse.fromJson(json.decode(str));

String employeeLeaveResponseToJson(EmployeeLeaveResponse data) =>
    json.encode(data.toJson());

class EmployeeLeaveResponse {
  num? id;
  String? docNo;
  num? leaveTypeId;
  num? employeeId;
  num? year;
  DateTime? date;
  DateTime? startDate;
  num? startLeaveType;
  DateTime? endDate;
  num? endLeaveType;
  num? dayCount;
  String? leaveDocument;
  dynamic remark;
  dynamic remarkSubmitted;
  dynamic remarkPending;
  dynamic remarkApproval;
  dynamic remarkApproved;
  dynamic remarkRejected;
  num? confirmedBy;
  num? status;
  num? createdBy;
  DateTime? createdAt;
  num? updatedBy;
  DateTime? updatedAt;

  EmployeeLeaveResponse({
    this.id,
    this.docNo,
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
    this.remark,
    this.remarkSubmitted,
    this.remarkPending,
    this.remarkApproval,
    this.remarkApproved,
    this.remarkRejected,
    this.confirmedBy,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory EmployeeLeaveResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveResponse(
        id: json["id"],
        docNo: json["doc_no"],
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
        remark: json["remark"],
        remarkSubmitted: json["remark_submitted"],
        remarkPending: json["remark_pending"],
        remarkApproval: json["remark_approval"],
        remarkApproved: json["remark_approved"],
        remarkRejected: json["remark_rejected"],
        confirmedBy: json["confirmed_by"],
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
        "doc_no": docNo,
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
        "remark": remark,
        "remark_submitted": remarkSubmitted,
        "remark_pending": remarkPending,
        "remark_approval": remarkApproval,
        "remark_approved": remarkApproved,
        "remark_rejected": remarkRejected,
        "confirmed_by": confirmedBy,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
