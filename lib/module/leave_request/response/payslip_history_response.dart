import 'dart:convert';

PayslipHistoryResponse payslipHistoryResponseFromJson(String str) =>
    PayslipHistoryResponse.fromJson(json.decode(str));

String payslipHistoryResponseToJson(PayslipHistoryResponse data) =>
    json.encode(data.toJson());

class PayslipHistoryResponse {
  bool? success;
  String? status;
  String? message;
  List<Result>? result;

  PayslipHistoryResponse({
    this.success,
    this.status,
    this.message,
    this.result,
  });

  factory PayslipHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PayslipHistoryResponse(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  int? year;
  int? month;
  double? finalNetPay;

  Result({
    this.id,
    this.year,
    this.month,
    this.finalNetPay,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        year: json["year"],
        month: json["month"],
        finalNetPay: json["final_net_pay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "month": month,
        "final_net_pay": finalNetPay,
      };
}
