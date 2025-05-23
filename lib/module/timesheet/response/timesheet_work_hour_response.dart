import 'dart:convert';

TimesheetWorkHourResponse timesheetWorkHourResponseFromJson(String str) =>
    TimesheetWorkHourResponse.fromJson(json.decode(str));

String timesheetWorkHourResponseToJson(TimesheetWorkHourResponse data) =>
    json.encode(data.toJson());

class TimesheetWorkHourResponse {
  int? workHour;
  String? employmentType;
  String? hourlyType;

  TimesheetWorkHourResponse({
    this.workHour,
    this.employmentType,
    this.hourlyType,
  });

  factory TimesheetWorkHourResponse.fromJson(Map<String, dynamic> json) =>
      TimesheetWorkHourResponse(
        workHour: json["workHour"],
        employmentType: json["employmentType"],
        hourlyType: json["hourlyType"],
      );

  Map<String, dynamic> toJson() => {
        "workHour": workHour,
        "employmentType": employmentType,
        "hourlyType": hourlyType,
      };
}
