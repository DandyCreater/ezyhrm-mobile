import 'dart:convert';

NhcFormDetailsResponse nhcFormDetailsResponseFromJson(String str) =>
    NhcFormDetailsResponse.fromJson(json.decode(str));

String nhcFormDetailsResponseToJson(NhcFormDetailsResponse data) =>
    json.encode(data.toJson());

class NhcFormDetailsResponse {
  bool? success;
  Status? status;
  Result? result;

  NhcFormDetailsResponse({
    this.success,
    this.status,
    this.result,
  });

  factory NhcFormDetailsResponse.fromJson(Map<String, dynamic> json) =>
      NhcFormDetailsResponse(
        success: json["success"],
        status: statusValues.map[json["status"]]!,
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": statusValues.reverse[status],
        "result": result?.toJson(),
      };
}

class Result {
  SelectedNhcTemplateModel? selectedNhcTemplateModel;
  dynamic generalDetailsModel;
  AdministrativeDetailsModel? administrativeDetailsModel;
  EmployeeDetailsModel? employeeDetailsModel;
  RenumerationDetailsModel? renumerationDetailsModel;
  LeaveDetailsModel? leaveDetailsModel;
  dynamic supervisorDetailsModel;
  dynamic managerDetailsModel;
  dynamic signoffDetailsModel;
  dynamic signoffByModel;

  Result({
    this.selectedNhcTemplateModel,
    this.generalDetailsModel,
    this.administrativeDetailsModel,
    this.employeeDetailsModel,
    this.renumerationDetailsModel,
    this.leaveDetailsModel,
    this.supervisorDetailsModel,
    this.managerDetailsModel,
    this.signoffDetailsModel,
    this.signoffByModel,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        selectedNhcTemplateModel: json["selectedNHCTemplateModel"] == null
            ? null
            : SelectedNhcTemplateModel.fromJson(
                json["selectedNHCTemplateModel"]),
        generalDetailsModel: json["generalDetailsModel"],
        administrativeDetailsModel: json["administrativeDetailsModel"] == null
            ? null
            : AdministrativeDetailsModel.fromJson(
                json["administrativeDetailsModel"]),
        employeeDetailsModel: json["employeeDetailsModel"] == null
            ? null
            : EmployeeDetailsModel.fromJson(json["employeeDetailsModel"]),
        renumerationDetailsModel: json["renumerationDetailsModel"] == null
            ? null
            : RenumerationDetailsModel.fromJson(
                json["renumerationDetailsModel"]),
        leaveDetailsModel: json["leaveDetailsModel"] == null
            ? null
            : LeaveDetailsModel.fromJson(json["leaveDetailsModel"]),
        supervisorDetailsModel: json["supervisorDetailsModel"],
        managerDetailsModel: json["managerDetailsModel"],
        signoffDetailsModel: json["signoffDetailsModel"],
        signoffByModel: json["signoffByModel"],
      );

  Map<String, dynamic> toJson() => {
        "selectedNHCTemplateModel": selectedNhcTemplateModel?.toJson(),
        "generalDetailsModel": generalDetailsModel,
        "administrativeDetailsModel": administrativeDetailsModel?.toJson(),
        "employeeDetailsModel": employeeDetailsModel?.toJson(),
        "renumerationDetailsModel": renumerationDetailsModel?.toJson(),
        "leaveDetailsModel": leaveDetailsModel?.toJson(),
        "supervisorDetailsModel": supervisorDetailsModel,
        "managerDetailsModel": managerDetailsModel,
        "signoffDetailsModel": signoffDetailsModel,
        "signoffByModel": signoffByModel,
      };
}

class AdministrativeDetailsModel {
  dynamic dateOfPositionRequest;
  dynamic rmABillingEntity;
  dynamic contractType;
  dynamic employmentType;
  dynamic workOrder;
  dynamic purchaseOrderNo;
  dynamic placementType;
  dynamic placementFeeType;
  dynamic serviceFeeType;
  dynamic billingIndicatorCode;
  dynamic eInvoiceType;
  dynamic billingEntityType;
  dynamic billingType;
  dynamic invoicingInstructionId;
  dynamic billingEntityAddress;
  dynamic costCentre;
  dynamic billingAttentionName;
  dynamic billingModel;
  dynamic billingRate;
  dynamic billingRateAllowance;
  dynamic billingMonthlyServiceFee;
  dynamic billingSubBusinessUnit;
  dynamic geBizItqRfqRefNo;
  dynamic isPaymentCertRequired;
  dynamic emailContactsNo;
  dynamic rateCardJobTitle;
  dynamic rateCardJobTitleMin;
  dynamic rateCardJobTitleMax;
  dynamic remarks;

  AdministrativeDetailsModel({
    this.dateOfPositionRequest,
    this.rmABillingEntity,
    this.contractType,
    this.employmentType,
    this.workOrder,
    this.purchaseOrderNo,
    this.placementType,
    this.placementFeeType,
    this.serviceFeeType,
    this.billingIndicatorCode,
    this.eInvoiceType,
    this.billingEntityType,
    this.billingType,
    this.invoicingInstructionId,
    this.billingEntityAddress,
    this.costCentre,
    this.billingAttentionName,
    this.billingModel,
    this.billingRate,
    this.billingRateAllowance,
    this.billingMonthlyServiceFee,
    this.billingSubBusinessUnit,
    this.geBizItqRfqRefNo,
    this.isPaymentCertRequired,
    this.emailContactsNo,
    this.rateCardJobTitle,
    this.rateCardJobTitleMin,
    this.rateCardJobTitleMax,
    this.remarks,
  });

  factory AdministrativeDetailsModel.fromJson(Map<String, dynamic> json) =>
      AdministrativeDetailsModel(
        dateOfPositionRequest: json["date_Of_Position_Request"],
        rmABillingEntity: json["rmA_Billing_Entity"],
        contractType: json["contract_Type"],
        employmentType: json["employment_Type"],
        workOrder: json["work_Order"],
        purchaseOrderNo: json["purchase_Order_No"],
        placementType: json["placement_Type"],
        placementFeeType: json["placement_Fee_Type"],
        serviceFeeType: json["service_Fee_Type"],
        billingIndicatorCode: json["billing_Indicator_Code"],
        eInvoiceType: json["e_Invoice_Type"],
        billingEntityType: json["billing_Entity_Type"],
        billingType: json["billing_Type"],
        invoicingInstructionId: json["invoicing_Instruction_ID"],
        billingEntityAddress: json["billing_Entity_Address"],
        costCentre: json["cost_Centre"],
        billingAttentionName: json["billing_Attention_Name"],
        billingModel: json["billing_Model"],
        billingRate: json["billing_Rate"],
        billingRateAllowance: json["billing_Rate_Allowance"],
        billingMonthlyServiceFee: json["billing_Monthly_Service_Fee"],
        billingSubBusinessUnit: json["billing_SubBusiness_Unit"],
        geBizItqRfqRefNo: json["geBIZ_ITQ_RFQ_RefNo"],
        isPaymentCertRequired: json["is_Payment_Cert_Required"],
        emailContactsNo: json["email_Contacts_No"],
        rateCardJobTitle: json["rate_Card_Job_Title"],
        rateCardJobTitleMin: json["rate_Card_Job_Title_Min"],
        rateCardJobTitleMax: json["rate_Card_Job_Title_Max"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "date_Of_Position_Request": dateOfPositionRequest,
        "rmA_Billing_Entity": rmABillingEntity,
        "contract_Type": contractType,
        "employment_Type": employmentType,
        "work_Order": workOrder,
        "purchase_Order_No": purchaseOrderNo,
        "placement_Type": placementType,
        "placement_Fee_Type": placementFeeType,
        "service_Fee_Type": serviceFeeType,
        "billing_Indicator_Code": billingIndicatorCode,
        "e_Invoice_Type": eInvoiceType,
        "billing_Entity_Type": billingEntityType,
        "billing_Type": billingType,
        "invoicing_Instruction_ID": invoicingInstructionId,
        "billing_Entity_Address": billingEntityAddress,
        "cost_Centre": costCentre,
        "billing_Attention_Name": billingAttentionName,
        "billing_Model": billingModel,
        "billing_Rate": billingRate,
        "billing_Rate_Allowance": billingRateAllowance,
        "billing_Monthly_Service_Fee": billingMonthlyServiceFee,
        "billing_SubBusiness_Unit": billingSubBusinessUnit,
        "geBIZ_ITQ_RFQ_RefNo": geBizItqRfqRefNo,
        "is_Payment_Cert_Required": isPaymentCertRequired,
        "email_Contacts_No": emailContactsNo,
        "rate_Card_Job_Title": rateCardJobTitle,
        "rate_Card_Job_Title_Min": rateCardJobTitleMin,
        "rate_Card_Job_Title_Max": rateCardJobTitleMax,
        "remarks": remarks,
      };
}

class EmployeeDetailsModel {
  String? fullNameAsPerNric;
  String? workAuthorizationType;
  NriCPrFinNo? nriCPrFinNo;
  dynamic pRIssueDate;
  ContactNumber? contactNumber;
  DateTime? dateOfBirth;
  String? emailAddress;
  dynamic residentialAddress;
  String? jobTitle;
  String? department;
  String? workingLocation;
  dynamic educationLevel;
  dynamic disciplineNRoles;
  dynamic departmentNArea;
  String? jobCategory;
  String? remarks;
  dynamic fiNExpiryDate;
  dynamic referenceCheck;
  dynamic medicalCheck;

  EmployeeDetailsModel({
    this.fullNameAsPerNric,
    this.workAuthorizationType,
    this.nriCPrFinNo,
    this.pRIssueDate,
    this.contactNumber,
    this.dateOfBirth,
    this.emailAddress,
    this.residentialAddress,
    this.jobTitle,
    this.department,
    this.workingLocation,
    this.educationLevel,
    this.disciplineNRoles,
    this.departmentNArea,
    this.jobCategory,
    this.remarks,
    this.fiNExpiryDate,
    this.referenceCheck,
    this.medicalCheck,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsModel(
        fullNameAsPerNric: json["full_Name_As_Per_NRIC"],
        workAuthorizationType: json["work_Authorization_Type"],
        nriCPrFinNo: json["nriC_PR_FIN_No"] == null
            ? null
            : NriCPrFinNo.fromJson(json["nriC_PR_FIN_No"]),
        pRIssueDate: json["pR_Issue_Date"],
        contactNumber: json["contact_Number"] == null
            ? null
            : ContactNumber.fromJson(json["contact_Number"]),
        dateOfBirth: json["date_Of_Birth"] == null
            ? null
            : DateTime.parse(json["date_Of_Birth"]),
        emailAddress: json["email_Address"],
        residentialAddress: json["residential_Address"],
        jobTitle: json["job_Title"],
        department: json["department"],
        workingLocation: json["working_Location"],
        educationLevel: json["education_Level"],
        disciplineNRoles: json["discipline_N_Roles"],
        departmentNArea: json["department_N_Area"],
        jobCategory: json["job_Category"],
        remarks: json["remarks"],
        fiNExpiryDate: json["fiN_Expiry_Date"],
        referenceCheck: json["reference_Check"],
        medicalCheck: json["medical_Check"],
      );

  Map<String, dynamic> toJson() => {
        "full_Name_As_Per_NRIC": fullNameAsPerNric,
        "work_Authorization_Type": workAuthorizationType,
        "nriC_PR_FIN_No": nriCPrFinNo?.toJson(),
        "pR_Issue_Date": pRIssueDate,
        "contact_Number": contactNumber?.toJson(),
        "date_Of_Birth": dateOfBirth?.toIso8601String(),
        "email_Address": emailAddress,
        "residential_Address": residentialAddress,
        "job_Title": jobTitle,
        "department": department,
        "working_Location": workingLocation,
        "education_Level": educationLevel,
        "discipline_N_Roles": disciplineNRoles,
        "department_N_Area": departmentNArea,
        "job_Category": jobCategory,
        "remarks": remarks,
        "fiN_Expiry_Date": fiNExpiryDate,
        "reference_Check": referenceCheck,
        "medical_Check": medicalCheck,
      };
}

class ContactNumber {
  String? residentialNo;
  String? mobileNo;

  ContactNumber({
    this.residentialNo,
    this.mobileNo,
  });

  factory ContactNumber.fromJson(Map<String, dynamic> json) => ContactNumber(
        residentialNo: json["residential_no"],
        mobileNo: json["mobile_no"],
      );

  Map<String, dynamic> toJson() => {
        "residential_no": residentialNo,
        "mobile_no": mobileNo,
      };
}

class NriCPrFinNo {
  dynamic ifotherValue;
  String? tbValue;

  NriCPrFinNo({
    this.ifotherValue,
    this.tbValue,
  });

  factory NriCPrFinNo.fromJson(Map<String, dynamic> json) => NriCPrFinNo(
        ifotherValue: json["ifother_value"],
        tbValue: json["tb_value"],
      );

  Map<String, dynamic> toJson() => {
        "ifother_value": ifotherValue,
        "tb_value": tbValue,
      };
}

class LeaveDetailsModel {
  DateTime? contractStartDate;
  DateTime? contractEndDate;
  AnnualLeaveEntitlementAnnum? annualLeaveEntitlementAnnum;
  EntitledCarryForwardLeaveDays? entitledCarryForwardLeaveDays;
  dynamic entitledAnnualLeaveEncashment;
  dynamic medicalLeaveEntitlementAnnum;
  ProbationPeriod? probationPeriod;
  dynamic noticePeriodNoticePeriodDuringProbation;
  dynamic noticePeriodNoticePeriodDuringProbationDummy;

  LeaveDetailsModel({
    this.contractStartDate,
    this.contractEndDate,
    this.annualLeaveEntitlementAnnum,
    this.entitledCarryForwardLeaveDays,
    this.entitledAnnualLeaveEncashment,
    this.medicalLeaveEntitlementAnnum,
    this.probationPeriod,
    this.noticePeriodNoticePeriodDuringProbation,
    this.noticePeriodNoticePeriodDuringProbationDummy,
  });

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) =>
      LeaveDetailsModel(
        contractStartDate: json["contract_Start_Date"] == null
            ? null
            : DateTime.parse(json["contract_Start_Date"]),
        contractEndDate: json["contract_End_Date"] == null
            ? null
            : DateTime.parse(json["contract_End_Date"]),
        annualLeaveEntitlementAnnum:
            json["annual_Leave_Entitlement_Annum"] == null
                ? null
                : AnnualLeaveEntitlementAnnum.fromJson(
                    json["annual_Leave_Entitlement_Annum"]),
        entitledCarryForwardLeaveDays:
            json["entitled_Carry_Forward_Leave_Days"] == null
                ? null
                : EntitledCarryForwardLeaveDays.fromJson(
                    json["entitled_Carry_Forward_Leave_Days"]),
        entitledAnnualLeaveEncashment: json["entitled_Annual_Leave_Encashment"],
        medicalLeaveEntitlementAnnum: json["medical_Leave_Entitlement_Annum"],
        probationPeriod: json["probation_Period"] == null
            ? null
            : ProbationPeriod.fromJson(json["probation_Period"]),
        noticePeriodNoticePeriodDuringProbation:
            json["notice_Period_Notice_Period_During_Probation"],
        noticePeriodNoticePeriodDuringProbationDummy:
            json["notice_Period_Notice_Period_During_Probation_Dummy"],
      );

  Map<String, dynamic> toJson() => {
        "contract_Start_Date": contractStartDate?.toIso8601String(),
        "contract_End_Date": contractEndDate?.toIso8601String(),
        "annual_Leave_Entitlement_Annum": annualLeaveEntitlementAnnum?.toJson(),
        "entitled_Carry_Forward_Leave_Days":
            entitledCarryForwardLeaveDays?.toJson(),
        "entitled_Annual_Leave_Encashment": entitledAnnualLeaveEncashment,
        "medical_Leave_Entitlement_Annum": medicalLeaveEntitlementAnnum,
        "probation_Period": probationPeriod?.toJson(),
        "notice_Period_Notice_Period_During_Probation":
            noticePeriodNoticePeriodDuringProbation,
        "notice_Period_Notice_Period_During_Probation_Dummy":
            noticePeriodNoticePeriodDuringProbationDummy,
      };
}

class AnnualLeaveEntitlementAnnum {
  dynamic ddlValue;
  String? tbValue;

  AnnualLeaveEntitlementAnnum({
    this.ddlValue,
    this.tbValue,
  });

  factory AnnualLeaveEntitlementAnnum.fromJson(Map<String, dynamic> json) =>
      AnnualLeaveEntitlementAnnum(
        ddlValue: json["ddl_value"],
        tbValue: json["tb_value"],
      );

  Map<String, dynamic> toJson() => {
        "ddl_value": ddlValue,
        "tb_value": tbValue,
      };
}

class EntitledCarryForwardLeaveDays {
  CpFContributionCfs? ddlValue;
  String? amount;

  EntitledCarryForwardLeaveDays({
    this.ddlValue,
    this.amount,
  });

  factory EntitledCarryForwardLeaveDays.fromJson(Map<String, dynamic> json) =>
      EntitledCarryForwardLeaveDays(
        ddlValue: cpFContributionCfsValues.map[json["ddl_value"]]!,
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "ddl_value": cpFContributionCfsValues.reverse[ddlValue],
        "amount": amount,
      };
}

enum CpFContributionCfs { N, Y }

final cpFContributionCfsValues =
    EnumValues({"N": CpFContributionCfs.N, "Y": CpFContributionCfs.Y});

class ProbationPeriod {
  CpFContributionCfs? ddlValue;
  String? tbValue;
  String? ddl2Value;

  ProbationPeriod({
    this.ddlValue,
    this.tbValue,
    this.ddl2Value,
  });

  factory ProbationPeriod.fromJson(Map<String, dynamic> json) =>
      ProbationPeriod(
        ddlValue: cpFContributionCfsValues.map[json["ddl_value"]]!,
        tbValue: json["tb_value"],
        ddl2Value: json["ddl2_value"],
      );

  Map<String, dynamic> toJson() => {
        "ddl_value": cpFContributionCfsValues.reverse[ddlValue],
        "tb_value": tbValue,
        "ddl2_value": ddl2Value,
      };
}

class RenumerationDetailsModel {
  dynamic employedBy;
  String? rateType;
  String? rateHourlyType;
  BasicSalary? basicSalary;
  String? salaryType;
  dynamic monthlyRate;
  BasicSalary? dailyRate;
  String? basicHourlyRate;
  dynamic regularHourlyRate;
  bool? basicSalaryMonthlyToggleOnOff;
  bool? basicSalaryDailyToggleOnOff;
  bool? basicSalaryHourlyToggleOnOff;
  OTRateDtRate? oTRateDtRate;
  String? minWorkingHrsForOt;
  dynamic overtimeEntitlement;
  CpFContributionCfs? cpFContributionCfs;
  ContractualDaysHoursLunch? contractualDaysHoursLunch;
  ShiftDaysHours? shiftDaysHours;
  dynamic paidPublicHoliday;
  dynamic awSBonusEntitlement;
  Map<String, String?>? allowanceAmountType;
  MedicalInsuranceType? medicalInsuranceType;
  dynamic entitledMedicalBenefitsEncashment;
  dynamic timeWriteModule;
  String? reimbursementModule;
  dynamic leaveModule;
  dynamic payScheme;
  dynamic manualPayslip;
  dynamic penaltyBond;
  dynamic remark;

  RenumerationDetailsModel({
    this.employedBy,
    this.rateType,
    this.rateHourlyType,
    this.basicSalary,
    this.salaryType,
    this.monthlyRate,
    this.dailyRate,
    this.basicHourlyRate,
    this.regularHourlyRate,
    this.basicSalaryMonthlyToggleOnOff,
    this.basicSalaryDailyToggleOnOff,
    this.basicSalaryHourlyToggleOnOff,
    this.oTRateDtRate,
    this.minWorkingHrsForOt,
    this.overtimeEntitlement,
    this.cpFContributionCfs,
    this.contractualDaysHoursLunch,
    this.shiftDaysHours,
    this.paidPublicHoliday,
    this.awSBonusEntitlement,
    this.allowanceAmountType,
    this.medicalInsuranceType,
    this.entitledMedicalBenefitsEncashment,
    this.timeWriteModule,
    this.reimbursementModule,
    this.leaveModule,
    this.payScheme,
    this.manualPayslip,
    this.penaltyBond,
    this.remark,
  });

  factory RenumerationDetailsModel.fromJson(Map<String, dynamic> json) =>
      RenumerationDetailsModel(
        employedBy: json["employed_By"],
        rateType: json["rate_Type"],
        rateHourlyType: json["rate_Hourly_Type"],
        basicSalary: json["basic_Salary"] == null
            ? null
            : BasicSalary.fromJson(json["basic_Salary"]),
        salaryType: json["salary_Type"],
        monthlyRate: json["monthly_Rate"],
        dailyRate: json["daily_Rate"] == null
            ? null
            : BasicSalary.fromJson(json["daily_Rate"]),
        basicHourlyRate: json["basic_Hourly_Rate"],
        regularHourlyRate: json["regular_Hourly_Rate"],
        basicSalaryMonthlyToggleOnOff: json["basicSalaryMonthlyToggleOnOff"],
        basicSalaryDailyToggleOnOff: json["basicSalaryDailyToggleOnOff"],
        basicSalaryHourlyToggleOnOff: json["basicSalaryHourlyToggleOnOff"],
        oTRateDtRate: json["oT_Rate_DT_Rate"] == null
            ? null
            : OTRateDtRate.fromJson(json["oT_Rate_DT_Rate"]),
        minWorkingHrsForOt: json["min_Working_Hrs_For_OT"],
        overtimeEntitlement: json["overtime_Entitlement"],
        cpFContributionCfs:
            cpFContributionCfsValues.map[json["cpF_Contribution_CFS"]]!,
        contractualDaysHoursLunch: json["contractual_Days_Hours_Lunch"] == null
            ? null
            : ContractualDaysHoursLunch.fromJson(
                json["contractual_Days_Hours_Lunch"]),
        shiftDaysHours: json["shift_Days_Hours"] == null
            ? null
            : ShiftDaysHours.fromJson(json["shift_Days_Hours"]),
        paidPublicHoliday: json["paid_Public_Holiday"],
        awSBonusEntitlement: json["awS_Bonus_Entitlement"],
        allowanceAmountType: Map.from(json["allowance_Amount_Type"]!)
            .map((k, v) => MapEntry<String, String?>(k, v)),
        medicalInsuranceType: json["medical_Insurance_Type"] == null
            ? null
            : MedicalInsuranceType.fromJson(json["medical_Insurance_Type"]),
        entitledMedicalBenefitsEncashment:
            json["entitled_Medical_Benefits_Encashment"],
        timeWriteModule: json["time_Write_Module"],
        reimbursementModule: json["reimbursement_Module"],
        leaveModule: json["leave_Module"],
        payScheme: json["pay_Scheme"],
        manualPayslip: json["manual_Payslip"],
        penaltyBond: json["penalty_Bond"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "employed_By": employedBy,
        "rate_Type": rateType,
        "rate_Hourly_Type": rateHourlyType,
        "basic_Salary": basicSalary?.toJson(),
        "salary_Type": salaryType,
        "monthly_Rate": monthlyRate,
        "daily_Rate": dailyRate?.toJson(),
        "basic_Hourly_Rate": basicHourlyRate,
        "regular_Hourly_Rate": regularHourlyRate,
        "basicSalaryMonthlyToggleOnOff": basicSalaryMonthlyToggleOnOff,
        "basicSalaryDailyToggleOnOff": basicSalaryDailyToggleOnOff,
        "basicSalaryHourlyToggleOnOff": basicSalaryHourlyToggleOnOff,
        "oT_Rate_DT_Rate": oTRateDtRate?.toJson(),
        "min_Working_Hrs_For_OT": minWorkingHrsForOt,
        "overtime_Entitlement": overtimeEntitlement,
        "cpF_Contribution_CFS":
            cpFContributionCfsValues.reverse[cpFContributionCfs],
        "contractual_Days_Hours_Lunch": contractualDaysHoursLunch?.toJson(),
        "shift_Days_Hours": shiftDaysHours?.toJson(),
        "paid_Public_Holiday": paidPublicHoliday,
        "awS_Bonus_Entitlement": awSBonusEntitlement,
        "allowance_Amount_Type": Map.from(allowanceAmountType!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "medical_Insurance_Type": medicalInsuranceType?.toJson(),
        "entitled_Medical_Benefits_Encashment":
            entitledMedicalBenefitsEncashment,
        "time_Write_Module": timeWriteModule,
        "reimbursement_Module": reimbursementModule,
        "leave_Module": leaveModule,
        "pay_Scheme": payScheme,
        "manual_Payslip": manualPayslip,
        "penalty_Bond": penaltyBond,
        "remark": remark,
      };
}

class BasicSalary {
  String? tbValue;
  String? othercurrency;

  BasicSalary({
    this.tbValue,
    this.othercurrency,
  });

  factory BasicSalary.fromJson(Map<String, dynamic> json) => BasicSalary(
        tbValue: json["tb_value"],
        othercurrency: json["othercurrency"],
      );

  Map<String, dynamic> toJson() => {
        "tb_value": tbValue,
        "othercurrency": othercurrency,
      };
}

class ContractualDaysHoursLunch {
  String? startday;
  String? endday;
  String? totaldays;
  DateTime? starttime;
  DateTime? endtime;
  String? lunchperiod;
  dynamic ifother;

  ContractualDaysHoursLunch({
    this.startday,
    this.endday,
    this.totaldays,
    this.starttime,
    this.endtime,
    this.lunchperiod,
    this.ifother,
  });

  factory ContractualDaysHoursLunch.fromJson(Map<String, dynamic> json) =>
      ContractualDaysHoursLunch(
        startday: json["startday"],
        endday: json["endday"],
        totaldays: json["totaldays"],
        starttime: json["starttime"] == null
            ? null
            : DateTime.parse(json["starttime"]),
        endtime:
            json["endtime"] == null ? null : DateTime.parse(json["endtime"]),
        lunchperiod: json["lunchperiod"],
        ifother: json["ifother"],
      );

  Map<String, dynamic> toJson() => {
        "startday": startday,
        "endday": endday,
        "totaldays": totaldays,
        "starttime": starttime?.toIso8601String(),
        "endtime": endtime?.toIso8601String(),
        "lunchperiod": lunchperiod,
        "ifother": ifother,
      };
}

class MedicalInsuranceType {
  dynamic type;
  dynamic amount;
  dynamic peryear;
  dynamic cappedamount;
  dynamic pervisit;

  MedicalInsuranceType({
    this.type,
    this.amount,
    this.peryear,
    this.cappedamount,
    this.pervisit,
  });

  factory MedicalInsuranceType.fromJson(Map<String, dynamic> json) =>
      MedicalInsuranceType(
        type: json["type"],
        amount: json["amount"],
        peryear: json["peryear"],
        cappedamount: json["cappedamount"],
        pervisit: json["pervisit"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
        "peryear": peryear,
        "cappedamount": cappedamount,
        "pervisit": pervisit,
      };
}

class OTRateDtRate {
  String? otrate;
  String? dtrate;

  OTRateDtRate({
    this.otrate,
    this.dtrate,
  });

  factory OTRateDtRate.fromJson(Map<String, dynamic> json) => OTRateDtRate(
        otrate: json["otrate"],
        dtrate: json["dtrate"],
      );

  Map<String, dynamic> toJson() => {
        "otrate": otrate,
        "dtrate": dtrate,
      };
}

class ShiftDaysHours {
  String? workdays;
  String? offdays;
  String? workhoursperweek;
  String? workhourspershift;
  String? lunchperiod;
  dynamic ifother;

  ShiftDaysHours({
    this.workdays,
    this.offdays,
    this.workhoursperweek,
    this.workhourspershift,
    this.lunchperiod,
    this.ifother,
  });

  factory ShiftDaysHours.fromJson(Map<String, dynamic> json) => ShiftDaysHours(
        workdays: json["workdays"],
        offdays: json["offdays"],
        workhoursperweek: json["workhoursperweek"],
        workhourspershift: json["workhourspershift"],
        lunchperiod: json["lunchperiod"],
        ifother: json["ifother"],
      );

  Map<String, dynamic> toJson() => {
        "workdays": workdays,
        "offdays": offdays,
        "workhoursperweek": workhoursperweek,
        "workhourspershift": workhourspershift,
        "lunchperiod": lunchperiod,
        "ifother": ifother,
      };
}

class SelectedNhcTemplateModel {
  int? selectedTemplateId;
  SelectedTemplateName? selectedTemplateName;
  Organization? organization;

  SelectedNhcTemplateModel({
    this.selectedTemplateId,
    this.selectedTemplateName,
    this.organization,
  });

  factory SelectedNhcTemplateModel.fromJson(Map<String, dynamic> json) =>
      SelectedNhcTemplateModel(
        selectedTemplateId: json["selectedTemplateId"],
        selectedTemplateName:
            selectedTemplateNameValues.map[json["selectedTemplateName"]]!,
        organization: organizationValues.map[json["organization"]]!,
      );

  Map<String, dynamic> toJson() => {
        "selectedTemplateId": selectedTemplateId,
        "selectedTemplateName":
            selectedTemplateNameValues.reverse[selectedTemplateName],
        "organization": organizationValues.reverse[organization],
      };
}

enum Organization { HRMS, MINIMUN_PAY }

final organizationValues = EnumValues(
    {"HRMS": Organization.HRMS, "Minimun Pay": Organization.MINIMUN_PAY});

enum SelectedTemplateName { DEFAULT_NHC_FORM, MINIMUN_PAY_NHC_FORM }

final selectedTemplateNameValues = EnumValues({
  "Default NHC Form": SelectedTemplateName.DEFAULT_NHC_FORM,
  "Minimun Pay NHC Form": SelectedTemplateName.MINIMUN_PAY_NHC_FORM
});

enum Status { OK }

final statusValues = EnumValues({"OK": Status.OK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
