import 'dart:convert';

TimesheetWorkHourRequest timesheetWorkHourRequestFromJson(String str) =>
    TimesheetWorkHourRequest.fromJson(json.decode(str));

String timesheetWorkHourRequestToJson(TimesheetWorkHourRequest data) =>
    json.encode(data.toJson());

class TimesheetWorkHourRequest {
  String? route;
  int? emploId;

  TimesheetWorkHourRequest({
    this.route,
    this.emploId,
  });

  factory TimesheetWorkHourRequest.fromJson(Map<String, dynamic> json) =>
      TimesheetWorkHourRequest(
        route: json["route"],
        emploId: json["emploId"],
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "emploId": emploId,
      };
}
