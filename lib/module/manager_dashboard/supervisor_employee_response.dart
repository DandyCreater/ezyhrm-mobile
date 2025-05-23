import 'dart:convert';

List<SupervisorEmployeeResponse> supervisorEmployeeResponseFromJson(
        String str) =>
    List<SupervisorEmployeeResponse>.from(
        json.decode(str).map((x) => SupervisorEmployeeResponse.fromJson(x)));

String supervisorEmployeeResponseToJson(
        List<SupervisorEmployeeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupervisorEmployeeResponse {
  String employeeid;
  String employeename;
  String module;
  String priority;

  SupervisorEmployeeResponse({
    required this.employeeid,
    required this.employeename,
    required this.module,
    required this.priority,
  });

  factory SupervisorEmployeeResponse.fromJson(Map<String, dynamic> json) =>
      SupervisorEmployeeResponse(
        employeeid: json["employeeid"],
        employeename: json["employeename"],
        module: json["module"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "employeeid": employeeid,
        "employeename": employeename,
        "module": module,
        "priority": priority,
      };
}
