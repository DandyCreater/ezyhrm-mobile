import 'dart:developer';
import 'dart:io';

import 'package:ezyhr_mobile_apps/module/file/file_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/request/employee_leave_request.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/employee_leave_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_prorate_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/table_leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../shared/utils/common_util.dart';
import '../../widget/common_widget.dart';
import 'request_form_screen.dart';

class LRequestFormC extends Bindings {
  static const route = '/leave-request';
  static final page = GetPage(
    name: route,
    page: () => const LRequestFormScreen(),
    binding: LRequestFormC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<LRequestFormController>(() => LRequestFormController());
  }
}

class LRequestFormController extends GetxController {
  final leaveRequestService = LeaveRequestService.instance;
  final sessionService = SessionService.instance;
  final fileUploadService = FileUploadService.instance;
  final isLoading = false.obs;
  final selectedTypeOfLeave = Rxn<TableLeaveBalanceResponse>();
  final typeOfLeave = Rxn<LeaveTypeResponse>();
  final employeeLeaveType = Rxn<List<LeaveTypeResponse>>();
  final employeeLeave = Rxn<List<EmployeeLeaveResponse>>();
  final duration = 0.0.obs;
  final startTime = ''.obs;
  final startTimeRx = Rxn<TimeOfDay>();
  final endTime = ''.obs;
  final endTimeRx = Rxn<TimeOfDay>();
  final leaveBalanceProrate = Rxn<LeaveBalanceProrateResponse>();

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  BuildContext? context;

  final imgPath = ''.obs;
  final imgType = ImgType.svg.obs;
  File? imgFile;

  final isTypeOfLeaveSelected = RxBool(false);

  final imgPhSvg = 'assets/svgs/ic_upload_cloud.svg';

  final startDateTimeText = 'Whole Day'.obs;
  final startDateTimeId = 1.obs;
  final endDateTimeText = 'Whole Day'.obs;
  final endDateTimeId = 1.obs;
  final listLeaveBalance = Rxn<List<LeaveBalanceResponse>>();
  final tableLeaveBalance = Rxn<List<TableLeaveBalanceResponse>>();
  final blacklistDate = Rxn<List<DateTime>>([]);
  void setStartDateTime(String text) {
    if (text == 'Whole Day') {
      startDateTimeText.value = text;
      startDateTimeId.value = 1;
    } else if (text == 'AM') {
      startDateTimeText.value = text;
      startDateTimeId.value = 2;
    } else if (text == 'PM') {
      startDateTimeText.value = text;
      startDateTimeId.value = 3;
    }
    startDateTimeText.refresh();
    startDateTimeId.refresh();
    final startDateFormatted = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
    );
    final DateTime endDateFormatted;
    if (endDate.value == null) {
      endDateFormatted = DateTime(
        startDate.value!.year,
        startDate.value!.month,
        startDate.value!.day,
      );
    } else {
      endDateFormatted = DateTime(
        endDate.value!.year,
        endDate.value!.month,
        endDate.value!.day,
      );
    }

    var amOrPmDeduction = 0.0;
    if (startDateTimeId.value == 2 || startDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    if (endDateTimeId.value == 2 || endDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    duration.value =
        calculateWeekdaysDifference(startDateFormatted, endDateFormatted) +
            amOrPmDeduction;
  }

  List<DateTime> generateDateRange(DateTime startDate, DateTime endDate) {
    List<DateTime> dateList = [];

    if (startDate.isAfter(endDate)) {
      return dateList;
    }

    dateList.add(startDate);

    while (startDate.isBefore(endDate)) {
      startDate = startDate.add(const Duration(days: 1));
      dateList.add(startDate);
    }

    return dateList;
  }

  TextEditingController remarkController = TextEditingController();
  void setEndDateTime(String text) {
    if (text == 'Whole Day') {
      endDateTimeText.value = text;
      endDateTimeId.value = 1;
    } else if (text == 'AM') {
      endDateTimeText.value = text;
      endDateTimeId.value = 2;
    } else if (text == 'PM') {
      endDateTimeText.value = text;
      endDateTimeId.value = 3;
    }
    endDateTimeText.refresh();
    endDateTimeId.refresh();
    final startDateFormatted = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
    );
    final DateTime endDateFormatted;
    if (endDate.value == null) {
      endDateFormatted = DateTime(
        startDate.value!.year,
        startDate.value!.month,
        startDate.value!.day,
      );
    } else {
      endDateFormatted = DateTime(
        endDate.value!.year,
        endDate.value!.month,
        endDate.value!.day,
      );
    }
    var amOrPmDeduction = 0.0;
    if (startDateTimeId.value == 2 || startDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    if (endDateTimeId.value == 2 || endDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    duration.value =
        calculateWeekdaysDifference(startDateFormatted, endDateFormatted) +
            amOrPmDeduction;
  }

  final publicHoliday = Rxn<List<DateTime>>();
  @override
  void onReady() {
    super.onReady();
    getData();
    publicHoliday.value = convertToDateTimeList(dateStrings);
  }

  List<DateTime> convertToDateTimeList(List<String> dateStrings) {
    return dateStrings.map((dateString) {
      List<String> parts = dateString.split(' ');
      int day = int.parse(parts[0]);
      String monthString = parts[1];
      int year = int.parse(parts[2]);

      int month;
      switch (monthString) {
        case 'January':
          month = 1;
          break;
        case 'February':
          month = 2;
          break;
        case 'March':
          month = 3;
          break;
        case 'April':
          month = 4;
          break;
        case 'May':
          month = 5;
          break;
        case 'June':
          month = 6;
          break;
        case 'July':
          month = 7;
          break;
        case 'August':
          month = 8;
          break;
        case 'September':
          month = 9;
          break;
        case 'October':
          month = 10;
          break;
        case 'November':
          month = 11;
          break;
        case 'December':
          month = 12;
          break;
        default:
          throw Exception('Invalid month: $monthString');
      }

      return DateTime(year, month, day);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    publicHoliday.value = convertToDateTimeList(dateStrings);
  }

  @override
  void onClose() {
    super.onClose();
    startTime.close();
    endTime.close();
    startTimeRx.close();
    endTimeRx.close();
    imgPath.close();
    imgType.close();
    isTypeOfLeaveSelected.close();
    startDateTimeText.close();
    startDateTimeId.close();
    endDateTimeText.close();
    endDateTimeId.close();
    remarkController.dispose();
  }

  Future<void> getData() async {
    await getLeaveType();
    await getLeaveBalanceProrate();
    await getEmployeeLeaveByYear();
  }

  Future<void> getLeaveType() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getLeaveType();
      log('response leaveRequestService.getLeaveType: $response');
      employeeLeaveType.value = response;
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEmployeeLeaveByYear() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getEmployeeLeaveByYear(
          sessionService.getEmployeeId(), DateTime.now().year);
      employeeLeave.value = response;
    } catch (e) {
      log(e.toString());
    } finally {
      mapEmployeeLeaveToBlackListDate(employeeLeave.value!);
    }
  }

  Future<void> getLeaveBalanceProrate() async {
    try {
      isLoading.value = true;
      final response = await leaveRequestService.getLeaveBalanceProrate(
        sessionService.getEmployeeId(),
      );
      leaveBalanceProrate.value = response;
    } catch (e) {
      log(e.toString());
    } finally {
      mapToTable();
    }
  }

  void mapEmployeeLeaveToBlackListDate(
      List<EmployeeLeaveResponse> employeeLeave) {
    final list = employeeLeave.map((e) {
      if (e.startDate != null && e.endDate != null) {
        if (e.status == 0 || e.status == 1 || e.status == 2 || e.status == 4) {
          final startDate = e.startDate;
          final endDate = e.endDate;
          return generateDateRange(startDate!, endDate!);
        }
        return [];
      }
      return [];
    }).toList();
    final flattenList = list.expand((element) => element).toList();
    blacklistDate.value = flattenList.cast<DateTime>();
    isLoading.value = false;
  }

  Future<void> mapToTable() async {
    final list = employeeLeaveType.value?.map((e) {
      final leaveBalance =
          leaveBalanceProrate.value?.leaveBalanceList?.firstWhere(
        (element) => element.leaveTypeId == e.id,
        orElse: () => LeaveBalanceList(
          leaveTypeId: e.id,
          leaveBalance: 0,
          leaveTaken: 0,
          leaveEntitle: 0,
        ),
      );
      return TableLeaveBalanceResponse(
        id: e.id,
        name: e.name,
        leaveTypeId: leaveBalance?.leaveTypeId,
        leaveEntitle: leaveBalance?.leaveEntitle,
        leaveTaken: leaveBalance?.leaveTaken,
        leaveBalance: leaveBalance?.leaveBalance,
      );
    }).toList();
    list?.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    tableLeaveBalance.value = list;
    isLoading.value = false;
  }

  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);

  void onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    log('onDateSelectionChanged ${args.value}}');
    bool containsBlackoutDates = args.value != null &&
        args.value.startDate != null &&
        args.value.endDate != null &&
        blacklistDate.value!.any((blackoutDate) =>
            blackoutDate.isAfter(args.value!.startDate!) &&
            blackoutDate.isBefore(args.value!.endDate!));

    if (containsBlackoutDates) {
      CommonWidget.showErrorNotif(
          "You have applied leave on the selected date range. Please select another date range.");

      dateRangePickerController.selectedRange = null;
      return;
    }
    dateRangePickerController.selectedRange = PickerDateRange(
      args.value.startDate,
      args.value.endDate,
    );
    startDate.value = args.value.startDate;
    endDate.value = args.value.endDate;
    final startDateFormatted = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
    );
    final endDateFormatted;
    if (endDate.value == null) {
      endDateFormatted = DateTime(
        startDate.value!.year,
        startDate.value!.month,
        startDate.value!.day,
      );
    } else {
      endDateFormatted = DateTime(
        endDate.value!.year,
        endDate.value!.month,
        endDate.value!.day,
      );
    }
    var amOrPmDeduction = 0.0;
    if (startDateTimeId.value == 2 || startDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    if (endDateTimeId.value == 2 || endDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    duration.value =
        calculateWeekdaysDifference(startDateFormatted, endDateFormatted) +
            amOrPmDeduction;
    return;
  }

  void onConfirm(PickerDateRange args) {
    startDate.value = args.startDate;
    endDate.value = args.endDate;
    final startDateFormatted = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
    );
    final endDateFormatted;
    if (endDate.value == null) {
      endDateFormatted = DateTime(
        startDate.value!.year,
        startDate.value!.month,
        startDate.value!.day,
      );
    } else {
      endDateFormatted = DateTime(
        endDate.value!.year,
        endDate.value!.month,
        endDate.value!.day,
      );
    }
    var amOrPmDeduction = 0.0;
    if (startDateTimeId.value == 2 || startDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    if (endDateTimeId.value == 2 || endDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    duration.value =
        calculateWeekdaysDifference(startDateFormatted, endDateFormatted) +
            amOrPmDeduction;
  }

  final RxBool showDialog = RxBool(false);

  void openDateDialog() {
    showDialog.value = true;
  }

  chooseFromFile() {
    Get.defaultDialog(
      title: 'Choose from file',
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void chooseImage() {
    CommonUtil.unFocus();
    CommonWidget.chooseImage(
      onChoose: (file) {
        if (file != null) {
          imgPath.value = file.path;
          imgFile = File(file.path);
          imgType.value = ImgType.file;
        } else {
          imgPath.value = imgPhSvg;
          imgFile = null;
          imgType.value = ImgType.svg;
        }
      },
      showGallery: true,
    );
  }

  bool doCheckInput() {
    if (selectedTypeOfLeave.value == null) {
      CommonWidget.showErrorNotif('Please select type of leave');
      return false;
    }
    if (startDate.value == null) {
      CommonWidget.showErrorNotif('Please select date');
      return false;
    }
    if (selectedTypeOfLeave.value?.name == "Medical" ||
        selectedTypeOfLeave.value?.name == "Hospitalisation Leave") {
      if (imgPath.value == '') {
        CommonWidget.showErrorNotif('Please attach document');
        return false;
      }
    }
    return true;
  }

  List<String> dateStrings = [
    "1 January 2023",
    "2 January 2023",
    "22 January 2023",
    "23 January 2023",
    "24 January 2023",
    "7 April 2023",
    "22 April 2023",
    "1 May 2023",
    "2 June 2023",
    "29 June 2023",
    "9 August 2023",
    "1 September 2023",
    "12 November 2023",
    "13 November 2023",
    "25 December 2023",
    '1 January 2024',
    '10 February 2024',
    '11 February 2024',
    '12 February 2024',
    '29 March 2024',
    '10 April 2024',
    '1 May 2024',
    '22 May 2024',
    '17 June 2024',
    '9 August 2024',
    '31 October 2024',
    '25 December 2024',
  ];

  int calculateWeekdaysDifference(DateTime start, DateTime end) {
    int weekdaysCount = 0;
    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday &&
          !publicHoliday.value!.contains(currentDate)) {
        weekdaysCount++;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return weekdaysCount;
  }

  void doSubmit() async {
    if (!doCheckInput()) {
      return;
    }
    if (imgPath.value != '') {
      try {
        isLoading.value = true;

        await fileUploadService.uploadImageLeaveRequest(
            imgPath.value, sessionService.getInstanceName(), ".");
      } catch (e) {
        CommonWidget.showErrorNotif(e.toString());
        CommonWidget.showErrorNotif("Failed to upload Image");
        log('error: $e');
      }
    }

    final startDateFormatted = DateTime(
      startDate.value!.year,
      startDate.value!.month,
      startDate.value!.day,
    );
    endDate.value ??= startDate.value;
    final endDateFormatted = DateTime(
      endDate.value!.year,
      endDate.value!.month,
      endDate.value!.day,
    );
    var amOrPmDeduction = 0.0;
    if (startDateTimeId.value == 2 || startDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    if (endDateTimeId.value == 2 || endDateTimeId == 3) {
      amOrPmDeduction -= 0.5;
    }
    final duration =
        calculateWeekdaysDifference(startDateFormatted, endDateFormatted) +
            amOrPmDeduction;
    final curLeaveBalance =
        selectedTypeOfLeave.value?.leaveBalance?.toDouble() ?? 0.0;
    if (duration > curLeaveBalance) {
      CommonWidget.showErrorNotif(
          "Not enough leave balance, please set the date range count to be less than or equal to the leave balance.");
      return;
    }
    final employeeLeaveRequest = EmployeeLeaveRequest(
      leaveTypeId: selectedTypeOfLeave.value?.id ?? 0,
      employeeId: sessionService.getEmployeeId(),
      year: DateTime.now().year,
      date: DateTime.now(),
      dayCount: duration,
      startDate: startDateFormatted,
      endDate: endDateFormatted,
      confirmedBy: sessionService.getEmployeeId(),
      startLeaveType: startDateTimeId.value,
      endLeaveType: endDateTimeId.value,
      leaveDocument: p.basename(imgPath.value),
      status: 2,
      remark: remarkController.text,
      createdAt: DateTime.now(),
      createdBy: sessionService.getEmployeeId(),
      updatedAt: DateTime.now(),
      updatedBy: sessionService.getEmployeeId(),
    );
    log('employeeLeaveRequest: ${employeeLeaveRequest.toJson()}');
    try {
      isLoading.value = true;
      final response =
          await leaveRequestService.createLeaveRequest(employeeLeaveRequest);

      log('response: $response');
      CommonWidget.showNotif('Success', color: Colors.green);
      RouteUtil.back();
    } catch (e) {
      log('error @ doSubmit requst from controller: $e');
      CommonWidget.showErrorNotif("Not enough leave balance");
    } finally {
      isLoading.value = false;
    }
  }
}
