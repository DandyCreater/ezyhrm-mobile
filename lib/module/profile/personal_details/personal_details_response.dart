import 'dart:convert';

PersonalDetailsResponse personalDetailsResponseFromJson(String str) =>
    PersonalDetailsResponse.fromJson(json.decode(str));

String personalDetailsResponseToJson(PersonalDetailsResponse data) =>
    json.encode(data.toJson());

class PersonalDetailsResponse {
  int? employeeId;
  int? loAId;
  dynamic recruiterName;
  dynamic creatorHrAccountAdministratorId;
  String? employeeName;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? placeOfBirth;
  String? nationality;
  String? race;
  String? employeeType;
  ContributionAndDonation? contributionAndDonation;
  String? nricFinNo;
  DateTime? finDateOfIssue;
  dynamic finExpiryOfTheEmploymentPass;
  String? passportNo;
  String? gender;
  String? religion;
  String? maritalStatus;
  String? highestQualification;
  String? mobileNo;
  String? homeNo;
  String? email;
  DateTime? dateCreated;
  Address? address;
  List<NextOfKinContact>? nextOfKinContact;
  List<ChildrenDetail>? childrenDetails;
  dynamic lastModifiedEmployeeId;
  dynamic dateModified;
  bool? visibilityStatus;
  int? employeeStatus;

  PersonalDetailsResponse({
    this.employeeId,
    this.loAId,
    this.recruiterName,
    this.creatorHrAccountAdministratorId,
    this.employeeName,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.placeOfBirth,
    this.nationality,
    this.race,
    this.employeeType,
    this.contributionAndDonation,
    this.nricFinNo,
    this.finDateOfIssue,
    this.finExpiryOfTheEmploymentPass,
    this.passportNo,
    this.gender,
    this.religion,
    this.maritalStatus,
    this.highestQualification,
    this.mobileNo,
    this.homeNo,
    this.email,
    this.dateCreated,
    this.address,
    this.nextOfKinContact,
    this.childrenDetails,
    this.lastModifiedEmployeeId,
    this.dateModified,
    this.visibilityStatus,
    this.employeeStatus,
  });

  factory PersonalDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PersonalDetailsResponse(
        employeeId: json["employee_Id"],
        loAId: json["loA_Id"],
        recruiterName: json["recruiterName"],
        creatorHrAccountAdministratorId:
            json["creatorHRAccountAdministratorId"],
        employeeName: json["employeeName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        placeOfBirth: json["placeOfBirth"],
        nationality: json["nationality"],
        race: json["race"],
        employeeType: json["employeeType"],
        contributionAndDonation: json["contributionAndDonation"] == null
            ? null
            : ContributionAndDonation.fromJson(json["contributionAndDonation"]),
        nricFinNo: json["nricFinNo"],
        finDateOfIssue: json["finDateOfIssue"] == null
            ? null
            : DateTime.parse(json["finDateOfIssue"]),
        finExpiryOfTheEmploymentPass: json["finExpiryOfTheEmploymentPass"],
        passportNo: json["passportNo"],
        gender: json["gender"],
        religion: json["religion"],
        maritalStatus: json["maritalStatus"],
        highestQualification: json["highestQualification"],
        mobileNo: json["mobileNo"],
        homeNo: json["homeNo"],
        email: json["email"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        nextOfKinContact: json["nextOfKinContact"] == null
            ? []
            : List<NextOfKinContact>.from(json["nextOfKinContact"]!
                .map((x) => NextOfKinContact.fromJson(x))),
        childrenDetails: json["childrenDetails"] == null
            ? []
            : List<ChildrenDetail>.from(json["childrenDetails"]!
                .map((x) => ChildrenDetail.fromJson(x))),
        lastModifiedEmployeeId: json["lastModifiedEmployeeId"],
        dateModified: json["dateModified"],
        visibilityStatus: json["visibilityStatus"],
        employeeStatus: json["employeeStatus"],
      );

  Map<String, dynamic> toJson() => {
        "employee_Id": employeeId,
        "loA_Id": loAId,
        "recruiterName": recruiterName,
        "creatorHRAccountAdministratorId": creatorHrAccountAdministratorId,
        "employeeName": employeeName,
        "firstName": firstName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "placeOfBirth": placeOfBirth,
        "nationality": nationality,
        "race": race,
        "employeeType": employeeType,
        "contributionAndDonation": contributionAndDonation?.toJson(),
        "nricFinNo": nricFinNo,
        "finDateOfIssue": finDateOfIssue?.toIso8601String(),
        "finExpiryOfTheEmploymentPass": finExpiryOfTheEmploymentPass,
        "passportNo": passportNo,
        "gender": gender,
        "religion": religion,
        "maritalStatus": maritalStatus,
        "highestQualification": highestQualification,
        "mobileNo": mobileNo,
        "homeNo": homeNo,
        "email": email,
        "dateCreated": dateCreated?.toIso8601String(),
        "address": address?.toJson(),
        "nextOfKinContact": nextOfKinContact == null
            ? []
            : List<dynamic>.from(nextOfKinContact!.map((x) => x.toJson())),
        "childrenDetails": childrenDetails == null
            ? []
            : List<dynamic>.from(childrenDetails!.map((x) => x.toJson())),
        "lastModifiedEmployeeId": lastModifiedEmployeeId,
        "dateModified": dateModified,
        "visibilityStatus": visibilityStatus,
        "employeeStatus": employeeStatus,
      };
}

class Address {
  String? country;
  String? postalCode;
  String? block;
  String? street;
  String? unit;
  String? building;
  String? state;

  Address({
    this.country,
    this.postalCode,
    this.block,
    this.street,
    this.unit,
    this.building,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        postalCode: json["postalCode"],
        block: json["block"],
        street: json["street"],
        unit: json["unit"],
        building: json["building"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "postalCode": postalCode,
        "block": block,
        "street": street,
        "unit": unit,
        "building": building,
        "state": state,
      };
}

class ChildrenDetail {
  String? nric;
  String? gender;
  String? birthCertNumber;
  DateTime? dateOfBirth;
  dynamic birthCertFile;
  String? birthCertName;

  ChildrenDetail({
    this.nric,
    this.gender,
    this.birthCertNumber,
    this.dateOfBirth,
    this.birthCertFile,
    this.birthCertName,
  });

  factory ChildrenDetail.fromJson(Map<String, dynamic> json) => ChildrenDetail(
        nric: json["nric"],
        gender: json["gender"],
        birthCertNumber: json["birthCertNumber"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        birthCertFile: json["birthCertFile"],
        birthCertName: json["birthCertName"],
      );

  Map<String, dynamic> toJson() => {
        "nric": nric,
        "gender": gender,
        "birthCertNumber": birthCertNumber,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "birthCertFile": birthCertFile,
        "birthCertName": birthCertName,
      };
}

class ContributionAndDonation {
  String? cdac;
  String? ecf;
  dynamic mbmf;
  dynamic sinda;
  dynamic share;
  dynamic shareAmount;

  ContributionAndDonation({
    this.cdac,
    this.ecf,
    this.mbmf,
    this.sinda,
    this.share,
    this.shareAmount,
  });

  factory ContributionAndDonation.fromJson(Map<String, dynamic> json) =>
      ContributionAndDonation(
        cdac: json["cdac"],
        ecf: json["ecf"],
        mbmf: json["mbmf"],
        sinda: json["sinda"],
        share: json["share"],
        shareAmount: json["shareAmount"],
      );

  Map<String, dynamic> toJson() => {
        "cdac": cdac,
        "ecf": ecf,
        "mbmf": mbmf,
        "sinda": sinda,
        "share": share,
        "shareAmount": shareAmount,
      };
}

class NextOfKinContact {
  String? name;
  String? relationshipToEmployee;
  String? email;
  String? mobileNo;
  String? homeNo;

  NextOfKinContact({
    this.name,
    this.relationshipToEmployee,
    this.email,
    this.mobileNo,
    this.homeNo,
  });

  factory NextOfKinContact.fromJson(Map<String, dynamic> json) =>
      NextOfKinContact(
        name: json["name"],
        relationshipToEmployee: json["relationshipToEmployee"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        homeNo: json["homeNo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relationshipToEmployee": relationshipToEmployee,
        "email": email,
        "mobileNo": mobileNo,
        "homeNo": homeNo,
      };
}
