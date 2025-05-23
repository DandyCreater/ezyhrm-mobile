import 'dart:convert';

ReimbursementRequest reimbursmentRequestFromJson(String str) =>
    ReimbursementRequest.fromJson(json.decode(str));

String reimbursmentRequestToJson(ReimbursementRequest data) =>
    json.encode(data.toJson());

class ReimbursementRequest {
  DateTime? date;
  int? claimTypeId;
  int? employeeId;
  int? claimAmount;
  String? claimDocument;
  String? fileName;
  int? approvedAmount;
  DateTime? applyDate;
  DateTime? incurredDate;
  DateTime? approvedDate;
  DateTime? rejectedDate;
  int? status;
  String? remark;
  String? remark1;
  String? remark2;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  ReimbursementRequest({
    this.date,
    this.claimTypeId,
    this.employeeId,
    this.claimAmount,
    this.claimDocument,
    this.fileName,
    this.approvedAmount,
    this.applyDate,
    this.incurredDate,
    this.approvedDate,
    this.rejectedDate,
    this.status,
    this.remark,
    this.remark1,
    this.remark2,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ReimbursementRequest.fromJson(Map<String, dynamic> json) =>
      ReimbursementRequest(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        claimTypeId: json["claimTypeId"],
        employeeId: json["employeeId"],
        claimAmount: json["claim_amount"],
        claimDocument: json["claim_document"],
        fileName: json["file_name"],
        approvedAmount: json["approved_amount"],
        applyDate: json["apply_date"] == null
            ? null
            : DateTime.parse(json["apply_date"]),
        incurredDate: json["incurred_date"] == null
            ? null
            : DateTime.parse(json["incurred_date"]),
        approvedDate: json["approved_date"] == null
            ? null
            : DateTime.parse(json["approved_date"]),
        rejectedDate: json["rejected_date"] == null
            ? null
            : DateTime.parse(json["rejected_date"]),
        status: json["status"],
        remark: json["remark"],
        remark1: json["remark1"],
        remark2: json["remark2"],
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
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "claimTypeId": claimTypeId,
        "employeeId": employeeId,
        "claim_amount": claimAmount,
        "claim_document": claimDocument,
        "file_name": fileName,
        "approved_amount": approvedAmount,
        "apply_date":
            "${applyDate!.year.toString().padLeft(4, '0')}-${applyDate!.month.toString().padLeft(2, '0')}-${applyDate!.day.toString().padLeft(2, '0')}",
        "incurred_date":
            "${incurredDate!.year.toString().padLeft(4, '0')}-${incurredDate!.month.toString().padLeft(2, '0')}-${incurredDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "remark": remark,
        "remark1": remark1,
        "remark2": remark2,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
