import 'dart:convert';

FaceSimiliar faceSimiliarFromJson(String str) =>
    FaceSimiliar.fromJson(json.decode(str));

String faceSimiliarToJson(FaceSimiliar data) => json.encode(data.toJson());

class FaceSimiliar {
  bool similarityScore;

  FaceSimiliar({
    required this.similarityScore,
  });

  factory FaceSimiliar.fromJson(Map<String, dynamic> json) => FaceSimiliar(
        similarityScore: json["similarityScore"],
      );

  Map<String, dynamic> toJson() => {
        "similarityScore": similarityScore,
      };
}
