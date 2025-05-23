import 'dart:convert';

List<ReimbursementTypeResponse> ListReimbursementTypeResponseFromJson(
        List<dynamic> str) =>
    List<ReimbursementTypeResponse>.from(
        str.map((x) => ReimbursementTypeResponse.fromJson(x)));

ReimbursementTypeResponse reimbursmentTypeResponseFromJson(String str) =>
    ReimbursementTypeResponse.fromJson(json.decode(str));

String reimbursmentTypeResponseToJson(ReimbursementTypeResponse data) =>
    json.encode(data.toJson());

class ReimbursementTypeResponse {
  int? id;
  String? name;
  String? description;
  int? maxAmount;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  ReimbursementTypeResponse({
    this.id,
    this.name,
    this.description,
    this.maxAmount,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ReimbursementTypeResponse.fromJson(Map<String, dynamic> json) =>
      ReimbursementTypeResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        maxAmount: json["max_amount"],
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
        "name": name,
        "description": description,
        "max_amount": maxAmount,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
