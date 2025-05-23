import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

class ChangePasswordResponse {
  bool? success;
  String? status;
  Result? result;

  ChangePasswordResponse({
    this.success,
    this.status,
    this.result,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        success: json["success"],
        status: json["status"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "result": result?.toJson(),
      };
}

class Result {
  int? otpId;
  String? email;
  String? otpCode;
  String? password;
  String? secretKey;
  int? passwordTries;
  int? secretKeytries;
  bool? firstTime;
  int? tries;
  int? status;
  DateTime? dateCreated;
  DateTime? passwordCreated;
  DateTime? secretKeyCreated;
  dynamic dateBlocked;

  Result({
    this.otpId,
    this.email,
    this.otpCode,
    this.password,
    this.secretKey,
    this.passwordTries,
    this.secretKeytries,
    this.firstTime,
    this.tries,
    this.status,
    this.dateCreated,
    this.passwordCreated,
    this.secretKeyCreated,
    this.dateBlocked,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        otpId: json["otp_id"],
        email: json["email"],
        otpCode: json["otpCode"],
        password: json["password"],
        secretKey: json["secretKey"],
        passwordTries: json["passwordTries"],
        secretKeytries: json["secretKeytries"],
        firstTime: json["firstTime"],
        tries: json["tries"],
        status: json["status"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        passwordCreated: json["passwordCreated"] == null
            ? null
            : DateTime.parse(json["passwordCreated"]),
        secretKeyCreated: json["secretKeyCreated"] == null
            ? null
            : DateTime.parse(json["secretKeyCreated"]),
        dateBlocked: json["dateBlocked"],
      );

  Map<String, dynamic> toJson() => {
        "otp_id": otpId,
        "email": email,
        "otpCode": otpCode,
        "password": password,
        "secretKey": secretKey,
        "passwordTries": passwordTries,
        "secretKeytries": secretKeytries,
        "firstTime": firstTime,
        "tries": tries,
        "status": status,
        "dateCreated": dateCreated?.toIso8601String(),
        "passwordCreated": passwordCreated?.toIso8601String(),
        "secretKeyCreated": secretKeyCreated?.toIso8601String(),
        "dateBlocked": dateBlocked,
      };
}
