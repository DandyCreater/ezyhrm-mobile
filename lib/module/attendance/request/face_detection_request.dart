import 'package:dio/dio.dart';

class FaceDetectionRequest {
  final String? imageBytes1;
  final String? imageBytes2;

  const FaceDetectionRequest(
      {required this.imageBytes1, required this.imageBytes2});

  Map<String, dynamic> toJson() => {
        'face1byte': imageBytes1,
        'face2byte': imageBytes2,
      };

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'files1': await MultipartFile.fromFile(
        imageBytes1!,
        filename: 'face1.jpg',
      ),
      'files2': await MultipartFile.fromFile(
        imageBytes2!,
        filename: 'face2.jpg',
      ),
    });
  }
}
