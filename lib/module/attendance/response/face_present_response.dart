import 'dart:convert';

FacePresentResponse facePresentFromJson(String str) =>
    FacePresentResponse.fromJson(json.decode(str));

String facePresentToJson(FacePresentResponse data) =>
    json.encode(data.toJson());

class FacePresentResponse {
  bool isFacePresentResponse;

  FacePresentResponse({
    required this.isFacePresentResponse,
  });

  factory FacePresentResponse.fromJson(Map<String, dynamic> json) =>
      FacePresentResponse(
        isFacePresentResponse: json["isFacePresentResponse"],
      );

  Map<String, dynamic> toJson() => {
        "isFacePresentResponse": isFacePresentResponse,
      };
}
