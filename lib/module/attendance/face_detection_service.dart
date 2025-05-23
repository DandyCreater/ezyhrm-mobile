import 'dart:developer';
import 'dart:io';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

class FaceDetectionService {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: true,
      minFaceSize: 0.15,
    ),
  );

  Future<bool> isFacePresent(String imagePath) async {
    try {
      log('isFacePresent error 1');
      final inputImage = InputImage.fromFilePath(imagePath);
      log('isFacePresent error 2');
      final List<Face> faces = await _faceDetector.processImage(inputImage);
      log('isFacePresent error 3');
      log(faces.length.toString());
      log('isFacePresent error 4');
      return faces.isNotEmpty;
    } catch (e) {
      // print('Error detecting face: $e');
      log('Error detecting face: $e');
      return false;
    }
  }

  Future<bool> isFaceSimiliar(String imagePath1, String imagePath2) async {
    try {
      final inputImage1 = InputImage.fromFilePath(imagePath1);
      final inputImage2 = InputImage.fromFilePath(imagePath2);

      final List<Face> faces1 = await _faceDetector.processImage(inputImage1);
      final List<Face> faces2 = await _faceDetector.processImage(inputImage2);

      if (faces1.isEmpty || faces2.isEmpty) {
        return false;
      }

      final Face face1 = faces1.first;
      final Face face2 = faces2.first;

      return await _compareFaceFeatures(face1, face2, imagePath1, imagePath2);
    } catch (e) {
      print('Error comparing faces: $e');
      return false;
    }
  }

  Future<bool> _compareFaceFeatures(
      Face face1, Face face2, String imagePath1, String imagePath2) async {
    try {
      final File file1 = File(imagePath1);
      final File file2 = File(imagePath2);
      final img.Image? image1 = img.decodeImage(await file1.readAsBytes());
      final img.Image? image2 = img.decodeImage(await file2.readAsBytes());

      if (image1 == null || image2 == null) return false;

      bool similarHeadRotation = _compareRotation(face1, face2);
      bool similarSize = _compareFaceSize(face1, face2, image1, image2);
      bool similarSmiling = _compareSmiling(face1, face2);

      int matchCount = 0;
      if (similarHeadRotation) matchCount++;
      if (similarSize) matchCount++;
      if (similarSmiling) matchCount++;

      return matchCount >= 2;
    } catch (e) {
      // print('Error in feature comparison: $e');
      log('Error in feature comparison: $e');
      return false;
    }
  }

  bool _compareRotation(Face face1, Face face2) {
    const double angleThreshold = 15.0;

    double yDiff = (face1.headEulerAngleY ?? 0) - (face2.headEulerAngleY ?? 0);
    double zDiff = (face1.headEulerAngleZ ?? 0) - (face2.headEulerAngleZ ?? 0);

    return yDiff.abs() < angleThreshold && zDiff.abs() < angleThreshold;
  }

  bool _compareFaceSize(
      Face face1, Face face2, img.Image image1, img.Image image2) {
    const double sizeThreshold = 0.2;

    double relativeSize1 = face1.boundingBox.width *
        face1.boundingBox.height /
        (image1.width * image1.height);
    double relativeSize2 = face2.boundingBox.width *
        face2.boundingBox.height /
        (image2.width * image2.height);

    double sizeDifference = (relativeSize1 - relativeSize2).abs();
    return sizeDifference < sizeThreshold;
  }

  bool _compareSmiling(Face face1, Face face2) {
    const double smileThreshold = 0.3;

    bool isSmiling1 = (face1.smilingProbability ?? 0) > smileThreshold;
    bool isSmiling2 = (face2.smilingProbability ?? 0) > smileThreshold;

    return isSmiling1 == isSmiling2;
  }

  void dispose() {
    _faceDetector.close();
  }
}
