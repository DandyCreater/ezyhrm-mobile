import 'package:ezyhr_mobile_apps/module/attendance/create_attendance/attendance_controller.dart';
import 'package:ezyhr_mobile_apps/module/attendance/list_attendance/list_attendance_controller.dart';
import 'package:ezyhr_mobile_apps/module/auth/biometric/biometric_controller.dart';
import 'package:ezyhr_mobile_apps/module/auth/login/login_controller.dart';
import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/home/home_controller.dart';
import 'package:ezyhr_mobile_apps/module/instance/instance_controller.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_form/request_form_controller.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/list_leave_request/list_leave_request_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/otp/otp_controller.dart';
import 'package:ezyhr_mobile_apps/module/payslip/detail_payslip/detail_payslip_controller.dart';
import 'package:ezyhr_mobile_apps/module/payslip/list_payslip/list_payslip_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/app_info/app_info_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_controller.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/list_reimbursement/list_reimbursement_controller.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_form/reimbursement_form_controller.dart';
import 'package:ezyhr_mobile_apps/module/splash/splash_controller.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_controller.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_controller.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> routes = [
    SplashC.page,
    LoginC.page,
    OtpC.page,
    DashboardC.page,
    HomeC.page,
    InstanceC.page,
    ProfileC.page,
    LeaveRequestC.page,
    LRequestFormC.page,
    LeaveRequestC.leaveRequestDetailsPage,
    LeaveRequestC.leaveBalancePage,
    AttendanceC.page,
    ListAttendanceC.page,
    ListAttendanceC.attendanceDetailsPage,
    ReimbursementC.page,
    ReimbursementFormC.page,
    ReimbursementC.pageDetails,
    ReimbursementC.reimbursementBalancePage,
    PayslipC.page,
    BiometricC.page,
    DetailPayslipC.page,
    PersonalDetailsC.personalDetailsPage,
    PersonalDetailsC.personalDetailsEditPage,
    PersonalDetailsC.addressPage,
    PersonalDetailsC.addressEditPage,
    PersonalDetailsC.contributionPage,
    PersonalDetailsC.contributionEditPage,
    PersonalDetailsC.kinListPage,
    PersonalDetailsC.kinPage,
    PersonalDetailsC.kinEditPage,
    PersonalDetailsC.childrenListPage,
    PersonalDetailsC.childrenPage,
    PersonalDetailsC.childrenEditPage,
    ChangePasswordC.page,
    TimesheetC.timeSheetListPage,
    TimesheetC.timesheetWeekPage,
    TimesheetC.timesheetDayPage,
    PersonalDetailsC.bankAccountPage,
    PersonalDetailsC.bankAccountEditPage,
    ManagerDashboardC.page,
    LeaveApprovalC.page,
    LeaveApprovalC.detailPage,
    AttendanceApprovalC.page,
    AttendanceApprovalC.detailPage,
    ReimbursementApprovalC.page,
    ReimbursementApprovalC.detailPage,
    TimesheetApprovalC.page,
    TimesheetApprovalC.detailPage,
    StaffMovementC.pageCreate,
    StaffMovementC.pageDetail,
    AppInfoC.page,
  ];
}
