import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimesheetWeekPage extends GetView<TimesheetController> {
  const TimesheetWeekPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        '${DateFormat('dd').format(controller.groupDays.value![controller.currWeekIndex.value].startDate)}' +
            " - " +
            '${DateFormat('dd MMM yyyy').format(controller.groupDays.value![controller.currWeekIndex.value].endDate)}',
        isBack: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: controller.getData,
      child: Obx(
        () => CommonWidget.expandedScrollWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          overscroll: false,
          top: controller.groupDays.value == null
              ? [const SizedBox()]
              : [
                  ...controller.groupDays.value![controller.currWeekIndex.value]
                      .listDatetime
                      .toList()
                      .asMap()
                      .map(
                        (i, e) => MapEntry(
                          i,
                          dailyWidgetV2(
                            i,
                            e.date,
                            e.timesheet.startTime,
                            e.timesheet.endTime,
                            controller.getBreakTime(i),
                            e.timesheet.status,
                            e.timesheet.workHours,
                            e.timesheet.otHours,
                            e.controller,
                          ),
                        ),
                      )
                      .values
                      .toList(),
                  SizedBox(height: SizeUtil.f(24)),
                ],
          bottom: [],
        ),
      ),
    );
  }

  Widget dailyWidgetV2(
      int index,
      DateTime? date,
      String? startTime,
      String? endTime,
      String? breakTime,
      int? status,
      double? workHours,
      double? otHours,
      TextEditingController textEditingController) {
    if (date!.compareTo(DateTime.now()) > 0) {
      return Container();
    }
    return InkWell(
      onTap: () async {
        controller.dayIndex.value = index;
        RouteUtil.to(
          TimesheetC.timsheetDayRoute,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8,
        ),
        decoration: CommonWidget.defBoxDecoration(),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.orange,
                          size: 32,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.textPrimaryWidget(
                              "Date",
                              color: Color(0xFF545454),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            CommonWidget.textPrimaryWidget(
                              "${DateFormat.yMMMMEEEEd().format(date)}",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: ShapeDecoration(
                                color: status == 0 ||
                                        controller.employeeTimesheet.value?[0]
                                                .status !=
                                            0
                                    ? Color(0xFFE8FFE4)
                                    : Color(0xFFEDFAFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CommonWidget.textPrimaryWidget(
                                    status == 0 ||
                                            controller.employeeTimesheet
                                                    .value?[0].status ==
                                                0
                                        ? "Saved"
                                        : "Submitted",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: status == 0 ||
                                            controller.employeeTimesheet
                                                    .value?[0].status !=
                                                0
                                        ? Color(0xFF00DD00)
                                        : Color(0xFF1EA7FF),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: SizeUtil.f(8)),
                            if (date.weekday == 6 || date.weekday == 7)
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFFFFE7),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonWidget.textPrimaryWidget(
                                      "Weekend",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFFFFD600),
                                    ),
                                  ],
                                ),
                              ),
                            if (controller.isPublicHoliday(date))
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: Colors.red[100]!,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonWidget.textPrimaryWidget(
                                      "Public Holiday",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.red[900]!,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "Working Hours",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF545454),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      workHours == null
                          ? 'Work Hours'
                          : workHours.toStringAsPrecision(3),
                      color: Color(0xFF0689FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget dailyWidget(
    int index,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? breakTime,
    int? status,
    double? workHours,
    double? otHours,
    TextEditingController textEditingController,
  ) {
    if (date!.compareTo(DateTime.now()) > 0) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: CommonWidget.defBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                "${DateFormat.yMMMMEEEEd().format(date)}",
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: ColorConstant.grey90,
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color: status == 0 ||
                          controller.employeeTimesheet.value?[0].status != 0
                      ? Color(0xFFE8FFE4)
                      : Color(0xFFEDFAFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      status == 0 ||
                              controller.employeeTimesheet.value?[0].status == 0
                          ? "Saved"
                          : "Submitted",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: status == 0 ||
                              controller.employeeTimesheet.value?[0].status != 0
                          ? Color(0xFF00DD00)
                          : Color(0xFF1EA7FF),
                    ),
                  ],
                ),
              ),
              SizedBox(width: SizeUtil.f(8)),
              if (date.weekday == 6 || date.weekday == 7)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFFFE7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.textPrimaryWidget(
                        "Weekend",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFFFFD600),
                      ),
                    ],
                  ),
                ),
              if (controller.isPublicHoliday(date))
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: ShapeDecoration(
                    color: Colors.red[100]!,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.textPrimaryWidget(
                        "Public Holiday",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.red[900]!,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => status == 0 ||
                          controller.employeeTimesheet.value.isEmpty ||
                          controller.employeeTimesheet.value?[0].status == 0
                      ? controller.setStartTime(index)
                      : null,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Start Time',
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: ColorConstant.grey90,
                          ),
                          SizedBox(width: SizeUtil.f(2)),
                          CommonWidget.textPrimaryWidget(
                            '*',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: ColorConstant.red60,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFE2E2E2)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonWidget.textPrimaryWidget(
                              startTime == '00:00' ? 'Select' : startTime!,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: startTime == '00:00' || status == 1
                                  ? ColorConstant.grey50
                                  : ColorConstant.black60,
                            ),
                            Icon(
                              Icons.timer_outlined,
                              color: ColorConstant.grey50,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: SizeUtil.f(8)),
              Expanded(
                child: GestureDetector(
                  onTap: () => status == 0 ||
                          controller.employeeTimesheet.value.isEmpty ||
                          controller.employeeTimesheet.value?[0].status == 0
                      ? controller.setEndTime(index)
                      : null,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'End Time',
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: ColorConstant.grey90,
                          ),
                          SizedBox(width: SizeUtil.f(2)),
                          CommonWidget.textPrimaryWidget(
                            '*',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: ColorConstant.red60,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFE2E2E2)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          children: [
                            CommonWidget.textPrimaryWidget(
                                endTime == '00:00' ? 'Select' : endTime!,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: endTime == '00:00' || status == 1
                                    ? ColorConstant.grey50
                                    : ColorConstant.black60),
                            const Spacer(),
                            Icon(
                              Icons.timer_outlined,
                              color: ColorConstant.grey50,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: SizeUtil.f(8)),
              GestureDetector(
                onTap: () {
                  if (status == 0 ||
                      controller.employeeTimesheet.value?.length == 0 ||
                      controller.employeeTimesheet.value?[0].status == 0) {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller.isMoreThan6Hours(index),
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setBreakTime(index, e);
                      },
                      value: breakTime,
                      title: 'Break Time',
                    );
                  }
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                          'Break Time',
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: ColorConstant.grey90,
                        ),
                        SizedBox(width: SizeUtil.f(2)),
                        CommonWidget.textPrimaryWidget(
                          '*',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: ColorConstant.red60,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFE2E2E2)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        children: [
                          CommonWidget.textPrimaryWidget(
                              breakTime == null ? 'Break Time' : breakTime,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: breakTime == null || status == 1
                                  ? ColorConstant.grey50
                                  : ColorConstant.black60),
                          Icon(
                            Icons.arrow_drop_down,
                            color: ColorConstant.grey50,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      CommonWidget.textPrimaryWidget(
                        'Hours',
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: ColorConstant.grey90,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0, color: Color(0xFFE2E2E2)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                            workHours == null
                                ? 'Work Hours'
                                : workHours.toStringAsPrecision(3),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.black60),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          CommonWidget.textPrimaryWidget("Remarks",
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: ColorConstant.grey90),
          SizedBox(height: SizeUtil.f(4)),
          CommonWidget.textFieldWidget(
            controller: textEditingController,
            placeholder: 'Remarks',
            maxLines: 3,
            maxLength: 200,
            validator: [],
            enabled: status == 0 ? true : false,
            isDense: true,
            textStyle: CommonWidget.textStyleRoboto(
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f(14),
              color: ColorConstant.black60,
            ),
            placeholderStyle: CommonWidget.textStyleRoboto(
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f(14),
              color: ColorConstant.grey50,
            ),
          ),
        ],
      ),
    );
  }
}
