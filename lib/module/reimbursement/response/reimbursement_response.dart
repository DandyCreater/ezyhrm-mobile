import 'dart:convert';

List<ReimbursementResponse> ListReimbursementResponseFromJson(
        List<dynamic> str) =>
    List<ReimbursementResponse>.from(
        str.map((x) => ReimbursementResponse.fromJson(x)));

String ListReimbursementResponseToJson(List<ReimbursementResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ReimbursementResponse reimbursmentResponseFromJson(String str) =>
    ReimbursementResponse.fromJson(json.decode(str));

String reimbursmentResponseToJson(ReimbursementResponse data) =>
    json.encode(data.toJson());

class ReimbursementResponse {
  num? id;
  String? docNo;
  DateTime? date;
  num? claimTypeId;
  num? employeeId;
  num? claimAmount;
  dynamic claimDocument;
  String? fileName;
  num? approvedAmount;
  DateTime? applyDate;
  DateTime? approvedDate;
  DateTime? rejectedDate;
  DateTime? incurredDate;
  num? status;
  String? remark;
  String? remark1;
  String? remark2;
  dynamic remark3;
  num? createdBy;
  DateTime? createdAt;
  num? updatedBy;
  DateTime? updatedAt;

  ReimbursementResponse({
    this.id,
    this.docNo,
    this.date,
    this.claimTypeId,
    this.employeeId,
    this.claimAmount,
    this.claimDocument,
    this.fileName,
    this.approvedAmount,
    this.applyDate,
    this.approvedDate,
    this.rejectedDate,
    this.incurredDate,
    this.status,
    this.remark,
    this.remark1,
    this.remark2,
    this.remark3,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  copyWith({
    num? id,
    String? docNo,
    DateTime? date,
    num? claimTypeId,
    num? employeeId,
    num? claimAmount,
    dynamic claimDocument,
    String? fileName,
    num? approvedAmount,
    DateTime? applyDate,
    DateTime? approvedDate,
    DateTime? rejectedDate,
    DateTime? incurredDate,
    num? status,
    String? remark,
    String? remark1,
    String? remark2,
    dynamic remark3,
    num? createdBy,
    DateTime? createdAt,
    num? updatedBy,
    DateTime? updatedAt,
  }) {
    return ReimbursementResponse(
      id: id ?? this.id,
      docNo: docNo ?? this.docNo,
      date: date ?? this.date,
      claimTypeId: claimTypeId ?? this.claimTypeId,
      employeeId: employeeId ?? this.employeeId,
      claimAmount: claimAmount ?? this.claimAmount,
      claimDocument: claimDocument ?? this.claimDocument,
      fileName: fileName ?? this.fileName,
      approvedAmount: approvedAmount ?? this.approvedAmount,
      applyDate: applyDate ?? this.applyDate,
      approvedDate: approvedDate ?? this.approvedDate,
      rejectedDate: rejectedDate ?? this.rejectedDate,
      incurredDate: incurredDate ?? this.incurredDate,
      status: status ?? this.status,
      remark: remark ?? this.remark,
      remark1: remark1 ?? this.remark1,
      remark2: remark2 ?? this.remark2,
      remark3: remark3 ?? this.remark3,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ReimbursementResponse.fromJson(Map<String, dynamic> json) =>
      ReimbursementResponse(
        id: json["id"],
        docNo: json["doc_no"],
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
        approvedDate: json["approved_date"] == null
            ? null
            : DateTime.parse(json["approved_date"]),
        rejectedDate: json["rejected_date"] == null
            ? null
            : DateTime.parse(json["rejected_date"]),
        incurredDate: json["incurred_date"] == null
            ? null
            : DateTime.parse(json["incurred_date"]),
        status: json["status"],
        remark: json["remark"],
        remark1: json["remark1"],
        remark2: json["remark2"],
        remark3: json["remark3"],
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
        "date": date?.toIso8601String(),
        "claimTypeId": claimTypeId,
        "employeeId": employeeId,
        "claim_amount": claimAmount,
        "claim_document": claimDocument,
        "file_name": fileName,
        "approved_amount": approvedAmount,
        "apply_date": applyDate?.toIso8601String(),
        "approved_date": approvedDate?.toIso8601String(),
        "rejected_date": rejectedDate?.toIso8601String(),
        "incurred_date": incurredDate?.toIso8601String(),
        "status": status,
        "remark": remark,
        "remark1": remark1,
        "remark2": remark2,
        "remark3": remark3,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
