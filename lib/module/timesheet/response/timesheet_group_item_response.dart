import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';
import 'package:flutter/material.dart';

class TimesheetGroupItemResponse {
  DateTime date;
  TimesheetDto timesheet;
  TextEditingController controller;
  TimesheetGroupItemResponse({
    required this.date,
    required this.timesheet,
    required this.controller,
  });
}
