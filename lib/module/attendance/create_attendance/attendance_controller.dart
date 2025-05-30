// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/attendance/face_detection_service.dart';
import 'package:ezyhr_mobile_apps/module/attendance/request/attendance_request.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_create_response.dart';
import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_response.dart';
import 'package:ezyhr_mobile_apps/module/file/file_service.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_work_hour_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

import 'attendance_screen.dart';

class AttendanceC extends Bindings {
  static const route = '/attendance';
  static final page = GetPage(
    name: route,
    page: () => const AttendanceScreen(),
    binding: AttendanceC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<AttendanceController>(() => AttendanceController());
  }
}

class AttendanceController extends GetxController {
  Future<void> onReady() async {
    getIp();
    permissionForLocation();

    getTimesheetWorkHour();
    permissionForLocation().then((value) async {
      posinitial = await determinePosition();
    }).whenComplete(() {
      getPositionData();
    });
    super.onReady();
    await getAttendance();
  }

  @override
  void onInit() {
    super.onInit();

    getIp();
    permissionForLocation();

    getTimesheetWorkHour();
    permissionForLocation().then((value) async {
      posinitial = await determinePosition();
    }).whenComplete(() {
      getPositionData();
    });
    super.onReady();
  }

  @override
  void onClose() {
    positionStream.cancel();

    super.onClose();
  }

  @override
  void dispose() {
    positionStream.cancel();
    _faceDetectionService.dispose();

    super.dispose();
  }

  List _predictedData = [];
  List get predictedData => _predictedData;

  Future<void> initializeLocation() async {
    permissionForLocation().then((value) async {
      posinitial = await determinePosition();
    }).whenComplete(() {
      getPositionData();
    });
  }

  final attendance = Rxn<AttendanceResponse>();

  Future<void> getTimesheetWorkHour() async {
    try {
      isLoading.value = true;
      final response = await timesheetService.getTimesheetWorkHour(
        sessionService.getEmployeeId(),
      );
      timesheetWorkHour.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  final isLoading = false.obs;
  final isCheckin = true.obs;
  final isLocation = false.obs;
  final isCamera = false.obs;
  final timesheetWorkHour = Rxn<TimesheetWorkHourResponse>();

  final sessionService = SessionService.instance;
  final attendanceService = AttendanceService.instance;
  final fileUploadService = FileUploadService.instance;
  final timesheetService = TimesheetService.instance;
  final profileService = ProfileService.instance;
  final FaceDetectionService _faceDetectionService = FaceDetectionService();

  late StreamSubscription<Position> positionStream;

  Future<void> startLocate() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      getAddressFromCoords(position.latitude, position.longitude).then((a) {
        address.value = a;
      });
    });
  }

  late Position? posinitial;
  final latitude = 0.0.obs, longitude = 0.0.obs;
  var address = RxString('');

  getPositionData() async {
    if (posinitial != null) {
      print('posinitial!.latitude: ${posinitial!.latitude}');
      print('posinitial!.longitude: ${posinitial!.longitude}');

      latitude(posinitial!.latitude);
      longitude(posinitial!.longitude);
      getAddressFromCoords(posinitial!.latitude, posinitial!.longitude)
          .then((a) {
        address.value = a;
      });
    }
  }

  Future<bool> permissionForLocation() async {
    final request = await Permission.location.request();
    dev.log("request -> $request");
    if (request.isPermanentlyDenied) {}
    final status = await Permission.location.status;
    dev.log("status -> $status");
    if (status.isDenied) {
      Permission.location.request();

      isLocation.value = false;
      request;
      return false;
    } else if (status.isRestricted) {
      isLocation.value = true;

      startLocate();
      return false;
    } else if (status.isLimited) {
      isLocation.value = true;

      startLocate();
      return false;
    } else {
      startLocate();

      isLocation.value = true;
      return true;
    }
  }

  static Future<Position>? determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CommonWidget.showErrorNotif(
          'Location services are disabled. Go to settings to enable it.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CommonWidget.showErrorNotif(
            'Location services are disabled. Go to settings to enable it.');

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonWidget.showErrorNotif(
          'Location services are disabled. Go to settings to enable it.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  var ipAdd = ''.obs;

  void getIp() async {
    if (Platform.isAndroid) {
      ipAdd.value = await (InternetAddress.lookup('google.com'))
          .then((ips) => ips.first.address);
    } else if (Platform.isIOS) {
      ipAdd.value = await (InternetAddress.lookup('google.com'))
          .then((ips) => ips.first.address);
    }
  }

  Future<void> getAttendance() async {
    try {
      isLoading.value = true;
      final response =
          await attendanceService.getAttendance(sessionService.getEmployeeId());
      attendance.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getAddressFromCoords(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final addressComponents = placemarks.first;

        return '${addressComponents.street}, ${addressComponents.subLocality}, ${addressComponents.locality}, ${addressComponents.administrativeArea}, ${addressComponents.postalCode}, ${addressComponents.country}';
      } else {
        return 'Address unavailable';
      }
    } catch (e) {
      return 'Error getting address: $e';
    }
  }

  void doAttend() async {
    print('sessionService.getCheckIn(): ${sessionService.getCheckIn()}');

    await getAttendance();

    final isCheckin;
    if (attendance.value!.data!.first.checkinDate != null &&
        attendance.value!.data!.first.checkoutDate != null) {
      isCheckin = true;
    } else if (attendance.value!.data!.first.checkinDate != null &&
        attendance.value!.data!.first.checkoutDate == null) {
      isCheckin = false;
    } else {
      isCheckin = true;
    }
    if (isCheckin) {
      doCheckIn();
    } else {
      doCheckOut();
    }
  }

  void doCheckIn() async {
    await Permission.camera.request();
    await Permission.storage.request();

    if (!checkField()) {
      return;
    }
    isLoading.value = true;
    final profilePictureResponse =
        await profileService.getProfilePicture(sessionService.getEmployeeId());
    final profilePic = await sessionService
        .saveImageUrlWithReturn2("${profilePictureResponse}");

    final isFaceSimiliar =
        await attendanceService.startFaceDetection(imgPath.value, profilePic);
    // await isTheSameFace(imgPath.value, profilePic);
    if (!isFaceSimiliar) {
      CommonWidget.showErrorNotif(
          'Face not similiar to profile picture, try to remove glasses or mask and try again');
      isLoading.value = false;
      return;
    }
    if (imgPath.value != '') {
      try {
        isLoading.value = true;
        final response = await fileUploadService.uploadImage(imgPath.value,
            sessionService.getInstanceName(), "timesheet/facial");
      } catch (e) {
        isLoading.value = false;

        print('error: $e');
      }
    }
    try {
      isLoading.value = true;
      final response = await attendanceService.checkIn(
        AttendanceRequest(
          employeeId: sessionService.getEmployeeId(),
          month: DateTime.now().month,
          year: DateTime.now().year,
          photoinTime: p.basename(imgPath.value),
          checkinDate: DateTime.now(),
          latInTime: latitude.value.toString(),
          longInTime: longitude.value.toString(),
          locationinTime: address.value,
          status: 2,
        ),
      );
      sessionService.saveCheckIn(response);
      CommonWidget.showNotif('Success', color: Colors.green);
      isCheckin.value = false;
      RouteUtil.back();
    } catch (e) {
      print(e);

      isCheckin.value = true;
      sessionService.removeCheckIn();
    } finally {
      isLoading.value = false;
      imgPath.value = '';
      imgType.value = ImgType.svg;
      imgFile = null;
    }
  }

  bool checkField() {
    if (isLoading.value) {
      CommonWidget.showErrorNotif('Please wait, still processing');
      return false;
    }
    if (latitude.value == 0.0 || longitude.value == 0.0) {
      CommonWidget.showErrorNotif('Please turn on your location');
      return false;
    }
    if (imgPath.value == '') {
      CommonWidget.showErrorNotif('Please take a picture');
      return false;
    }
    return true;
  }

  void doCheckOut() async {
    if (!checkField()) {
      return;
    }

    isLoading.value = true;
    final profilePictureResponse =
        await profileService.getProfilePicture(sessionService.getEmployeeId());
    final profilePic = await sessionService
        .saveImageUrlWithReturn2("${profilePictureResponse}");

    // final isFaceSimiliar = await isTheSameFace(imgPath.value, profilePic);
    final isFaceSimiliar =
        await attendanceService.startFaceDetection(imgPath.value, profilePic);
    if (!isFaceSimiliar) {
      CommonWidget.showErrorNotif(
          'Face not similiar to profile picture, try to remove glasses or mask and try again');

      isLoading.value = false;
      return;
    }
    if (imgPath.value != '') {
      try {
        isLoading.value = true;

        final response = await fileUploadService.uploadImage(imgPath.value,
            sessionService.getInstanceName(), "timesheet/facial");
      } catch (e) {
        CommonWidget.showErrorNotif("Failed to upload Image");
        isLoading.value = false;

        print('error: $e');
      }
    }
    try {
      isLoading.value = true;
      AttendanceCreateResponse attendanceResponse = AttendanceCreateResponse(
        message: "Ok",
        data: attendance.value!.data!.first,
      );

      final response = await attendanceService.checkOut(
        AttendanceRequest(
            id: attendanceResponse.data?.id,
            employeeId: sessionService.getEmployeeId(),
            month: DateTime.now().month,
            year: DateTime.now().year,
            photooutTime: p.basename(imgPath.value),
            photoinTime: attendanceResponse.data?.photoinTime,
            checkinDate: attendanceResponse.data?.checkinDate,
            checkoutDate: DateTime.now(),
            latInTime: attendanceResponse.data?.latInTime,
            longInTime: attendanceResponse.data?.longInTime,
            locationinTime: attendanceResponse.data?.locationinTime,
            latOutTime: latitude.value.toString(),
            longOutTime: longitude.value.toString(),
            locationoutTime: address.value,
            status: 3),
      );
      print('response attendanceService.checkOut: $response');
      if (isTheSameDayMonthYear(
          attendanceResponse.data!.checkinDate!, DateTime.now())) {
        final TimesheetDto timesheetResponse = await timesheetService
            .createSingleTimesheet(mapAttendanceToTimesheet(
          AttendanceRequest(
              id: attendanceResponse.data!.id,
              employeeId: sessionService.getEmployeeId(),
              month: DateTime.now().month,
              year: DateTime.now().year,
              photooutTime: p.basename(imgPath.value),
              photoinTime: attendanceResponse.data!.photoinTime,
              checkinDate: attendanceResponse.data!.checkinDate,
              checkoutDate: DateTime.now(),
              latInTime: attendanceResponse.data!.latInTime,
              longInTime: attendanceResponse.data!.longInTime,
              locationinTime: attendanceResponse.data!.locationinTime,
              latOutTime: latitude.value.toString(),
              longOutTime: longitude.value.toString(),
              locationoutTime: address.value,
              status: 3),
        ));
      } else {
        List<TimesheetDto> attendanceRequest = [];
        final firstDayWorkHour = DateTime(
          attendanceResponse.data?.checkinDate?.year ?? DateTime.now().year,
          attendanceResponse.data?.checkinDate?.month ?? DateTime.now().month,
          attendanceResponse.data?.checkinDate?.day ?? DateTime.now().day,
          23,
          59,
          59,
        )
            .difference(attendanceResponse.data?.checkinDate ?? DateTime.now())
            .inHours
            .toDouble();
        final firstDayBreakTime = firstDayWorkHour > 4 ? "1" : "0";

        final minWorkHours = timesheetWorkHour.value?.hourlyType == "Hourly"
            ? timesheetWorkHour.value?.workHour ?? 8
            : 8;
        final firstDay = TimesheetDto(
            employeeId: sessionService.getEmployeeId(),
            docNo:
                "${DateTime.now().weekday}_${sessionService.getEmployeeId()}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${1}",
            date: attendanceResponse.data!.checkinDate!,
            day: attendanceResponse.data!.checkinDate!.day,
            week: getWeekNumber(attendanceResponse.data!.checkinDate!),
            year: attendanceResponse.data!.checkinDate!.year,
            startTime: DateFormat('HH:mm')
                .format(attendanceResponse.data!.checkinDate!),
            endTime: DateFormat('HH:mm').format(DateTime(
              attendanceResponse.data!.checkinDate!.year,
              attendanceResponse.data!.checkinDate!.month,
              attendanceResponse.data!.checkinDate!.day,
              23,
              59,
              59,
            )),
            breakTime: firstDayBreakTime,
            workHours: firstDayWorkHour,
            otHours: firstDayWorkHour - minWorkHours > 0
                ? firstDayWorkHour - minWorkHours
                : 0,
            remark: '',
            remark2: 'attendance ${response.data?.id ?? 0}',
            remark3: '',
            remarkScheduler: '',
            status: 0,
            createdBy: sessionService.getEmployeeId(),
            createdAt: DateTime.now(),
            updatedBy: sessionService.getEmployeeId(),
            updatedAt: DateTime.now());
        attendanceRequest.add(firstDay);
        final dayDifferenceCount = DateTime.now()
            .difference(attendanceResponse.data!.checkinDate!)
            .inDays;
        for (var i = 1; i < dayDifferenceCount; i++) {
          final day = TimesheetDto(
              employeeId: sessionService.getEmployeeId(),
              docNo:
                  "${DateTime.now().weekday}_${sessionService.getEmployeeId()}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${i + 1}",
              date:
                  attendanceResponse.data!.checkinDate!.add(Duration(days: i)),
              day: attendanceResponse.data!.checkinDate!
                  .add(Duration(days: i))
                  .day,
              week: getWeekNumber(
                  attendanceResponse.data!.checkinDate!.add(Duration(days: i))),
              year: attendanceResponse.data!.checkinDate!
                  .add(Duration(days: i))
                  .year,
              startTime: "00:01",
              endTime: "23:59",
              breakTime: "1",
              workHours: 23.9,
              otHours: 23.59 - minWorkHours > 0 ? 23.59 - minWorkHours : 0,
              remark: '',
              remark2: '',
              remark3: '',
              remarkScheduler: '',
              status: 0,
              createdBy: sessionService.getEmployeeId(),
              createdAt: DateTime.now(),
              updatedBy: sessionService.getEmployeeId(),
              updatedAt: DateTime.now());
          attendanceRequest.add(day);
        }
        final lastDayWorkHours = DateTime.now()
            .difference(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              0,
              0,
              1,
            ))
            .inHours
            .toDouble();
        final lastDayBreakTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  0,
                  0,
                  1,
                ).difference(DateTime.now()).inHours.toDouble() >
                4
            ? "1"
            : "0";

        final lastDay = TimesheetDto(
            employeeId: sessionService.getEmployeeId(),
            docNo:
                "${DateTime.now().weekday}_${sessionService.getEmployeeId()}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${dayDifferenceCount + 1}",
            date: DateTime.now(),
            day: DateTime.now().day,
            week: getWeekNumber(DateTime.now()),
            year: DateTime.now().year,
            startTime: "00:01",
            endTime: DateFormat('HH:mm').format(DateTime.now()),
            breakTime: lastDayBreakTime,
            workHours: lastDayWorkHours,
            otHours: lastDayWorkHours - minWorkHours > 0
                ? lastDayWorkHours - minWorkHours
                : 0,
            remark: '',
            remark2: '',
            remark3: '',
            remarkScheduler: '',
            status: 0,
            createdBy: sessionService.getEmployeeId(),
            createdAt: DateTime.now(),
            updatedBy: sessionService.getEmployeeId(),
            updatedAt: DateTime.now());
        attendanceRequest.add(lastDay);
        for (var i = 0; i < attendanceRequest.length; i++) {
          dev.log(
            "attendanceRequest[$i]: ${attendanceRequest[i].toString()}",
          );
        }
        final List<TimesheetDto> timesheetResponse =
            await timesheetService.updateTimesheet(attendanceRequest);
      }
      sessionService.removeCheckIn();
      CommonWidget.showNotif('Success', color: Colors.green);
      isCheckin.value = true;
      RouteUtil.back();
    } catch (e) {
      print(e);
      isCheckin.value = false;
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      isLoading.value = false;
      imgPath.value = '';
      imgType.value = ImgType.svg;
      imgFile = null;
    }
  }

  BuildContext? context;
  final imgPhSvg = 'assets/svgs/product/placeholder_product.svg';
  final imgPath = ''.obs;
  final imgRaw = Rxn<XFile>();
  final imgType = ImgType.svg.obs;
  File? imgFile;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void chooseImage() {
    CommonUtil.unFocus();
    CommonWidget.chooseImage(
      onChoose: (file) {
        if (file != null) {
          imgPath.value = file.path;
          imgRaw.value = file;
          imgFile = File(file.path);
          imgType.value = ImgType.file;
        } else {
          imgPath.value = imgPhSvg;
          imgFile = null;
          imgType.value = ImgType.svg;
        }
      },
      showGallery: false,
    );
  }

  bool isTheSameDayMonthYear(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  TimesheetDto mapAttendanceToTimesheet(AttendanceRequest attendanceRequest) {
    final minWorkHours = timesheetWorkHour.value?.hourlyType == "Hourly"
        ? timesheetWorkHour.value?.workHour ?? 8
        : 8;
    return TimesheetDto(
      employeeId: sessionService.getEmployeeId(),
      docNo:
          "${DateTime.now().weekday}_${sessionService.getEmployeeId()}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${1}",
      date: attendanceRequest.checkoutDate!,
      day: attendanceRequest.checkoutDate!.day,
      week: getWeekNumber(attendanceRequest.checkoutDate!),
      year: attendanceRequest.checkoutDate!.year,
      startTime: DateFormat('HH:mm').format(attendanceRequest.checkinDate!),
      endTime: DateFormat('HH:mm').format(attendanceRequest.checkoutDate!),
      breakTime: attendanceRequest.checkoutDate!
                  .difference(attendanceRequest.checkinDate!)
                  .inHours
                  .toDouble() >
              4
          ? "1"
          : "0",
      workHours: attendanceRequest.checkoutDate!
          .difference(attendanceRequest.checkinDate!)
          .inHours
          .toDouble(),
      otHours: minWorkHours -
                  attendanceRequest.checkoutDate!
                      .difference(attendanceRequest.checkinDate!)
                      .inHours
                      .toDouble() >
              0
          ? minWorkHours -
              attendanceRequest.checkoutDate!
                  .difference(attendanceRequest.checkinDate!)
                  .inHours
                  .toDouble()
          : 0,
      remark: '',
      remark2: '',
      remark3: '',
      remarkScheduler: '',
      status: 0,
      createdBy: sessionService.getEmployeeId(),
      createdAt: DateTime.now(),
      updatedBy: sessionService.getEmployeeId(),
      updatedAt: DateTime.now(),
    );
  }

  bool isUserCheckin() {
    if (sessionService.getCheckIn() == null) {
      return true;
    } else {
      isCheckin.value = false;
      return false;
    }
  }

  int getWeekNumber(DateTime date) {
    int numOfWeeks(int year) {
      DateTime dec28 = DateTime(year, 12, 28);
      int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
      return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
    }

    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  Future<bool> isTheSameFace(
    String? inputImage1,
    String? inputImage2,
  ) async {
    try {
      final isFaceSimiliar = await _faceDetectionService.isFaceSimiliar(
        inputImage1!,
        inputImage2!,
      );
      return isFaceSimiliar;
    } catch (e) {
      print(e);
    }
    return false;
  }

  final employeeTimesheet = Rxn<List<TimesheetDto>>();

  void getEmployeeTimesheet() async {
    try {
      isLoading.value = true;
      final response = await timesheetService.getEmployeeTimesheetByMonth(
        sessionService.getEmployeeId(),
        2,
        2024,
      );
      for (var i = 0; i < response.length; i++) {
        await timesheetService.deleteTimesheet(response[i].id!);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTimesheet(int id) async {
    try {
      isLoading.value = true;
      final response = await timesheetService.deleteTimesheet(id);
      getEmployeeTimesheet();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
