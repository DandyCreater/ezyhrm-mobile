import 'dart:convert';

import 'package:ezyhr_mobile_apps/shared/constant/app_asset_constant.dart';

import 'file_api_res.dart';

AppAssetRes appAssetResFromJson(String str) =>
    AppAssetRes.fromJson(json.decode(str));

String appAssetResToJson(AppAssetRes data) => json.encode(data.toJson());

class AppAssetRes {
  static const pngFormat = "PNG";
  static const svgFormat = "SVG";

  String? name;
  FileApiRes? imgFile;
  String? tagVersion;
  String? imgFormat;

  AppAssetRes({
    this.name,
    this.imgFile,
    this.tagVersion,
    this.imgFormat,
  });

  factory AppAssetRes.fromJson(Map<String, dynamic> json) => AppAssetRes(
        name: json["name"],
        imgFile: json["imgFile"] == null
            ? null
            : FileApiRes.fromJson(json["imgFile"]),
        tagVersion: json["tagVersion"],
        imgFormat: json["imgFormat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imgFile": imgFile?.toJson(),
        "tagVersion": tagVersion,
        "imgFormat": imgFormat,
      };
}

enum ImgPathType { asset, file, network }

AppAssetStorage appAssetStorageFromJson(String str) =>
    AppAssetStorage.fromJson(json.decode(str));
String appAssetStorageToJson(AppAssetStorage data) =>
    json.encode(data.toJson());

class AppAssetStorage {
  String? name;
  String? path;
  String? tagVersion;
  String? imgFormat;

  AppAssetStorage({
    this.name,
    this.path,
    this.tagVersion,
    this.imgFormat,
  });

  factory AppAssetStorage.fromJson(Map<String, dynamic> json) =>
      AppAssetStorage(
        name: json["name"],
        path: json["path"],
        tagVersion: json["tagVersion"],
        imgFormat: json["imgFormat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "tagVersion": tagVersion,
        "imgFormat": imgFormat,
      };
}

class AppAssetTemp {
  final AppAssetEnum assetType;
  final bool isInternal;
  final String path;
  const AppAssetTemp(this.assetType, this.isInternal, this.path);
}
