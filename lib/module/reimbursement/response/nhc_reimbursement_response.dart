import 'dart:convert';

NhcReimbursementResponse nhcReimbursementResponseFromJson(String str) =>
    NhcReimbursementResponse.fromJson(json.decode(str));

String nhcReimbursementResponseToJson(NhcReimbursementResponse data) =>
    json.encode(data.toJson());

class NhcReimbursementResponse {
  bool? success;
  String? status;
  Result? result;

  NhcReimbursementResponse({
    this.success,
    this.status,
    this.result,
  });

  factory NhcReimbursementResponse.fromJson(Map<String, dynamic> json) =>
      NhcReimbursementResponse(
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
  int? employeeId;
  AllowanceAmountType? allowanceAmountType;

  Result({
    this.employeeId,
    this.allowanceAmountType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        employeeId: json["employeeId"],
        allowanceAmountType: json["allowance_Amount_Type"] == null
            ? AllowanceAmountType(
                amountCommunication: "0",
                typeCommunication: "Claim",
                amountCounterfixed: "0",
                typeCounterfixed: "Allowance",
                amountCountervariable: "0",
                typeCountervariable: "Claim",
                amountHousingfixed: "0",
                typeHousingfixed: "Claim",
                amountNightshiftallowance: "0",
                typeNightshiftallowance: "Claim",
                amountMvcvariable: "0",
                typeMvcvariable: "Claim",
                amountNightcourtfixed: "0",
                typeNightcourtfixed: "Claim",
                amountShiftallowance: "0",
                typeShiftallowance: "Claim",
                amountOthers: "0",
                typeOthers: "Claim",
                amountTransportfixed: "0",
                typeTransportfixed: "Claim",
                amountTransportvariable: "0",
                typeTransportvariable: "Claim",
                amountMealallowance: "0",
                typeMealallowance: "Claim",
                amountMobileallowance: "0",
                typeMobileallowance: "Claim",
                amountDental: "0",
                typeDental: "Claim",
                amountEntertainment: "0",
                typeEntertainment: "Claim",
                amountOutpatient: "0",
                typeOutpatient: "Claim",
                amountMedical: "0",
                typeMedical: "Claim",
                amountOvertime: "0",
                typeOvertime: "Claim",
                amountMileage: "0",
                typeMileage: "Claim",
                amountStationeries: "0",
                typeStationeries: "Claim",
                amountGroceries: "0",
                typeGroceries: "Claim",
              )
            : AllowanceAmountType.fromJson(json["allowance_Amount_Type"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "allowance_Amount_Type": allowanceAmountType?.toJson(),
      };
}

class AllowanceAmountType {
  String? amountCommunication;
  String? typeCommunication;
  String? amountCounterfixed;
  String? typeCounterfixed;
  String? amountCountervariable;
  String? typeCountervariable;
  String? amountHousingfixed;
  String? typeHousingfixed;
  String? amountNightshiftallowance;
  String? typeNightshiftallowance;
  String? amountMvcvariable;
  String? typeMvcvariable;
  String? amountNightcourtfixed;
  String? typeNightcourtfixed;
  String? amountShiftallowance;
  String? typeShiftallowance;
  String? amountOthers;
  String? typeOthers;
  String? amountTransportfixed;
  String? typeTransportfixed;
  String? amountTransportvariable;
  String? typeTransportvariable;
  String? amountMealallowance;
  String? typeMealallowance;
  String? amountMobileallowance;
  String? typeMobileallowance;
  String? amountDental;
  String? typeDental;
  String? amountEntertainment;
  String? typeEntertainment;
  String? amountOutpatient;
  String? typeOutpatient;
  String? amountMedical;
  String? typeMedical;
  String? amountOvertime;
  String? typeOvertime;
  String? amountMileage;
  String? typeMileage;
  String? amountStationeries;
  String? typeStationeries;
  String? amountGroceries;
  String? typeGroceries;

  AllowanceAmountType({
    this.amountCommunication,
    this.typeCommunication,
    this.amountCounterfixed,
    this.typeCounterfixed,
    this.amountCountervariable,
    this.typeCountervariable,
    this.amountHousingfixed,
    this.typeHousingfixed,
    this.amountNightshiftallowance,
    this.typeNightshiftallowance,
    this.amountMvcvariable,
    this.typeMvcvariable,
    this.amountNightcourtfixed,
    this.typeNightcourtfixed,
    this.amountShiftallowance,
    this.typeShiftallowance,
    this.amountOthers,
    this.typeOthers,
    this.amountTransportfixed,
    this.typeTransportfixed,
    this.amountTransportvariable,
    this.typeTransportvariable,
    this.amountMealallowance,
    this.typeMealallowance,
    this.amountMobileallowance,
    this.typeMobileallowance,
    this.amountDental,
    this.typeDental,
    this.amountEntertainment,
    this.typeEntertainment,
    this.amountOutpatient,
    this.typeOutpatient,
    this.amountMedical,
    this.typeMedical,
    this.amountOvertime,
    this.typeOvertime,
    this.amountMileage,
    this.typeMileage,
    this.amountStationeries,
    this.typeStationeries,
    this.amountGroceries,
    this.typeGroceries,
  });

  factory AllowanceAmountType.fromJson(Map<String, dynamic> json) =>
      AllowanceAmountType(
        amountCommunication: json["amount_communication"],
        typeCommunication: json["type_communication"],
        amountCounterfixed: json["amount_counterfixed"],
        typeCounterfixed: json["type_counterfixed"],
        amountCountervariable: json["amount_countervariable"],
        typeCountervariable: json["type_countervariable"],
        amountHousingfixed: json["amount_housingfixed"],
        typeHousingfixed: json["type_housingfixed"],
        amountNightshiftallowance: json["amount_nightshiftallowance"],
        typeNightshiftallowance: json["type_nightshiftallowance"],
        amountMvcvariable: json["amount_mvcvariable"],
        typeMvcvariable: json["type_mvcvariable"],
        amountNightcourtfixed: json["amount_nightcourtfixed"],
        typeNightcourtfixed: json["type_nightcourtfixed"],
        amountShiftallowance: json["amount_shiftallowance"],
        typeShiftallowance: json["type_shiftallowance"],
        amountOthers: json["amount_others"],
        typeOthers: json["type_others"],
        amountTransportfixed: json["amount_transportfixed"],
        typeTransportfixed: json["type_transportfixed"],
        amountTransportvariable: json["amount_transportvariable"],
        typeTransportvariable: json["type_transportvariable"],
        amountMealallowance: json["amount_mealallowance"],
        typeMealallowance: json["type_mealallowance"],
        amountMobileallowance: json["amount_mobileallowance"],
        typeMobileallowance: json["type_mobileallowance"],
        amountDental: json["amount_dental"],
        typeDental: json["type_dental"],
        amountEntertainment: json["amount_entertainment"],
        typeEntertainment: json["type_entertainment"],
        amountOutpatient: json["amount_outpatient"],
        typeOutpatient: json["type_outpatient"],
        amountMedical: json["amount_medical"],
        typeMedical: json["type_medical"],
        amountOvertime: json["amount_overtime"],
        typeOvertime: json["type_overtime"],
        amountMileage: json["amount_mileage"],
        typeMileage: json["type_mileage"],
        amountStationeries: json["amount_stationeries"],
        typeStationeries: json["type_stationeries"],
        amountGroceries: json["amount_groceries"],
        typeGroceries: json["type_groceries"],
      );

  Map<String, dynamic> toJson() => {
        "amount_communication": amountCommunication,
        "type_communication": typeCommunication,
        "amount_counterfixed": amountCounterfixed,
        "type_counterfixed": typeCounterfixed,
        "amount_countervariable": amountCountervariable,
        "type_countervariable": typeCountervariable,
        "amount_housingfixed": amountHousingfixed,
        "type_housingfixed": typeHousingfixed,
        "amount_nightshiftallowance": amountNightshiftallowance,
        "type_nightshiftallowance": typeNightshiftallowance,
        "amount_mvcvariable": amountMvcvariable,
        "type_mvcvariable": typeMvcvariable,
        "amount_nightcourtfixed": amountNightcourtfixed,
        "type_nightcourtfixed": typeNightcourtfixed,
        "amount_shiftallowance": amountShiftallowance,
        "type_shiftallowance": typeShiftallowance,
        "amount_others": amountOthers,
        "type_others": typeOthers,
        "amount_transportfixed": amountTransportfixed,
        "type_transportfixed": typeTransportfixed,
        "amount_transportvariable": amountTransportvariable,
        "type_transportvariable": typeTransportvariable,
        "amount_mealallowance": amountMealallowance,
        "type_mealallowance": typeMealallowance,
        "amount_mobileallowance": amountMobileallowance,
        "type_mobileallowance": typeMobileallowance,
        "amount_dental": amountDental,
        "type_dental": typeDental,
        "amount_entertainment": amountEntertainment,
        "type_entertainment": typeEntertainment,
        "amount_outpatient": amountOutpatient,
        "type_outpatient": typeOutpatient,
        "amount_medical": amountMedical,
        "type_medical": typeMedical,
        "amount_overtime": amountOvertime,
        "type_overtime": typeOvertime,
        "amount_mileage": amountMileage,
        "type_mileage": typeMileage,
        "amount_stationeries": amountStationeries,
        "type_stationeries": typeStationeries,
        "amount_groceries": amountGroceries,
        "type_groceries": typeGroceries,
      };
}
