import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../module/widget/common_widget.dart';
import 'api_uri.dart';

class ApiProvider {
  static ApiProvider instance = ApiProvider._();
  ApiProvider._();
  factory ApiProvider() => instance;

  static const _emptySessionId = 'dd341687-de05-4baa-8936-da73e8a8d302';
  static const _emptyToken = '23000058-f6f1-4838-ab6b-8f6cfce8f5a3';

  static final _reqTimeout = dotenv.env['API_TIMEOUT'].toString();
  static final appId = dotenv.env['APP_ID'].toString();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiUri.baseUrl,
      connectTimeout:
          Duration(seconds: (int.tryParse(ApiProvider._reqTimeout) ?? 20)),
    ),
  );

  static const Map<String, dynamic> jsonHeaders = {
    Headers.acceptHeader: Headers.jsonContentType,
    Headers.contentTypeHeader: Headers.jsonContentType,
  };

  Future<void> download(String urlPath, String filename,
      {String? dirPath}) async {
    final req = await Permission.storage.request();
    if (req.isDenied) {
      CommonWidget.showErrorNotif('Permissions Denied');
      return;
    }

    String savePath = dirPath ?? '/storage/emulated/0/Download';
    Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    savePath = '${Platform.pathSeparator}Download';

    CommonWidget.showNotif('Saved to $savePath');
  }
}

class PathHeaders {
  final String path;
  final Map<String, dynamic> headers;
  PathHeaders(this.path, this.headers);
}
