import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_work_hour_response.dart';

class AttendanceApprovalDto {
  SupervisorEmployeeResponse? employeeList;
  AttendanceData? attendanceResponse;
  String? profilePicture;
  TimesheetWorkHourResponse? timesheetWorkHourResponse;

  AttendanceApprovalDto(
      {this.employeeList,
      this.attendanceResponse,
      this.profilePicture,
      this.timesheetWorkHourResponse});
}
