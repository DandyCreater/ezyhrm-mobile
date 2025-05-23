import 'dart:convert';

import 'file_api_res.dart';

MenuRes menuResFromJson(String str) => MenuRes.fromJson(json.decode(str));

String menuResToJson(MenuRes data) => json.encode(data.toJson());

class MenuRes {
  MenuRes({
    this.id,
    this.nameId,
    this.displayName,
    this.description,
    this.parent,
    this.haveChild,
    this.imgFile,
  });

  String? id;
  String? nameId;
  String? displayName;
  String? description;
  MenuRes? parent;
  bool? haveChild;
  FileApiRes? imgFile;

  factory MenuRes.fromJson(Map<String, dynamic> json) => MenuRes(
        id: json["id"],
        nameId: json["nameId"],
        displayName: json["displayName"],
        description: json["description"],
        parent:
            json["parent"] != null ? MenuRes.fromJson(json["parent"]) : null,
        haveChild: json["haveChild"],
        imgFile: json["imgFile"] != null
            ? FileApiRes.fromJson(json["imgFile"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameId": nameId,
        "displayName": displayName,
        "description": description,
        "parent": parent?.toJson(),
        "haveChild": haveChild,
        "imgFile": imgFile?.toJson(),
      };
}
