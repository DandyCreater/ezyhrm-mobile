import 'dart:convert';

PersonalParticularResponse personalParticularResponseFromJson(String str) =>
    PersonalParticularResponse.fromJson(json.decode(str));

String personalParticularResponseToJson(PersonalParticularResponse data) =>
    json.encode(data.toJson());

class PersonalParticularResponse {
  String? employeeId;
  List<dynamic>? drivingLicense;
  List<dynamic>? educationFileNames;
  dynamic marriageCertName;
  BankAccount? bankAccount;
  dynamic testimonialsDescription;
  DateTime? createdDate;
  dynamic creatorEmployeeId;
  String? lastModifiedEmployeeId;
  DateTime? dateModified;

  PersonalParticularResponse({
    this.employeeId,
    this.drivingLicense,
    this.educationFileNames,
    this.marriageCertName,
    this.bankAccount,
    this.testimonialsDescription,
    this.createdDate,
    this.creatorEmployeeId,
    this.lastModifiedEmployeeId,
    this.dateModified,
  });

  factory PersonalParticularResponse.fromJson(Map<String, dynamic> json) =>
      PersonalParticularResponse(
        employeeId: json["employeeId"],
        drivingLicense: json["drivingLicense"] == null
            ? []
            : List<dynamic>.from(json["drivingLicense"]!.map((x) => x)),
        educationFileNames: json["educationFileNames"] == null
            ? []
            : List<dynamic>.from(json["educationFileNames"]!.map((x) => x)),
        marriageCertName: json["marriageCertName"],
        bankAccount: json["bankAccount"] == null
            ? null
            : BankAccount.fromJson(json["bankAccount"]),
        testimonialsDescription: json["testimonialsDescription"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        creatorEmployeeId: json["creatorEmployeeId"],
        lastModifiedEmployeeId: json["lastModifiedEmployeeId"],
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "drivingLicense": drivingLicense == null
            ? []
            : List<dynamic>.from(drivingLicense!.map((x) => x)),
        "educationFileNames": educationFileNames == null
            ? []
            : List<dynamic>.from(educationFileNames!.map((x) => x)),
        "marriageCertName": marriageCertName,
        "bankAccount": bankAccount?.toJson(),
        "testimonialsDescription": testimonialsDescription,
        "createdDate": createdDate?.toIso8601String(),
        "creatorEmployeeId": creatorEmployeeId,
        "lastModifiedEmployeeId": lastModifiedEmployeeId,
        "dateModified": dateModified?.toIso8601String(),
      };
}

class BankAccount {
  String? bankId;
  int? bankCodeId;
  String? bankAccountNumber;
  String? bankAccountName;
  dynamic bankStatementName;

  BankAccount({
    this.bankId,
    this.bankCodeId,
    this.bankAccountNumber,
    this.bankAccountName,
    this.bankStatementName,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        bankId: json["bankId"],
        bankCodeId: json["bankCodeID"],
        bankAccountNumber: json["bankAccountNumber"],
        bankAccountName: json["bankAccountName"],
        bankStatementName: json["bankStatementName"],
      );

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "bankCodeID": bankCodeId,
        "bankAccountNumber": bankAccountNumber,
        "bankAccountName": bankAccountName,
        "bankStatementName": bankStatementName,
      };
}
