import 'dart:convert';

TableLeaveBalanceResponse tableLeaveBalanceFromJson(String str) =>
    TableLeaveBalanceResponse.fromJson(json.decode(str));

String tableLeaveBalanceToJson(TableLeaveBalanceResponse data) =>
    json.encode(data.toJson());

class TableLeaveBalanceResponse {
  int? id;
  String? name;
  int? leaveTypeId;
  double? leaveEntitle;
  double? leaveTaken;
  double? leaveBalance;

  TableLeaveBalanceResponse({
    this.id,
    this.name,
    this.leaveTypeId,
    this.leaveEntitle,
    this.leaveTaken,
    this.leaveBalance,
  });

  factory TableLeaveBalanceResponse.fromJson(Map<String, dynamic> json) =>
      TableLeaveBalanceResponse(
        id: json["id"],
        name: json["name"],
        leaveTypeId: json["leaveTypeId"],
        leaveEntitle: json["leave_entitle"],
        leaveTaken: json["leave_taken"],
        leaveBalance: json["leave_balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "leaveTypeId": leaveTypeId,
        "leave_entitle": leaveEntitle,
        "leave_taken": leaveTaken,
        "leave_balance": leaveBalance,
      };
}
