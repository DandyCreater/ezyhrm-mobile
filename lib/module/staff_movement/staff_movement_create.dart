import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StaffMovementCreareView extends GetView<StaffMovementController> {
  const StaffMovementCreareView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Staff Movement List",
        isBack: false,
        bgColor: ColorConstant.greenBackground,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Obx(() => _body(context)),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.fieldName(
            "Start Date",
          ),
          SizedBox(
            height: 8,
          ),
          FieldModalWidget.fieldWidget(
            placeholder: 'Select',
            value: CommonWidget.textPrimaryWidget(
              controller.startDateVar.value == null
                  ? "Select incurred date"
                  : DateFormat.yMMMEd().format(
                      controller.startDateVar.value ?? DateTime.now(),
                    ),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: controller.startDateController.value == null
                  ? Color(0xFFAFAFAF)
                  : Color(0xFF000000),
            ),
            actions: [
              Icon(Icons.calendar_month,
                  size: SizeUtil.f(20), color: ColorConstant.grey90),
            ],
            onTap: () {
              showDialog(
                context: Get.context!,
                builder: (ctx) {
                  var paddingHz = 36.0;
                  var el = Get.width / Get.height;
                  if (el > 1.3) {
                    paddingHz = Get.width * .3;
                  }
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(
                        horizontal: paddingHz, vertical: 48),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CommonWidget.textPrimaryWidget(
                                  'Select Date',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: ColorConstant.grey90,
                                )),
                                InkWell(
                                    onTap: Get.back,
                                    child: Icon(Icons.close,
                                        size: SizeUtil.f(20))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SfDateRangePicker(
                              maxDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 1,
                              ),
                              onSelectionChanged:
                                  controller.onStartDateTimeChange,
                              selectionColor: Colors.green,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              view: DateRangePickerView.month,
                              showActionButtons: true,
                              onSubmit: (dynamic value) {
                                if (value == null) {
                                  value = DateTime.now();
                                }
                                controller.onConfirmEndDateTimeChange(value);

                                Get.back();
                              },
                              rangeSelectionColor:
                                  Color(0xFF8BBF5A).withOpacity(0.3),
                              todayHighlightColor: Color(0xFF8BBF5A),
                              endRangeSelectionColor: Color(0xFF8BBF5A),
                              startRangeSelectionColor: Color(0xFF8BBF5A),
                              confirmText: "Confirm",
                              cancelText: "Cancel",
                              onCancel: () {
                                Get.back();
                              },
                              initialSelectedDate:
                                  controller.startDateVar.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            isExpanded: true,
          ),
          SizedBox(
            height: 16,
          ),
          CommonWidget.fieldName(
            "Start Time",
          ),
          SizedBox(
            height: 8,
          ),
          FieldModalWidget.fieldWidget(
              placeholder: 'Select',
              value: CommonWidget.textPrimaryWidget(
                controller.startTimeVar.value == null
                    ? "Select incurred date"
                    : "${controller.startTimeVar.value?.format(context) ?? 0}",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: controller.startTimeController.value == null
                    ? Color(0xFFAFAFAF)
                    : Color(0xFF000000),
              ),
              actions: [
                Icon(
                  Icons.punch_clock,
                  size: SizeUtil.f(20),
                  color: ColorConstant.grey90,
                ),
              ],
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: controller.endTimeVar.value ?? TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.cyan,
                        buttonTheme: ButtonTheme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            secondary: Colors.green,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != controller.endTimeVar.value) {
                  controller.startTimeVar.value = picked;
                }
              }),
          SizedBox(
            height: 16,
          ),
          CommonWidget.fieldName(
            "End Date",
          ),
          SizedBox(
            height: 8,
          ),
          FieldModalWidget.fieldWidget(
            placeholder: 'Select',
            value: CommonWidget.textPrimaryWidget(
              controller.endDateVar.value == null
                  ? "Select end date"
                  : DateFormat.yMMMEd().format(
                      controller.endDateVar.value ?? DateTime.now(),
                    ),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: controller.endDateController.value == null
                  ? Color(0xFFAFAFAF)
                  : Color(0xFF000000),
            ),
            actions: [
              Icon(Icons.calendar_month,
                  size: SizeUtil.f(20), color: ColorConstant.grey90),
            ],
            onTap: () {
              showDialog(
                context: Get.context!,
                builder: (ctx) {
                  var paddingHz = 36.0;
                  var el = Get.width / Get.height;
                  if (el > 1.3) {
                    paddingHz = Get.width * .3;
                  }
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(
                        horizontal: paddingHz, vertical: 48),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CommonWidget.textPrimaryWidget(
                                  'Select Date',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: ColorConstant.grey90,
                                )),
                                InkWell(
                                    onTap: Get.back,
                                    child: Icon(Icons.close,
                                        size: SizeUtil.f(20))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SfDateRangePicker(
                              maxDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 1,
                              ),
                              onSelectionChanged:
                                  controller.onEndDateTimeChange,
                              selectionColor: Colors.green,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              view: DateRangePickerView.month,
                              showActionButtons: true,
                              onSubmit: (dynamic value) {
                                if (value == null) {
                                  value = DateTime.now();
                                }
                                controller.onConfirmEndDateTimeChange(value);

                                Get.back();
                              },
                              rangeSelectionColor:
                                  Color(0xFF8BBF5A).withOpacity(0.3),
                              todayHighlightColor: Color(0xFF8BBF5A),
                              endRangeSelectionColor: Color(0xFF8BBF5A),
                              startRangeSelectionColor: Color(0xFF8BBF5A),
                              confirmText: "Confirm",
                              cancelText: "Cancel",
                              onCancel: () {
                                Get.back();
                              },
                              initialSelectedDate: controller.endDateVar.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            isExpanded: true,
          ),
          SizedBox(
            height: 16,
          ),
          CommonWidget.fieldName(
            "End Time",
          ),
          SizedBox(
            height: 8,
          ),
          FieldModalWidget.fieldWidget(
              placeholder: 'Select',
              value: CommonWidget.textPrimaryWidget(
                controller.endTimeVar.value == null
                    ? "Select end time"
                    : "${controller.endTimeVar.value?.format(context) ?? 0}",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: controller.endTimeController.value == null
                    ? Color(0xFFAFAFAF)
                    : Color(0xFF000000),
              ),
              actions: [
                Icon(
                  Icons.punch_clock,
                  size: SizeUtil.f(20),
                  color: ColorConstant.grey90,
                ),
              ],
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: controller.endTimeVar.value ?? TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.cyan,
                        buttonTheme: ButtonTheme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            secondary: Colors.green,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != controller.endTimeVar.value) {
                  controller.endTimeVar.value = picked;
                }
              }),
          SizedBox(
            height: 16,
          ),
          CommonWidget.fieldName(
            "Remarks",
          ),
          SizedBox(
            height: 8,
          ),
          CommonWidget.textFieldWidget(
            placeholder: 'Input remarks here',
            controller: controller.remarksController,
            maxLines: 3,
          ),
          SizedBox(
            height: 40,
          ),
          CommonWidget.primaryButtonWidget(
            caption: "Submit",
            isLoading: controller.isLoading.value,
            onTap: () {
              controller.onSubmit();
            },
          ),
        ],
      ),
    );
  }
}
