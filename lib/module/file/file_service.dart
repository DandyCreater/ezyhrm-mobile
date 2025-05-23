import 'package:dio/dio.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:path/path.dart' as p;

class FileUploadService {
  static FileUploadService instance = FileUploadService._();
  FileUploadService._();
  factory FileUploadService() => instance;
  final _baseService = BaseService.instance;
  final sessionService = SessionService.instance;

  static const String loaPFile = "loa";
  static const String loaSignedFile = "loa";
  static const String employeeChildren = "employee/children";
  static const String employeeMarriage = "employee/marriage";
  static const String employeeBankStatement = "employee/bankStatement";
  static const String employeeEducations = "employee/educations";
  static const String employeeTestimonial = "employee/testimonal";
  static const String profile = "profile";
  static const String ecfEmployee = "ecf/employee";
  static const String ecfIT = "ecf/it";
  static const String ecfHR = "ecf/hr admin";
  static const String ecfSupervisor = "ecf/supervisor";
  static const String payrollDashboard = "dashboard/payroll";
  static const String facialTimesheet = "timesheet/facial";
  static const String timesheetMonth = "timesheet/reportMonth";
  static const String timesheetYear = "timesheet/reportYear";

  Future<void> uploadImage(
      String imgPath, String route, String filepath) async {
    final formData = FormData.fromMap(
      {
        'route': route,
        'filepath': filepath,
        'filename': p.basename(imgPath),
        'file': await MultipartFile.fromFile(
          imgPath,
          filename: p.basename(imgPath),
        ),
      },
    );
    await _baseService.postForm(
      "https://ezyhr.rmagroup.com.sg/Public/UploadFileToDirectory",
      body: formData,
    );
  }

  Future<void> updateProfilePicture(String imgPath, int employeeId) async {
    const filepath = "Profile";
    final filename = "Profile-$employeeId.jpeg";

    final formData = FormData.fromMap(
      {
        'route': sessionService.getInstanceName(),
        'filepath': filepath,
        'filename': filename,
        'file': await MultipartFile.fromFile(
          imgPath,
          filename: filename,
        ),
      },
    );
    var x = await _baseService.postForm2(
      "https://ezyhr.rmagroup.com.sg/Public/UploadFileToDirectory",
      body: formData,
    );
    print(x);
  }

  Future<void> uploadImageLeaveRequest(
      String imgPath, String route, String filepath) async {
    final formData = FormData.fromMap(
      {
        'route': route,
        'filepath': filepath,
        'file': await MultipartFile.fromFile(
          imgPath,
          filename: p.basename(imgPath),
        ),
        'type': "UploadsFolderPath",
      },
    );
    await _baseService.postForm(
      "https://ezyhr.rmagroup.com.sg/Public/UploadFileToDirectory",
      body: formData,
    );
  }
}
