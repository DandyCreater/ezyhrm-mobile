import 'dart:convert';

PayslipResponse payslipResponseFromJson(String str) =>
    PayslipResponse.fromJson(json.decode(str));

String payslipResponseToJson(PayslipResponse data) =>
    json.encode(data.toJson());

class PayslipResponse {
  bool? success;
  String? status;
  Result? result;

  PayslipResponse({
    this.success,
    this.status,
    this.result,
  });

  factory PayslipResponse.fromJson(Map<String, dynamic> json) =>
      PayslipResponse(
        success: json["success"],
        status: json["status"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "result": result?.toJson(),
      };
}

class Result {
  Pay? pay;
  List<PayDetail>? payDetails;

  Result({
    this.pay,
    this.payDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pay: json["pay"] == null ? null : Pay.fromJson(json["pay"]),
        payDetails: json["payDetails"] == null
            ? []
            : List<PayDetail>.from(
                json["payDetails"]!.map((x) => PayDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pay": pay?.toJson(),
        "payDetails": payDetails == null
            ? []
            : List<dynamic>.from(payDetails!.map((x) => x.toJson())),
      };
}

class Pay {
  num? id;
  num? employeeId;
  String? projectId;
  String? employeeName;
  String? employeeType;
  num? year;
  num? month;
  DateTime? startWorkingDate;
  String? salaryType;
  num? monthlyPayRate;
  num? hourlyPayRate;
  num? monthlyWorkingHours;
  num? monthlyWorkdaysOtHours;
  num? monthlyOffdaysOtHours;
  num? monthlyRestdaysOtHours;
  num? monthlyHolidaysOtHours;
  num? totalOtHours;
  num? totalWorkingHours;
  num? basicSalary;
  num? totalReimbursement;
  num? totalPaycodeOw;
  num? cpFGrossPayOw;
  num? totalPaycodeAw;
  num? cpFGrossPayAw;
  num? cpFGrossPayTw;
  num? totalNoPayLeave;
  num? totalNsLeave;
  num? finalGrossSalary;
  bool? donationCdac;
  num? donationCdacAmount;
  bool? donationMbmf;
  num? donationMbmfAmount;
  bool? donationSinda;
  num? donationSindaAmount;
  bool? donationEcf;
  num? donationEcfAmount;
  bool? donationShare;
  num? donationShareAmount;
  num? donation;
  num? sdl;
  num? employeeContribution;
  num? employeerContribution;
  num? totalContribution;
  num? finalNetPay;
  num? status;
  dynamic remark;
  num? createdBy;
  DateTime? createdAt;
  num? updatedBy;
  DateTime? updatedAt;

  Pay({
    this.id,
    this.employeeId,
    this.projectId,
    this.employeeName,
    this.employeeType,
    this.year,
    this.month,
    this.startWorkingDate,
    this.salaryType,
    this.monthlyPayRate,
    this.hourlyPayRate,
    this.monthlyWorkingHours,
    this.monthlyWorkdaysOtHours,
    this.monthlyOffdaysOtHours,
    this.monthlyRestdaysOtHours,
    this.monthlyHolidaysOtHours,
    this.totalOtHours,
    this.totalWorkingHours,
    this.basicSalary,
    this.totalReimbursement,
    this.totalPaycodeOw,
    this.cpFGrossPayOw,
    this.totalPaycodeAw,
    this.cpFGrossPayAw,
    this.cpFGrossPayTw,
    this.totalNoPayLeave,
    this.totalNsLeave,
    this.finalGrossSalary,
    this.donationCdac,
    this.donationCdacAmount,
    this.donationMbmf,
    this.donationMbmfAmount,
    this.donationSinda,
    this.donationSindaAmount,
    this.donationEcf,
    this.donationEcfAmount,
    this.donationShare,
    this.donationShareAmount,
    this.donation,
    this.sdl,
    this.employeeContribution,
    this.employeerContribution,
    this.totalContribution,
    this.finalNetPay,
    this.status,
    this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        id: json["id"],
        employeeId: json["employeeId"],
        projectId: json["project_id"],
        employeeName: json["employee_name"],
        employeeType: json["employeeType"],
        year: json["year"],
        month: json["month"],
        startWorkingDate: json["start_working_date"] == null
            ? null
            : DateTime.parse(json["start_working_date"]),
        salaryType: json["salary_type"],
        monthlyPayRate: json["monthly_pay_rate"],
        hourlyPayRate: json["hourly_pay_rate"],
        monthlyWorkingHours: json["monthly_working_hours"],
        monthlyWorkdaysOtHours: json["monthly_workdays_ot_hours"],
        monthlyOffdaysOtHours: json["monthly_offdays_ot_hours"],
        monthlyRestdaysOtHours: json["monthly_restdays_ot_hours"],
        monthlyHolidaysOtHours: json["monthly_holidays_ot_hours"],
        totalOtHours: json["total_ot_hours"],
        totalWorkingHours: json["total_working_hours"],
        basicSalary: json["basic_salary"],
        totalReimbursement: json["total_reimbursement"],
        totalPaycodeOw: json["total_paycode_ow"],
        cpFGrossPayOw: json["cpF_Gross_Pay_OW"],
        totalPaycodeAw: json["total_paycode_aw"],
        cpFGrossPayAw: json["cpF_Gross_Pay_AW"],
        cpFGrossPayTw: json["cpF_Gross_Pay_TW"],
        totalNoPayLeave: json["total_no_pay_leave"],
        totalNsLeave: json["total_ns_leave"],
        finalGrossSalary: json["final_gross_salary"],
        donationCdac: json["donation_CDAC"],
        donationCdacAmount: json["donation_CDAC_amount"],
        donationMbmf: json["donation_MBMF"],
        donationMbmfAmount: json["donation_MBMF_amount"],
        donationSinda: json["donation_SINDA"],
        donationSindaAmount: json["donation_SINDA_amount"],
        donationEcf: json["donation_ECF"],
        donationEcfAmount: json["donation_ECF_amount"],
        donationShare: json["donation_share"],
        donationShareAmount: json["donation_share_amount"],
        donation: json["donation"],
        sdl: json["sdl"],
        employeeContribution: json["employee_contribution"],
        employeerContribution: json["employeer_contribution"],
        totalContribution: json["total_contribution"],
        finalNetPay: json["final_net_pay"],
        status: json["status"],
        remark: json["remark"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "project_id": projectId,
        "employee_name": employeeName,
        "employeeType": employeeType,
        "year": year,
        "month": month,
        "start_working_date": startWorkingDate?.toIso8601String(),
        "salary_type": salaryType,
        "monthly_pay_rate": monthlyPayRate,
        "hourly_pay_rate": hourlyPayRate,
        "monthly_working_hours": monthlyWorkingHours,
        "monthly_workdays_ot_hours": monthlyWorkdaysOtHours,
        "monthly_offdays_ot_hours": monthlyOffdaysOtHours,
        "monthly_restdays_ot_hours": monthlyRestdaysOtHours,
        "monthly_holidays_ot_hours": monthlyHolidaysOtHours,
        "total_ot_hours": totalOtHours,
        "total_working_hours": totalWorkingHours,
        "basic_salary": basicSalary,
        "total_reimbursement": totalReimbursement,
        "total_paycode_ow": totalPaycodeOw,
        "cpF_Gross_Pay_OW": cpFGrossPayOw,
        "total_paycode_aw": totalPaycodeAw,
        "cpF_Gross_Pay_AW": cpFGrossPayAw,
        "cpF_Gross_Pay_TW": cpFGrossPayTw,
        "total_no_pay_leave": totalNoPayLeave,
        "total_ns_leave": totalNsLeave,
        "final_gross_salary": finalGrossSalary,
        "donation_CDAC": donationCdac,
        "donation_CDAC_amount": donationCdacAmount,
        "donation_MBMF": donationMbmf,
        "donation_MBMF_amount": donationMbmfAmount,
        "donation_SINDA": donationSinda,
        "donation_SINDA_amount": donationSindaAmount,
        "donation_ECF": donationEcf,
        "donation_ECF_amount": donationEcfAmount,
        "donation_share": donationShare,
        "donation_share_amount": donationShareAmount,
        "donation": donation,
        "sdl": sdl,
        "employee_contribution": employeeContribution,
        "employeer_contribution": employeerContribution,
        "total_contribution": totalContribution,
        "final_net_pay": finalNetPay,
        "status": status,
        "remark": remark,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PayDetail {
  num? id;
  num? payId;
  num? employeeId;
  String? employeeType;
  num? payCodeId;
  String? defaultOrAdditional;
  String? projectId;
  num? year;
  num? month;
  num? amount;
  num? pidDirection;
  bool? texable;
  bool? cpFable;
  bool? admim;
  String? owAw;
  num? status;
  dynamic remark;
  num? createdBy;
  DateTime? createdAt;
  num? updatedBy;
  DateTime? updatedAt;

  PayDetail({
    this.id,
    this.payId,
    this.employeeId,
    this.employeeType,
    this.payCodeId,
    this.defaultOrAdditional,
    this.projectId,
    this.year,
    this.month,
    this.amount,
    this.pidDirection,
    this.texable,
    this.cpFable,
    this.admim,
    this.owAw,
    this.status,
    this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory PayDetail.fromJson(Map<String, dynamic> json) => PayDetail(
        id: json["id"],
        payId: json["payId"],
        employeeId: json["employeeId"],
        employeeType: json["employeeType"],
        payCodeId: json["payCodeId"],
        defaultOrAdditional: json["default_or_additional"],
        projectId: json["project_id"],
        year: json["year"],
        month: json["month"],
        amount: json["amount"],
        pidDirection: json["pid_direction"],
        texable: json["texable"],
        cpFable: json["cpFable"],
        admim: json["admim"],
        owAw: json["ow_aw"],
        status: json["status"],
        remark: json["remark"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payId": payId,
        "employeeId": employeeId,
        "employeeType": employeeType,
        "payCodeId": payCodeId,
        "default_or_additional": defaultOrAdditional,
        "project_id": projectId,
        "year": year,
        "month": month,
        "amount": amount,
        "pid_direction": pidDirection,
        "texable": texable,
        "cpFable": cpFable,
        "admim": admim,
        "ow_aw": owAw,
        "status": status,
        "remark": remark,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
