import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';

class TimesheetApprovalDto {
  int status = 0;
  SupervisorEmployeeResponse employee;
  List<TimesheetApprovalWeeklyDto> timesheetApprovalWeeklyDto;

  TimesheetApprovalDto({
    required this.status,
    required this.employee,
    required this.timesheetApprovalWeeklyDto,
  });
}

class TimesheetApprovalWeeklyDto {
  DateTime startDate;
  DateTime endDate;
  List<TimesheetApprovalDailyDto> timesheet;

  TimesheetApprovalWeeklyDto({
    required this.startDate,
    required this.endDate,
    required this.timesheet,
  });
}

class TimesheetApprovalDailyDto {
  DateTime date;
  TimesheetDto timesheet;

  TimesheetApprovalDailyDto({
    required this.date,
    required this.timesheet,
  });
}
