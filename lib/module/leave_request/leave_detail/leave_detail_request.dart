class LeaveDetailRequest {
  int? id;
  String? docNo;
  int? employeeLeaveId;
  int? leaveTypeId;
  int? employeeId;
  int? year;
  String? date;
  int? leaveType;
  int? dayCount;
  String? remark;
  int? confirmedBy;
  int? status;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  LeaveDetailRequest(
      {required this.id,
      required this.docNo,
      required this.employeeLeaveId,
      required this.leaveTypeId,
      required this.employeeId,
      required this.year,
      required this.date,
      required this.leaveType,
      required this.dayCount,
      required this.remark,
      required this.confirmedBy,
      required this.status,
      required this.createdBy,
      required this.createdAt,
      required this.updatedBy,
      required this.updatedAt});

  LeaveDetailRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docNo = json['doc_no'];
    employeeLeaveId = json['employeeLeaveId'];
    leaveTypeId = json['leaveTypeId'];
    employeeId = json['employeeId'];
    year = json['year'];
    date = json['date'];
    leaveType = json['leave_type'];
    dayCount = json['day_count'];
    remark = json['remark'];
    confirmedBy = json['confirmed_by'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['doc_no'] = this.docNo;
    data['EmployeeLeaveId'] = this.employeeLeaveId;
    data['LeaveTypeId'] = this.leaveTypeId;
    data['EmployeeId'] = this.employeeId;
    data['year'] = this.year;
    data['date'] = this.date;
    data['leave_type'] = this.leaveType;
    data['day_count'] = this.dayCount;
    data['remark'] = this.remark;
    data['confirmed_by'] = this.confirmedBy;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
