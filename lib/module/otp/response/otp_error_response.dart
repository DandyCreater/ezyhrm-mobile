import 'dart:convert';

OtpErrorResponse otpErrorResponseFromJson(String str) =>
    OtpErrorResponse.fromJson(json.decode(str));

String otpErrorResponseToJson(OtpErrorResponse data) =>
    json.encode(data.toJson());

class OtpErrorResponse {
  String? message;
  Data? data;

  OtpErrorResponse({
    this.message,
    this.data,
  });

  factory OtpErrorResponse.fromJson(Map<String, dynamic> json) =>
      OtpErrorResponse(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? userId;
  dynamic name;
  dynamic role;
  String? email;
  String? accessToken;
  dynamic subRoles;
  dynamic status;

  Data({
    this.userId,
    this.name,
    this.role,
    this.email,
    this.accessToken,
    this.subRoles,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        accessToken: json["accessToken"],
        subRoles: json["subRoles"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "role": role,
        "email": email,
        "accessToken": accessToken,
        "subRoles": subRoles,
        "status": status,
      };
}
