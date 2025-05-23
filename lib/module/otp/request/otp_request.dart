import 'dart:convert';

OtpRequest otpRequestFromJson(String str) =>
    OtpRequest.fromJson(json.decode(str));

String otpRequestToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
  String email;
  String otpCode;

  OtpRequest({
    required this.email,
    required this.otpCode,
  });

  factory OtpRequest.fromJson(Map<String, dynamic> json) => OtpRequest(
        email: json["email"],
        otpCode: json["otpCode"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otpCode": otpCode,
      };
}
