import 'dart:convert';

List<BankCodeResponse> bankCodeResponseFromJson(List<dynamic> str) =>
    List<BankCodeResponse>.from(str.map((x) => BankCodeResponse.fromJson(x)));
String bankCodeResponseToJson(List<BankCodeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankCodeResponse {
  int? id;
  String? bankName;
  String? bankCode;
  String? branchName;
  String? branchCode;
  String? swiftCode;
  int? status;
  String? remark;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  BankCodeResponse({
    this.id,
    this.bankName,
    this.bankCode,
    this.branchName,
    this.branchCode,
    this.swiftCode,
    this.status,
    this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory BankCodeResponse.fromJson(Map<String, dynamic> json) =>
      BankCodeResponse(
        id: json["id"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        branchName: json["branch_name"],
        branchCode: json["branch_code"],
        swiftCode: json["swift_code"],
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
        "id": id,
        "bank_name": bankName,
        "bank_code": bankCode,
        "branch_name": branchName,
        "branch_code": branchCode,
        "swift_code": swiftCode,
        "status": status,
        "remark": remark,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
