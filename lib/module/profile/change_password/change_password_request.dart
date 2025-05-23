import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) =>
    ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) =>
    json.encode(data.toJson());

class ChangePasswordRequest {
  String email;
  String oldpass;
  String newpass;

  ChangePasswordRequest({
    required this.email,
    required this.oldpass,
    required this.newpass,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        email: json["email"],
        oldpass: json["oldpass"],
        newpass: json["newpass"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "oldpass": oldpass,
        "newpass": newpass,
      };
}
