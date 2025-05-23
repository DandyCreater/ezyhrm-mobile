import 'dart:convert';

List<TimesheetDto> ListTimesheetResponseFromJson(List<dynamic> str) =>
    List<TimesheetDto>.from(str.map((x) => TimesheetDto.fromJson(x)));

String ListTimesheetDtoToJson(List<TimesheetDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimesheetDto {
  int? id;
  int? employeeId;
  String? docNo;
  DateTime? date;
  int? day;
  int? week;
  int? year;
  String? startTime;
  String? endTime;
  String? breakTime;
  double? workHours;
  double? otHours;
  String? remark;
  String? remark2;
  String? remark3;
  String? remarkScheduler;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  TimesheetDto({
    this.id,
    this.employeeId,
    this.docNo,
    this.date,
    this.day,
    this.week,
    this.year,
    this.startTime,
    this.endTime,
    this.breakTime,
    this.workHours,
    this.otHours,
    this.remark,
    this.remark2,
    this.remark3,
    this.remarkScheduler,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory TimesheetDto.fromJson(Map<String, dynamic> json) => TimesheetDto(
        id: json["id"],
        employeeId: json["employeeId"],
        docNo: json["doc_no"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        day: json["day"],
        week: json["week"],
        year: json["year"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        breakTime: json["break_time"],
        workHours: json["work_hours"]?.toDouble(),
        otHours: json["ot_hours"]?.toDouble(),
        remark: json["remark"],
        remark2: json["remark2"],
        remark3: json["remark3"],
        remarkScheduler: json["remarkScheduler"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "employeeId": employeeId,
      "doc_no": docNo,
      "date": date?.toIso8601String(),
      "day": day,
      "week": week,
      "year": year,
      "start_time": startTime,
      "end_time": endTime,
      "break_time": breakTime,
      "work_hours": workHours,
      "ot_hours": otHours,
      "remark": remark,
      "remark2": remark2,
      "remark3": remark3,
      "remarkScheduler": remarkScheduler,
      "status": status,
      "created_by": createdBy,
      "created_at": createdAt?.toIso8601String(),
      "updated_by": updatedBy,
      "updated_at": updatedAt?.toIso8601String(),
    };

    if (id != null) {
      data["id"] = id;
    }

    return data;
  }
}
