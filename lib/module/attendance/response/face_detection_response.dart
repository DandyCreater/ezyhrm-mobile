class FaceDetectionResponse {
  final dynamic similarityScore;
  final bool? results;

  const FaceDetectionResponse({
    required this.results,
    required this.similarityScore,
  });

  factory FaceDetectionResponse.fromJson(Map<String, dynamic> json) {
    return FaceDetectionResponse(
      results: json['results'],
      similarityScore: json['similarityScore'],
    );
  }
}
