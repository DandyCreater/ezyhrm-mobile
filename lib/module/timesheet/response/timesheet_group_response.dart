import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_group_item_response.dart';

class TimesheetGroupResponse {
  DateTime startDate;
  DateTime endDate;
  List<TimesheetGroupItemResponse> listDatetime;
  double hoursWorked;
  double otHours;
  TimesheetGroupResponse({
    required this.startDate,
    required this.endDate,
    required this.listDatetime,
    required this.hoursWorked,
    required this.otHours,
  });
}
