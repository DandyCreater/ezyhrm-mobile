import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_group_item_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_group_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_work_hour_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_day/timesheet_day_page.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_list/timesheet_list_page.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_service.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_util.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_week/timesheet_week_page.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimesheetC extends Bindings {
  static const route = '/timesheetList';
  static final timeSheetListPage = GetPage(
    name: route,
    page: () => const TimesheetListPage(),
    binding: TimesheetC(),
  );

  static const timesheetWeekRoute = '/timesheetWeek';
  static final timesheetWeekPage = GetPage(
    name: timesheetWeekRoute,
    page: () => const TimesheetWeekPage(),
    binding: TimesheetC(),
  );

  static const timsheetDayRoute = "/timesheet-day";
  static final timesheetDayPage = GetPage(
    name: timsheetDayRoute,
    page: () => const TimesheetDayPage(),
    binding: TimesheetC(),
  );
  @override
  void dependencies() {
    Get.lazyPut<TimesheetController>(() => TimesheetController());
  }
}

class TimesheetController extends GetxController {
  final isLoading = false.obs;
  final timesheetService = TimesheetService.instance;
  final sessionService = SessionService.instance;
  final TimesheetUtil timesheetUtil = TimesheetUtil();

  BuildContext? context;
  final selectedYear = DateTime.now().year.obs;
  final yearList = Rxn<List<String>>();

  final selectedMonth = DateFormat.MMMM().format(DateTime.now()).obs;
  final selectedMonthNumber = DateTime.now().month.obs;
  final currWeekIndex = 0.obs;

  final employeeTimesheet = Rxn<List<TimesheetDto>>();

  final timeRegex = RegExp(r'\d\d:\d\d');
  final startTime = ''.obs;
  final startTimeRx = Rxn<TimeOfDay>();
  final endTime = ''.obs;
  final endTimeRx = Rxn<TimeOfDay>();

  final timesheetWorkHour = Rxn<TimesheetWorkHourResponse>();
  final currentTimesheetList = Rxn<List<TimesheetDto>>();
  final currentRequestTimesheetList = Rxn<List<TimesheetDto>>();
  final currentUpdatedTimesheetList = Rxn<List<TimesheetDto>>();

  var monthlyWorkedHours = RxDouble(0.0);
  var monthlyOtHours = RxDouble(0.0);

  final publicHoliday = Rxn<List<DateTime>>(TimesheetUtil.getHolidays());

  late Rxn<List<DateTime>> daysInCurrentMonth = Rxn<List<DateTime>>(
    TimesheetUtil.getDaysInCurrentMonth(
      DateTime.now().year,
      DateTime.now().month,
    ),
  );
  final Rxn<List<TimesheetGroupResponse>> groupDays =
      Rxn<List<TimesheetGroupResponse>>();

  @override
  Future<void> onReady() async {
    super.onReady();
    await setYearList();
    await getData();
  }

  Future<void> getData() async {
    await getTimesheetWorkHour();

    await getEmployeeTimesheet();
  }

  final dayIndex = 0.obs;
  void setDayIndex(int val) {
    dayIndex.value = val;
  }

  Future<void> getEmployeeTimesheet() async {
    try {
      isLoading.value = true;
      final response = await timesheetService.getEmployeeTimesheetByMonth(
        sessionService.getEmployeeId(),
        selectedMonthNumber.value,
        selectedYear.value,
      );
      employeeTimesheet.value = response;
    } catch (e) {
      print(e);
    } finally {
      _groupDaysByWeek(daysInCurrentMonth.value!);
    }
  }

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

  Map<DateTime, List<DateTime>> _groupDaysByWeek(List<DateTime> days) {
    Map<DateTime, List<DateTime>> groupedDays = {};
    List<TimesheetGroupResponse> gd = [];

    monthlyWorkedHours.value = 0.0;
    monthlyOtHours.value = 0.0;
    var tmpHoursWorked = 0.0;
    var tmpOtHours = 0.0;
    for (DateTime day in days) {
      DateTime startOfWeek = day.subtract(Duration(days: day.weekday - 1));
      startOfWeek =
          DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

      if (!groupedDays.containsKey(startOfWeek)) {
        groupedDays[startOfWeek] = [];
      }

      groupedDays[startOfWeek]?.add(day);
    }

    for (DateTime day in groupedDays.keys) {
      double hoursWorked = 0;
      double otHours = 0;
      List<TimesheetGroupItemResponse> listTimesheetGroupItemResponse = [];

      for (DateTime dateTime in groupedDays[day]!) {
        log("day - ${dateTime.day}");
        final tmpTimesheet = getTmpTimesheet(dateTime);
        List<TimesheetDto> timesheetResponse = employeeTimesheet.value!
            .where((element) => element.date == dateTime)
            .toList();
        log("timesheetResponse - findWhere $timesheetResponse");
        if (timesheetResponse.length == 0) {
          timesheetResponse.add(tmpTimesheet);
        }
        var todayHoursWorked = 0.0;

        for (var timesheet in timesheetResponse) {
          TimesheetGroupItemResponse timesheetGroupItem =
              TimesheetGroupItemResponse(
            date: dateTime,
            timesheet: timesheet,
            controller: TextEditingController(),
          );
          listTimesheetGroupItemResponse.add(timesheetGroupItem);
          log("timesheet.startTime - ${timesheet.startTime}");
          log("timesheet.endTime - ${timesheet.endTime}");
          log("timesheet.breakTime - ${timesheet.breakTime}");
          var endTmpTime = convertToDouble(timesheet.endTime!);
          var startTmpTime = convertToDouble(timesheet.startTime!);
          var breakTmpTime = double.parse(timesheet.breakTime!);
          var tmpHoursWorked = (endTmpTime - startTmpTime) - breakTmpTime;
          log("tmpHoursWorked - cct $tmpHoursWorked");
          if (tmpHoursWorked < 0) {
            tmpHoursWorked = 0;
          }
          todayHoursWorked += tmpHoursWorked;
          log("todayHoursWorked - cct $todayHoursWorked");
        }

        if (timesheetWorkHour.value?.hourlyType != "Weekly") {
          var isWeekend = publicHoliday.value!.contains(dateTime) ||
              dateTime.weekday == 6 ||
              dateTime.weekday == 7;
          log("isWeekend - cct $isWeekend");
          if (isWeekend) {
            if (timesheetWorkHour.value?.employmentType == "Hourly") {
              otHours += todayHoursWorked;
              if (timesheetWorkHour.value?.workHour != 0) {
                final tmpOtHours = todayHoursWorked >
                        (double.parse(timesheetResponse[0].breakTime!) +
                            timesheetWorkHour.value!.workHour!)
                    ? todayHoursWorked -
                        (double.parse(timesheetResponse[0].breakTime!) +
                            timesheetWorkHour.value!.workHour!)
                    : 0;
                log("tmpOtHours - cct - 1 $tmpOtHours");
                otHours += tmpOtHours;
              } else {
                final tmpOtHours = todayHoursWorked >
                        (double.parse(timesheetResponse[0].breakTime!) + 8)
                    ? todayHoursWorked -
                        (double.parse(timesheetResponse[0].breakTime!) + 8)
                    : 0;
                log("tmpOtHours - cct - 2 $tmpOtHours");
                otHours += tmpOtHours;
                log("otHours - cct - 2 $otHours");
              }
            } else {
              var isWorking = false;
              for (var timesheet in timesheetResponse) {
                if (timesheet.remark != null) {
                  if (timesheet.remark!.toLowerCase().contains("working")) {
                    isWorking = true;
                  }
                }
              }
              log("isWorking - cct $isWorking");
              if (isWorking) {
                otHours += todayHoursWorked;
                if (timesheetWorkHour.value?.workHour != 0) {
                  final tmpOtHours = todayHoursWorked >
                          (double.parse(timesheetResponse[0].breakTime!) +
                              timesheetWorkHour.value!.workHour!)
                      ? todayHoursWorked -
                          (double.parse(timesheetResponse[0].breakTime!) +
                              timesheetWorkHour.value!.workHour!)
                      : 0;
                  log("tmpOtHours - cct - 3 $tmpOtHours");
                  otHours += tmpOtHours;
                  log("otHours - cct - 3 $otHours");
                } else {
                  final tmpOtHours = todayHoursWorked >
                          (double.parse(timesheetResponse[0].breakTime!) + 8)
                      ? todayHoursWorked -
                          (double.parse(timesheetResponse[0].breakTime!) + 8)
                      : 0;
                  log("tmpOtHours - cct - 4 $tmpOtHours");
                  otHours += tmpOtHours;
                  log("otHours - cct - 4 $otHours");
                }
              } else {
                hoursWorked += todayHoursWorked;
                log("hoursWorked - cct - 5 $hoursWorked");
                if (timesheetWorkHour.value?.workHour != 0) {
                  final tmpOtHours = todayHoursWorked >
                          (double.parse(timesheetResponse[0].breakTime!) +
                              (timesheetWorkHour.value?.workHour ?? 0)
                                  .toDouble())
                      ? todayHoursWorked -
                          (double.parse(timesheetResponse[0].breakTime!) +
                              (timesheetWorkHour.value?.workHour ?? 0)
                                  .toDouble())
                      : 0;
                  log("tmpOtHours - cct - 5 $tmpOtHours");
                  otHours += tmpOtHours;
                  log("otHours - cct - 5 $otHours");
                } else {
                  if (dateTime.weekday == 6 || dateTime.weekday == 7) {
                    otHours += todayHoursWorked > 0 ? todayHoursWorked : 0;
                    todayHoursWorked = 0;
                    log("otHours - cct - 6.11 $otHours");
                  } else {
                    final tmpOtHours = todayHoursWorked >
                            (double.parse(timesheetResponse[0].breakTime!) + 8)
                        ? todayHoursWorked -
                            (double.parse(timesheetResponse[0].breakTime!) + 8)
                        : 0;
                    log("tmpOtHours - cct - 6 $tmpOtHours");
                    otHours += tmpOtHours;
                    log("otHours - cct - 6 $otHours");
                  }
                }
              }
            }
          } else {
            hoursWorked += todayHoursWorked;
            log("hoursWorked - cct - 7 $hoursWorked");
            if (timesheetWorkHour.value?.workHour != 0) {
              final tmpOtHours = todayHoursWorked >
                      (double.parse(timesheetResponse[0].breakTime!) +
                          (timesheetWorkHour.value == null
                              ? 0.0
                              : timesheetWorkHour.value!.workHour!))
                  ? todayHoursWorked -
                      (double.parse(timesheetResponse[0].breakTime!) +
                          (timesheetWorkHour.value?.workHour != null &&
                                  timesheetWorkHour.value?.workHour != 0
                              ? timesheetWorkHour.value!.workHour!
                              : 0))
                  : 0;
              log("tmpOtHours - cct - 7 $tmpOtHours");
              otHours += tmpOtHours;
              log("otHours - cct - 7 $otHours");
            } else {
              var pp = double.parse(timesheetResponse[0].breakTime!);
              print(pp);
              final tmpOtHours = todayHoursWorked >
                      (double.parse(timesheetResponse[0].breakTime!) + 7)
                  ? todayHoursWorked -
                      (double.parse(timesheetResponse[0].breakTime!) + 7)
                  : 0;
              log("tmpOtHours - cct - 8 $tmpOtHours");
              otHours += tmpOtHours;
              log("otHours - cct - 8 $otHours");
            }
          }
        } else {
          hoursWorked += todayHoursWorked;
        }
      }
      if (timesheetWorkHour.value?.hourlyType == "Weekly") {
        if (timesheetWorkHour.value?.workHour != 0) {
          otHours += hoursWorked > timesheetWorkHour.value!.workHour!
              ? hoursWorked - timesheetWorkHour.value!.workHour!
              : 0;
        } else {
          otHours += hoursWorked > 44 ? hoursWorked - 44 : 0;
        }
        for (var timesheet in listTimesheetGroupItemResponse) {
          if (publicHoliday.value!.contains(timesheet.date)) {
            if (timesheetWorkHour.value?.employmentType == "Hourly") {
              hoursWorked -= timesheet.timesheet.workHours!;
              otHours -= timesheet.timesheet.otHours!;
            } else {
              if (timesheet.timesheet.remark != null) {
                if (timesheet.timesheet.remark!
                    .toLowerCase()
                    .contains("working")) {
                  otHours += timesheet.timesheet.workHours!;
                }
              }
            }
          }
        }
      }
      TimesheetGroupResponse group = TimesheetGroupResponse(
        startDate: groupedDays[day]!.first,
        endDate: groupedDays[day]!.last,
        hoursWorked: hoursWorked,
        otHours: otHours,
        listDatetime: listTimesheetGroupItemResponse,
      );

      gd.add(group);
    }
    groupDays.value = gd;
    for (TimesheetGroupResponse group in gd) {
      tmpHoursWorked += group.hoursWorked;
      tmpOtHours += group.otHours;
    }

    monthlyWorkedHours.value = tmpHoursWorked;
    monthlyOtHours.value = tmpOtHours;
    isLoading.value = false;
    return groupedDays;
  }

  setStartTime(int index) {
    showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
              .startTime =
          "${value!.hour < 10 ? "0${value.hour}" : "${value.hour}"}:${value.minute < 10 ? "0${value.minute}" : "${value.minute}"}";
      setTotalWorkingHours(index);

      groupDays.refresh();
    });
  }

  setEndTime(int index) {
    showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
              .startTime ==
          "00:00") {
        CommonWidget.showErrorNotif("Please set start time first");
        return;
      } else {
        if (convertToTimeOfDay(groupDays.value![currWeekIndex.value]
                        .listDatetime[index].timesheet.startTime!)
                    .hour >
                value!.hour ||
            (convertToTimeOfDay(groupDays.value![currWeekIndex.value]
                            .listDatetime[index].timesheet.startTime!)
                        .hour ==
                    value.hour &&
                convertToTimeOfDay(groupDays.value![currWeekIndex.value]
                            .listDatetime[index].timesheet.startTime!)
                        .minute >
                    value.minute)) {
          CommonWidget.showErrorNotif(
              "End time must be greater than start time");
          return;
        }
        var x = convertToDouble(groupDays.value![currWeekIndex.value]
            .listDatetime[index].timesheet.startTime!);
        var y = (value.hour + (value.minute / 60.0));
        if ((y - x) < 1) {
          CommonWidget.showErrorNotif("Minimum working hours is 1 hour");
          return;
        }
      }

      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
              .endTime =
          "${value.hour < 10 ? "0${value.hour}" : "${value.hour}"}:${value.minute < 10 ? "0${value.minute}" : "${value.minute}"}";
      setTotalWorkingHours(index);
      groupDays.refresh();
    });
  }

  setTotalWorkingHours(int index) {
    final startTime = groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.startTime;
    final endTime = groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.endTime;
    final breakTime = double.parse(groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.breakTime!);

    if (startTime != null &&
        startTime != "" &&
        startTime != "00:00" &&
        endTime != null &&
        endTime != "" &&
        endTime != "00:00") {
      var otHours = 0.00;
      final startTimeDouble = convertToDouble(startTime);
      final endTimeDouble = convertToDouble(endTime);
      final totalWorkingHours = (endTimeDouble - startTimeDouble) - breakTime;
      if (totalWorkingHours > 0) {
        monthlyWorkedHours.value -= groupDays.value![currWeekIndex.value]
            .listDatetime[index].timesheet.workHours!;
        monthlyOtHours.value -= groupDays
            .value![currWeekIndex.value].listDatetime[index].timesheet.otHours!;

        groupDays.value![currWeekIndex.value].hoursWorked -= groupDays
            .value![currWeekIndex.value]
            .listDatetime[index]
            .timesheet
            .workHours!;
        groupDays.value![currWeekIndex.value].otHours -= groupDays
            .value![currWeekIndex.value].listDatetime[index].timesheet.otHours!;

        groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
            .workHours = totalWorkingHours;
        monthlyWorkedHours.value += totalWorkingHours;
        groupDays.value![currWeekIndex.value].hoursWorked += totalWorkingHours;

        if (totalWorkingHours > 9) {
          otHours = totalWorkingHours - 8;
          groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
              .otHours = otHours;
          monthlyOtHours.value += otHours;
          groupDays.value![currWeekIndex.value].otHours += otHours;
        } else {
          groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
              .otHours = 0;
        }
      }

      groupDays.refresh();
    }
  }

  void getCurrentTimesheet() {
    final List<TimesheetGroupResponse> currentWeek = groupDays.value!;
    final List<TimesheetDto> cTimesheetList = [];
    final List<TimesheetDto> cRequestTimesheetList = [];
    final List<TimesheetDto> cUpdatedTimesheetList = [];
    for (var timesheetGroup in currentWeek) {
      for (var timesheetGroupItem in timesheetGroup.listDatetime) {
        cTimesheetList.add(timesheetGroupItem.timesheet);
        if (timesheetGroupItem.timesheet.id == null ||
            timesheetGroupItem.timesheet.id == 0) {
          final tmpTimesheet = timesheetGroupItem.timesheet;
          tmpTimesheet.remark = timesheetGroupItem.controller.text;
          cRequestTimesheetList.add(tmpTimesheet);
        } else {
          TimesheetDto timesheetResponse = timesheetGroupItem.timesheet;
          timesheetResponse.remark = timesheetGroupItem.controller.text;
          cUpdatedTimesheetList.add(timesheetResponse);
        }
      }
    }
    currentTimesheetList.value = cTimesheetList;
    currentRequestTimesheetList.value = cRequestTimesheetList;
    currentUpdatedTimesheetList.value = cUpdatedTimesheetList;
  }

  void getCurrentTimesheetSubmit() {
    final List<TimesheetGroupResponse> currentWeek = groupDays.value!;
    final List<TimesheetDto> cTimesheetList = [];
    final List<TimesheetDto> cRequestTimesheetList = [];
    final List<TimesheetDto> cUpdatedTimesheetList = [];
    for (var timesheetGroup in currentWeek) {
      for (var timesheetGroupItem in timesheetGroup.listDatetime) {
        cTimesheetList.add(timesheetGroupItem.timesheet);
        if (timesheetGroupItem.timesheet.id == null ||
            timesheetGroupItem.timesheet.id == 0) {
          final tmpTimesheet = timesheetGroupItem.timesheet;

          tmpTimesheet.remark = timesheetGroupItem.controller.text;
          cRequestTimesheetList.add(tmpTimesheet);
        } else {
          TimesheetDto timesheetResponse = timesheetGroupItem.timesheet;
          timesheetResponse.remark = timesheetGroupItem.controller.text;
          cUpdatedTimesheetList.add(timesheetResponse);
        }
      }
    }
    currentTimesheetList.value = cTimesheetList;
    currentRequestTimesheetList.value = cRequestTimesheetList;
    currentUpdatedTimesheetList.value = cUpdatedTimesheetList;

    for (var timesheet in currentRequestTimesheetList.value!) {
      timesheet.status = 1;
    }
    for (var timesheet in currentUpdatedTimesheetList.value!) {
      timesheet.status = 1;
    }
    currentRequestTimesheetList.refresh();
    currentUpdatedTimesheetList.refresh();
  }

  TimesheetDto getTmpTimesheet(DateTime dateTime) {
    return TimesheetDto(
      employeeId: sessionService.getEmployeeId(),
      docNo:
          "${dateTime.weekday}_${sessionService.getEmployeeId()}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${1}",
      date: dateTime,
      day: dateTime.day,
      week: getWeekNumber(dateTime),
      year: dateTime.year,
      startTime:
          dateTime.weekday == 6 || dateTime.weekday == 7 ? "00:00" : "09:00",
      endTime:
          dateTime.weekday == 6 || dateTime.weekday == 7 ? "00:00" : "18:00",
      breakTime: "1",
      workHours: dateTime.weekday == 6 || dateTime.weekday == 7 ? 0 : 8,
      otHours: 0,
      remark: "",
      remark2: "",
      remark3: "",
      remarkScheduler: "",
      status: 0,
      createdBy: sessionService.getEmployeeId(),
      createdAt: DateTime.now(),
      updatedBy: sessionService.getEmployeeId(),
      updatedAt: DateTime.now(),
    );
  }

  void setYear(int year) {
    selectedYear.value = year;
    daysInCurrentMonth.value = TimesheetUtil.getDaysInCurrentMonth(
      year,
      selectedMonthNumber.value,
    );
    getData();
  }

  void setMonth(String month) {
    int x = 0;
    selectedMonth.value = month;
    if (month == 'January') {
      x = 1;
    } else if (month == 'February') {
      x = 2;
    } else if (month == 'March') {
      x = 3;
    } else if (month == 'April') {
      x = 4;
    } else if (month == 'May') {
      x = 5;
    } else if (month == 'June') {
      x = 6;
    } else if (month == 'July') {
      x = 7;
    } else if (month == 'August') {
      x = 8;
    } else if (month == 'September') {
      x = 9;
    } else if (month == 'October') {
      x = 10;
    } else if (month == 'November') {
      x = 11;
    } else if (month == 'December') {
      x = 12;
    }
    selectedMonthNumber.value = x;
    daysInCurrentMonth.value =
        TimesheetUtil.getDaysInCurrentMonth(selectedYear.value, x);
    getData();
  }

  Future<void> setYearList() async {
    final currentYear = DateTime.now().year;
    final yl = List.generate(currentYear - (currentYear - 2),
        (index) => (currentYear - index).toString());
    yearList.value = yl;
  }

  double convertToDouble(String time) {
    List<String> parts = time.split(':');
    double hours = double.parse(parts[0]);
    double minutes = double.parse(parts[1]);

    double doubleTime = hours + (minutes / 60.0);
    return doubleTime;
  }

  TimeOfDay convertToTimeOfDay(String time) {
    List<String> parts = time.split(':');
    double hours = double.parse(parts[0]);
    double minutes = double.parse(parts[1]);
    TimeOfDay doubleTime =
        TimeOfDay(hour: hours.toInt(), minute: minutes.toInt());
    return doubleTime;
  }

  void setWeek(int i) {
    currWeekIndex.value = i;
    RouteUtil.to('/timesheetWeek');
  }

  bool isPublicHoliday(DateTime date) {
    return publicHoliday.value!.contains(date);
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

  void setBreakTime(int index, String value) {
    if (value == "0 m") {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "0";
    } else if (value == "15 m") {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "0.25";
    } else if (value == "30 m") {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "0.5";
    } else if (value == "45 m") {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "0.75";
    } else if (value == "1 h") {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "1";
    }
    setTotalWorkingHours(index);
    groupDays.refresh();
  }

  String getBreakTime(int index) {
    final breakTime = groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.breakTime;
    if (breakTime == "0") {
      return "0 m";
    } else if (breakTime == "0.25") {
      return "15 m";
    } else if (breakTime == "0.5") {
      return "30 m";
    } else if (breakTime == "0.75") {
      return "45 m";
    } else if (breakTime == "1") {
      return "1 h";
    }
    return "0 m";
  }

  List<String> isMoreThan6Hours(int index) {
    double startTime = convertToDouble(groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.endTime!);
    double endTime = convertToDouble(groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.startTime!);
    double breakTime = double.parse(groupDays
        .value![currWeekIndex.value].listDatetime[index].timesheet.breakTime!);
    double totalWorkingHours = (startTime - endTime) - breakTime;
    if (totalWorkingHours > 6) {
      groupDays.value![currWeekIndex.value].listDatetime[index].timesheet
          .breakTime = "1";
      groupDays.refresh();
      return ["45 m", "1 h"];
    }
    return ["0 m", "15 m", "30 m", "45 m", "1 h"];
  }

  void doSave() async {
    try {
      isLoading.value = true;

      getCurrentTimesheet();
      if (currentRequestTimesheetList.value!.length > 0) {
        await timesheetService
            .createTimesheet(currentRequestTimesheetList.value!);
      }
      if (currentUpdatedTimesheetList.value!.length > 0) {
        await timesheetService
            .updateTimesheet(currentUpdatedTimesheetList.value!);
      }
      CommonWidget.showNotif("Timsheet saved sucessfully");
      getData();
      RouteUtil.back();
    } catch (e) {
      print(e);
      CommonWidget.showErrorNotif("Somethings went wrong, try again");
    } finally {
      isLoading.value = false;
    }
  }

  void doSubmit() async {
    try {
      isLoading.value = true;
      getCurrentTimesheetSubmit();
      if (currentRequestTimesheetList.value!.length > 0) {
        await timesheetService
            .createTimesheet(currentRequestTimesheetList.value!);
      }
      if (currentUpdatedTimesheetList.value!.length > 0) {
        await timesheetService
            .updateTimesheet(currentUpdatedTimesheetList.value!);
      }
      CommonWidget.showNotif("Timsheet submitted sucessfully");
      RouteUtil.back();
      getData();
    } catch (e) {
      print(e);
      CommonWidget.showErrorNotif("Somethings went wrong, try again");
    } finally {
      isLoading.value = false;
    }
  }
}
