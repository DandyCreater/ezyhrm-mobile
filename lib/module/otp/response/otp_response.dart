import 'dart:convert';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  bool success;
  String status;
  OtpResult result;

  OtpResponse({
    required this.success,
    required this.status,
    required this.result,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        success: json["success"],
        status: json["status"],
        result: OtpResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "result": result.toJson(),
      };
}

class OtpResult {
  int userId;
  dynamic name;
  dynamic role;
  String email;
  String accessToken;
  List<Instance> instances;
  dynamic status;

  OtpResult({
    required this.userId,
    required this.name,
    required this.role,
    required this.email,
    required this.accessToken,
    required this.instances,
    required this.status,
  });

  factory OtpResult.fromJson(Map<String, dynamic> json) => OtpResult(
        userId: json["userId"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        accessToken: json["accessToken"],
        instances: List<Instance>.from(
            json["instances"].map((x) => Instance.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "role": role,
        "email": email,
        "accessToken": accessToken,
        "instances": List<dynamic>.from(instances.map((x) => x.toJson())),
        "status": status,
      };
}

class Instance {
  String userId;
  String name;
  String role;

  String status;
  String instanceCode;

  Instance({
    required this.userId,
    required this.name,
    required this.role,
    required this.status,
    required this.instanceCode,
  });

  factory Instance.fromJson(Map<String, dynamic> json) => Instance(
        userId: json["userId"],
        name: json["name"],
        role: json["role"],
        status: json["status"],
        instanceCode: json["instanceCode"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "role": role,
        "status": status,
        "instanceCode": instanceCode,
      };
}

class SubRole {
  Role role;
  String status;

  SubRole({
    required this.role,
    required this.status,
  });

  factory SubRole.fromJson(Map<String, dynamic> json) => SubRole(
        role: Role.fromJson(json["role"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "role": role.toJson(),
        "status": status,
      };
}

class Role {
  String roleId;
  String roleName;
  String description;
  String module;

  Role({
    required this.roleId,
    required this.roleName,
    required this.description,
    required this.module,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        roleName: json["roleName"],
        description: json["description"],
        module: json["module"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
        "description": description,
        "module": module,
      };
}
