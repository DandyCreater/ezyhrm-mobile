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

class TimesheetDayPage extends GetView<TimesheetController> {
  const TimesheetDayPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        '${DateFormat('EEEE, dd MMM yyyy').format(controller.groupDays.value![controller.currWeekIndex.value].listDatetime[controller.dayIndex.value].date)}',
        isBack: true,
      ),
      body: Obx(
        () => _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    int index = controller.dayIndex.value;
    DateTime date = controller.groupDays.value![controller.currWeekIndex.value]
        .listDatetime[controller.dayIndex.value].date;
    String startTime = controller
            .groupDays
            .value![controller.currWeekIndex.value]
            .listDatetime[controller.dayIndex.value]
            .timesheet
            .startTime ??
        "";
    String endTime = controller.groupDays.value![controller.currWeekIndex.value]
            .listDatetime[controller.dayIndex.value].timesheet.endTime ??
        "";
    String breakTime = controller.getBreakTime(controller.dayIndex.value) ?? "";
    int status = controller.groupDays.value![controller.currWeekIndex.value]
            .listDatetime[controller.dayIndex.value].timesheet.status ??
        0;
    double workHours = controller
            .groupDays
            .value![controller.currWeekIndex.value]
            .listDatetime[controller.dayIndex.value]
            .timesheet
            .workHours ??
        0;
    double otHours = controller.groupDays.value![controller.currWeekIndex.value]
            .listDatetime[controller.dayIndex.value].timesheet.otHours ??
        0;
    TextEditingController textEditingController = controller
        .groupDays
        .value![controller.currWeekIndex.value]
        .listDatetime[controller.dayIndex.value]
        .controller;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 24,
      ),
      decoration: CommonWidget.defBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
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
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: SizeUtil.f(2)),
                          CommonWidget.textPrimaryWidget(
                            '*',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
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
                              startTime == '00:00' ? 'Select' : startTime,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
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
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: SizeUtil.f(2)),
                          CommonWidget.textPrimaryWidget(
                            '*',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
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
                                endTime == '00:00' ? 'Select' : endTime,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
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
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
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
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: SizeUtil.f(2)),
                          CommonWidget.textPrimaryWidget(
                            '*',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
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
                                color: status == 1
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
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 4,
                      ),
                      child: CommonWidget.textPrimaryWidget(
                        'Hours',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(16)),
          CommonWidget.textPrimaryWidget(
            "Remarks",
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
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
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: CommonWidget.primaryButtonWidget(
                    caption: 'Cancel',
                    bgColor: Colors.white,
                    onTap: () {
                      RouteUtil.back();
                    },
                    isLoading: controller.isLoading.value,
                    captionColor: Colors.black,
                    border: BorderSide(
                      width: 1,
                      color: Color(0xFFE2E2E2),
                    )),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: CommonWidget.primaryButtonWidget(
                  caption: 'Save',
                  bgColor: controller.employeeTimesheet.value.isEmpty
                      ? Colors.green[300]
                      : controller.employeeTimesheet.value?[0].status != 0
                          ? Colors.grey[400]
                          : Colors.green[300],
                  onTap: () {
                    if (controller.employeeTimesheet.value.isEmpty) {
                      if (controller.isLoading.value) {
                        CommonWidget.showErrorNotif(
                            "Please wait for process to finish loading");
                      } else {
                        controller.doSave();
                      }
                    } else {
                      if (controller.employeeTimesheet.value![0].status == 0) {
                        if (controller.isLoading.value) {
                          CommonWidget.showErrorNotif(
                              "Please wait for process to finish loading");
                        } else {
                          controller.doSave();
                        }
                      } else {
                        CommonWidget.showErrorNotif(
                            "This timesheet has been submitted. You can't save it anymore.");
                      }
                    }
                  },
                  isLoading: controller.isLoading.value,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
