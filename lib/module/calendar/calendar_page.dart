import 'package:ezyhr_mobile_apps/module/calendar/calendar_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends GetView<CalendarControllerMain> {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Calendar',
        isBack: false,
      ),
      body: SafeArea(
        child: bodyWidget(),
      ),
    );
  }

  Widget bodyWidget() {
    return Obx(() => TableCalendar(
          firstDay: DateTime.utc(2020, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: controller.focusedDay.value ?? DateTime.now(),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onRangeSelected: (start, end, focusedDay) {
            controller.selectedDay.value = start!;
            controller.focusedDay.value = focusedDay;
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: ColorConstant.hexToColor("#784DFF"),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            selectedTextStyle: const TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50)),
            todayTextStyle: const TextStyle(color: Colors.black),
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            controller.selectedDay.value = selectedDay;
            controller.focusedDay.value = focusedDay;
          },
          onFormatChanged: (format) {
            controller.calendarFormat.value = format;
          },
          onPageChanged: (focusedDay) {
            controller.focusedDay.value = focusedDay;
          },
          selectedDayPredicate: (day) {
            return isSameDay(controller.selectedDay.value, day);
          },
        ));
  }
}
