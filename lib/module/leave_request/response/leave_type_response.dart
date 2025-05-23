import 'dart:convert';

List<LeaveTypeResponse> leaveTypeResponseFromJson(List<dynamic> str) {
  return List<LeaveTypeResponse>.from(
      str.map((x) => LeaveTypeResponse.fromJson(x)));
}

String leaveTypeResponseToJson(List<LeaveTypeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveTypeResponse {
  int? id;
  String? name;
  int? maxDayCount;
  String? description;
  int? hasEntitle;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  LeaveTypeResponse({
    this.id,
    this.name,
    this.maxDayCount,
    this.description,
    this.hasEntitle,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory LeaveTypeResponse.fromJson(Map<String, dynamic> json) =>
      LeaveTypeResponse(
        id: json["id"],
        name: json["name"],
        maxDayCount: json["max_day_count"],
        description: json["description"],
        hasEntitle: json["has_entitle"],
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
        "max_day_count": maxDayCount,
        "description": description,
        "has_entitle": hasEntitle,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
