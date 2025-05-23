import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  String? status;
  Result? result;

  LoginResponse({
    this.success,
    this.status,
    this.result,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  String? email;
  bool? firstTime;

  Result({
    this.email,
    this.firstTime,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        email: json["email"],
        firstTime: json["firstTime"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstTime": firstTime,
      };
}
