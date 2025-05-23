import 'dart:convert';

FileApiRes fileApiResFromJson(String str) =>
    FileApiRes.fromJson(json.decode(str));

String fileApiResToJson(FileApiRes data) => json.encode(data.toJson());

class FileApiRes {
  FileApiRes({
    this.id,
    this.title,
    this.description,
    this.url,
  });

  String? id;
  String? title;
  String? description;
  String? url;

  factory FileApiRes.fromJson(Map<String, dynamic> json) => FileApiRes(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
      };
}
