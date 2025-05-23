class AttendanceData {
  int? id;
  int? employeeId;
  int? month;
  int? year;
  DateTime? checkinDate;
  String? photoinTime;
  String? locationinTime;
  DateTime? checkoutDate;
  String? photooutTime;
  String? locationoutTime;
  String? latOutTime;
  String? longOutTime;
  String? latInTime;
  String? longInTime;
  int? status;

  AttendanceData({
    this.id,
    this.employeeId,
    this.month,
    this.year,
    this.checkinDate,
    this.photoinTime,
    this.locationinTime,
    this.checkoutDate,
    this.photooutTime,
    this.locationoutTime,
    this.latOutTime,
    this.longOutTime,
    this.latInTime,
    this.longInTime,
    this.status,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
        id: json["id"],
        employeeId: json["employeeId"],
        month: json["month"],
        year: json["year"],
        checkinDate: json["checkinDate"] == null
            ? null
            : DateTime.parse(json["checkinDate"]),
        photoinTime: json["photoinTime"],
        locationinTime: json["locationinTime"],
        checkoutDate: json["checkoutDate"] == null
            ? null
            : DateTime.parse(json["checkoutDate"]),
        photooutTime: json["photooutTime"],
        locationoutTime: json["locationoutTime"],
        latOutTime: json["latOutTime"],
        longOutTime: json["longOutTime"],
        latInTime: json["latInTime"],
        longInTime: json["longInTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "month": month,
        "year": year,
        "checkinDate": checkinDate?.toIso8601String(),
        "photoinTime": photoinTime,
        "locationinTime": locationinTime,
        "checkoutDate": checkoutDate?.toIso8601String(),
        "photooutTime": photooutTime,
        "locationoutTime": locationoutTime,
        "latOutTime": latOutTime,
        "longOutTime": longOutTime,
        "latInTime": latInTime,
        "longInTime": longInTime,
        "status": status,
      };
}
