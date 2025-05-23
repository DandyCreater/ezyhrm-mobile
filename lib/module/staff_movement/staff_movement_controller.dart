import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/leave_request/leave_request_service.dart';
import 'package:ezyhr_mobile_apps/module/leave_request/response/leave_type_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_hrms_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_create.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_detail.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_page.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_pageable_response.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_response.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StaffMovementC extends Bindings {
  static const route = '/staff-movement';
  static final page = GetPage(
    name: route,
    page: () => const StaffMovementView(),
    binding: StaffMovementC(),
  );

  static const routeCreate = '/staff-movement-create';
  static final pageCreate = GetPage(
    name: routeCreate,
    page: () => const StaffMovementCreareView(),
    binding: StaffMovementC(),
  );

  static const routeDetail = '/staff-movement-detail';
  static final pageDetail = GetPage(
    name: routeDetail,
    page: () => const StaffMovementDetail(),
    binding: StaffMovementC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<StaffMovementController>(() => StaffMovementController());
  }
}

class StaffMovementController extends GetxController {
  BuildContext? context;

  final staffMovemnetService = StaffMovementService.instance;
  final leaveService = LeaveRequestService.instance;
  final sessionService = SessionService.instance;
  final profileService = ProfileService.instance;

  final isLoading = false.obs;

  final staffMovementPageable = Rxn<StaffMovementPageableResponse>();
  final leaveTypeList = Rxn<List<LeaveTypeResponse>>();
  final currentStaffMovement = Rxn<StaffMovementResponse>();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final remarksController = TextEditingController();

  final profileHrms = Rxn<ProfileHrmsResponse>();

  final startDateVar = Rxn<DateTime>(DateTime.now());
  final endDateVar = Rxn<DateTime>(DateTime.now());
  final startTimeVar = Rxn<TimeOfDay>(TimeOfDay.now());
  final endTimeVar = Rxn<TimeOfDay>(TimeOfDay.now());

  void setStartTime(BuildContext context) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    selectedTime.then((value) {
      if (value != null) {
        startTimeController.text = value.format(context);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    isLoading.value = true;
    await getProfile();
    await getStaffMovement();
    isLoading.value = false;
  }

  Future<void> getStaffMovement() async {
    try {
      final response = await staffMovemnetService.getStaffMovement(1, 1000);
      final tmpList = response.items!
          .where((element) => element.dateFrom!.isAfter(startDateQuery.value!))
          .where((element) => element.dateTo!.isBefore(endDateQuery.value!))
          .toList();
      response.items = tmpList;
      response.reverseItems();
      staffMovementPageable.value = response;
    } finally {}
  }

  Future<void> getLeaveType() async {
    try {
      final response = await leaveService.getLeaveType();
      leaveTypeList.value = response;
    } finally {}
  }

  Future<void> getProfile() async {
    try {
      final response =
          await profileService.getProfileHrms(sessionService.getEmployeeId());
      profileHrms.value = response;
    } finally {}
  }

  String getLeaveTypeByIdd(int id) {
    switch (id) {
      case 0:
        return "INACTIVE";
      case 1:
        return "ACTIVE";
      case 2:
        return "PENDING";
      case 3:
        return "CANCELED";
      case 4:
        return "APPROVED";
      case 5:
        return "REJECTED";
      default:
        return "";
    }
  }

  void setCurrentStaffMovement(StaffMovementResponse? staffMovement) {
    currentStaffMovement.value = staffMovement;
  }

  void onStartDateTimeChange(DateRangePickerSelectionChangedArgs? dateTime) {
    startDateVar.value = dateTime?.value ?? DateTime.now();
    startDateController.text = dateTime?.toString() ?? '';
  }

  void onConfirmStartDateTimeChange(DateTime? dateTime) {
    endDateVar.value = dateTime;
    endDateController.text = dateTime?.toString() ?? '';
  }

  void onStartTimeChange(TimeOfDay? time) {
    startTimeVar.value = time;
    startTimeController.text = time?.format(Get.context!) ?? '';
  }

  void onEndDateTimeChange(DateRangePickerSelectionChangedArgs? dateTime) {
    endDateVar.value = dateTime?.value ?? DateTime.now();
    endDateController.text = dateTime?.toString() ?? '';
  }

  void onConfirmEndDateTimeChange(DateTime? dateTime) {
    endDateVar.value = dateTime;
    endDateController.text = dateTime?.toString() ?? '';
  }

  void onEndTimeChange(TimeOfDay? time) {
    endTimeVar.value = time;
    endTimeController.text = time?.format(Get.context!) ?? '';
  }

  void onSubmit() async {
    if (startDateVar.value == null) {
      CommonWidget.showErrorNotif('Please select start date');
      return;
    }
    if (endDateVar.value == null) {
      CommonWidget.showErrorNotif('Please select end date');
      return;
    }
    if (startTimeVar.value == null) {
      CommonWidget.showErrorNotif('Please select start time');
      return;
    }

    if (endTimeVar.value == null) {
      CommonWidget.showErrorNotif('Please select end time');
      return;
    }

    if (remarksController.text.isEmpty) {
      CommonWidget.showErrorNotif('Please enter remarks');
      return;
    }

    final request = StaffMovementResponse(
      employeeId: sessionService.getEmployeeId(),
      fullName: profileHrms.value?.employeeName ?? "-",
      dateFrom: DateTime(
        startDateVar.value!.year,
        startDateVar.value!.month,
        startDateVar.value!.day,
        startTimeVar.value!.hour,
        startTimeVar.value!.minute,
      ),
      dateTo: DateTime(
        endDateVar.value!.year,
        endDateVar.value!.month,
        endDateVar.value!.day,
        endTimeVar.value!.hour,
        endTimeVar.value!.minute,
      ),
      lastModifiedDateTime: DateTime.now(),
      remarks: remarksController.text,
      status: 1,
      id: 0,
    );

    try {
      isLoading.value = true;
      await staffMovemnetService.createStaffMovement(request);
      CommonWidget.showNotif('Staff Movement created');
      Get.back();
    } catch (e) {
      CommonWidget.showErrorNotif('Failed to create staff movement');
    } finally {
      isLoading.value = false;
    }
  }

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  final startDateQuery = Rxn<DateTime>(DateTime.now());
  final endDateQuery = Rxn<DateTime>(DateTime.now().add(Duration(days: 7)));
  final startDateStringQuery =
      Rxn<String>(DateFormat('d MMMM yyyy').format(DateTime.now()));
  final endDateStringQuery = Rxn<String>(
      DateFormat('d MMMM yyyy').format(DateTime.now().add(Duration(days: 7))));

  void onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    log('onDateSelectionChanged ${args.value}}');
    dateRangePickerController.selectedRange = PickerDateRange(
      args.value.startDate,
      args.value.endDate,
    );
    startDateQuery.value = args.value.startDate;
    startDateStringQuery.value =
        DateFormat('d MMMM yyyy').format(args.value.startDate!);
    if (args.value.endDate != null) {
      endDateQuery.value = args.value.endDate;
      endDateStringQuery.value =
          DateFormat('d MMMM yyyy').format(args.value.endDate!);
    }
  }

  void onConfirm(PickerDateRange args) {
    startDateQuery.value = args.startDate;
    startDateStringQuery.value =
        DateFormat('d MMMM yyyy').format(args.startDate!);
    if (args.endDate != null) {
      endDateQuery.value = args.endDate;
      endDateStringQuery.value =
          DateFormat('d MMMM yyyy').format(args.endDate!);
    }
    log('onConfirm ${args.startDate} ${args.endDate}');
    getData();
  }
}
