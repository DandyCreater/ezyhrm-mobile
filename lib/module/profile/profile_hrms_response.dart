import 'dart:convert';

ProfileHrmsResponse profileHrmsResponseFromJson(String str) =>
    ProfileHrmsResponse.fromJson(json.decode(str));

String profileHrmsResponseToJson(ProfileHrmsResponse data) =>
    json.encode(data.toJson());

class ProfileHrmsResponse {
  String? assignRoleId;
  String? employeeId;
  String? employeeName;
  String? role;
  String? email;
  String? designation;
  dynamic dateAssigned;

  ProfileHrmsResponse({
    this.assignRoleId,
    this.employeeId,
    this.employeeName,
    this.role,
    this.email,
    this.designation,
    this.dateAssigned,
  });

  factory ProfileHrmsResponse.fromJson(Map<String, dynamic> json) {
    return ProfileHrmsResponse(
      assignRoleId: json["assignRole_Id"] as String?,
      employeeId: json["employeeId"] as String?,
      employeeName: json["employeeName"] as String?,
      role: json["role"] as String?,
      email: json["email"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "assignRole_Id": assignRoleId,
        "employeeId": employeeId,
        "employeeName": employeeName,
        "role": role,
        "email": email,
      };
}
