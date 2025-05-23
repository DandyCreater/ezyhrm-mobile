import 'dart:convert';

import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_response.dart';

StaffMovementPageableResponse staffMovementPageableResponseFromJson(
        String str) =>
    StaffMovementPageableResponse.fromJson(json.decode(str));

String staffMovementPageableResponseToJson(
        StaffMovementPageableResponse data) =>
    json.encode(data.toJson());

class StaffMovementPageableResponse {
  List<StaffMovementResponse>? items;
  int? totalCount;
  int? pageNumber;
  int? lastPage;
  int? pageSize;

  StaffMovementPageableResponse({
    this.items,
    this.totalCount,
    this.pageNumber,
    this.lastPage,
    this.pageSize,
  });

  StaffMovementPageableResponse copyWith({
    List<StaffMovementResponse>? items,
    int? totalCount,
    int? pageNumber,
    int? lastPage,
    int? pageSize,
  }) =>
      StaffMovementPageableResponse(
        items: items ?? this.items,
        totalCount: totalCount ?? this.totalCount,
        pageNumber: pageNumber ?? this.pageNumber,
        lastPage: lastPage ?? this.lastPage,
        pageSize: pageSize ?? this.pageSize,
      );

  factory StaffMovementPageableResponse.fromJson(Map<String, dynamic> json) =>
      StaffMovementPageableResponse(
        items: json["items"] == null
            ? []
            : List<StaffMovementResponse>.from(
                json["items"]!.map((x) => StaffMovementResponse.fromJson(x))),
        totalCount: json["totalCount"],
        pageNumber: json["pageNumber"],
        lastPage: json["lastPage"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "pageNumber": pageNumber,
        "lastPage": lastPage,
        "pageSize": pageSize,
      };
  void reverseItems() {
    if (items != null) {
      items = items!.reversed.toList();
    }
  }
}
