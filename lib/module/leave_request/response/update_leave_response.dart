import 'dart:convert';

UpdateLeaveResponse updateLeaveResponseFromJson(String str) =>
    UpdateLeaveResponse.fromJson(json.decode(str));

String updateLeaveResponseToJson(UpdateLeaveResponse data) =>
    json.encode(data.toJson());

class UpdateLeaveResponse {
  String? status;
  String? message;

  UpdateLeaveResponse({
    this.status,
    this.message,
  });

  factory UpdateLeaveResponse.fromJson(Map<String, dynamic> json) =>
      UpdateLeaveResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
