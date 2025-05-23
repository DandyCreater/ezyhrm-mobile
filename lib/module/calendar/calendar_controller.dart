import 'dart:core';

import 'package:ezyhr_mobile_apps/module/calendar/calendar_page.dart';
import 'package:ezyhr_mobile_apps/module/calendar/dto/meeting.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarC extends Bindings {
  static const route = '/calendar';
  static final page = GetPage(
    name: route,
    page: () => const CalendarScreen(),
    binding: CalendarC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<CalendarControllerMain>(() => CalendarControllerMain());
  }
}

class CalendarControllerMain extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final selectedDay = DateTime.now().obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final Rxn<DateTime> focusedDay = Rxn<DateTime>();

  final Rxn<List<Meeting>> meetings = Rxn<List<Meeting>>();
  final Rxn<CalendarFormat> calendarFormat = Rxn<CalendarFormat>();
  final Rxn<Map<DateTime, List<Meeting>>> events =
      Rxn<Map<DateTime, List<Meeting>>>();
  final Rxn<Map<DateTime, List<Meeting>>> visibleEvents =
      Rxn<Map<DateTime, List<Meeting>>>();
  final Rxn<Map<DateTime, List<Meeting>>> selectedEvents =
      Rxn<Map<DateTime, List<Meeting>>>();
  final Rxn<Map<DateTime, List<Meeting>>> allEvents =
      Rxn<Map<DateTime, List<Meeting>>>();
  final Rxn<List<Meeting>> selectedEvent = Rxn<List<Meeting>>();
  final Rxn<List<Meeting>> visibleEvent = Rxn<List<Meeting>>();
  final Rxn<List<Meeting>> allEvent = Rxn<List<Meeting>>();
}
