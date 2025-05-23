class ApiConstant {
  static const String BASE_URL = "https://ezyhr.rmagroup.com.sg/api-gateway";
  static const int API_TIMEOUT = 60;

  static const String LOGIN_URL = "/api/mail/loginpassword";
  static const String OTP_URL = "/api/mail/ValidateOTP";
  static const String OTP_URL_V2 = "/api/Mail/validatetotp";
  static const String PROFILE_HRMS_URL = "/api/HRMSRole/ReadEmployee";
  static const String PROFILE_PERSONAL_PARTICULAR_URL =
      "/api/PersonalParticular";

  static const String EMPLOYEE_LEAVE_BALANCE_URL =
      "/api/EmployeeLeaveBalance/LeaveBalanceByEmployeeId";
  static const String EMPLOYEE_LEAVE_HISTORY_URL =
      "/api/EmployeeLeave/ByEmployeeId";
  static const String EMPLOYEE_LEAVE_TYPE_URL = "/api/LeaveType";

  static const String ATTENDANCE_HISTORY_URL = "/api/Attendance/ReadEmployee";
  static const String ATTENDANCE_CHECKIN_URL = "/api/Attendance/Create";
  static const String ATTENDANCE_CHECKOUT_URL = "/api/Attendance/Update";

  static const String PAYSLIP_HISTORY_URL = "/api/Pay/GetAllPayByEmployeeId";
  static const String PAYSLIP_URL = "/api/Pay/GetByEmployeeId";

  static const String REIMBURSMENT_CREATE_URL = "/api/EmployeeClaim";

  static const String REIMBURSMENT_HISTORY_URL = "/api/EmployeeClaim";
  static const String REIMBURSMENT_TYPE_URL = "/api/ClaimTypes";
}
