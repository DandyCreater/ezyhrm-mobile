import 'package:ezyhr_mobile_apps/module/leave_request/response/table_leave_balance_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../shared/constant/color_constant.dart';
import '../../widget/button.dart';
import '../../widget/common_widget.dart';
import 'request_form_controller.dart';

class LRequestFormScreen extends GetView<LRequestFormController> {
  const LRequestFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Request Form',
        isBack: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return CommonWidget.expandedScrollWidget(
      physics: const BouncingScrollPhysics(),
      top: [
        leaveRequestWidget(context),
      ],
    );
  }

  leaveRequestWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CommonWidget.textPrimaryWidget(
              'Type of Leave',
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: ColorConstant.grey90,
            ),
            SizedBox(width: SizeUtil.f(2)),
            CommonWidget.textPrimaryWidget(
              '*',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorConstant.red60,
            ),
          ],
        ),
        SizedBox(height: SizeUtil.f(8)),
        Obx(
          () => FieldModalWidget.fieldWidget(
            placeholder: 'Select',
            value: Text(
              controller.selectedTypeOfLeave.value?.name ?? "",
              style: TextStyle(
                color: controller.selectedTypeOfLeave.value == null
                    ? ColorConstant.grey50
                    : ColorConstant.black60,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              Icon(Icons.keyboard_arrow_down,
                  size: SizeUtil.f(20), color: ColorConstant.grey90),
            ],
            onTap: () {
              CommonUtil.unFocus(context: controller.context);
              FieldModalWidget.showModal<TableLeaveBalanceResponse, String>(
                data: controller.tableLeaveBalance.value!
                    .where((element) => element.leaveBalance! > 0)
                    .toList(),
                caption: (e) => "${e.name} Balance : ${e.leaveBalance}",
                onSelect: (e) {
                  controller.selectedTypeOfLeave.value = e;
                },
                value: controller.selectedTypeOfLeave.value,
                title: 'Select Type of Leave',
              );
            },
          ),
        ),
        SizedBox(height: SizeUtil.f(16)),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                          'Select Date',
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                        SizedBox(width: SizeUtil.f(2)),
                        CommonWidget.textPrimaryWidget(
                          '*',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorConstant.red60,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeUtil.f(8)),
                    FieldModalWidget.fieldWidget(
                      placeholder: 'Select',
                      value: Text(
                        controller.startDate.value == null
                            ? 'Select Date'
                            : "${controller.startDate.value == null ? "" : DateFormat.yMMMEd().format(controller.startDate.value!)} ${controller.endDate.value == null ? "" : " - ${DateFormat.yMMMEd().format(controller.endDate.value!)}"}",
                        style: TextStyle(
                          color: controller.startDate.value == null
                              ? ColorConstant.grey50
                              : ColorConstant.black60,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      actions: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFFAFAFAF),
                          size: 16,
                        )
                      ],
                      isExpanded: true,
                      onTap: () {
                        CommonUtil.unFocus(context: controller.context);
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: CommonWidget
                                                  .textPrimaryWidget(
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
                                        controller: controller
                                            .dateRangePickerController,
                                        onSelectionChanged:
                                            controller.onDateSelectionChanged,
                                        selectionColor: Colors.green,
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        view: DateRangePickerView.month,
                                        showActionButtons: true,
                                        onSubmit: (dynamic value) {
                                          controller.onConfirm(value);

                                          Get.back();
                                        },
                                        rangeSelectionColor:
                                            const Color(0xFF8BBF5A)
                                                .withOpacity(0.3),
                                        todayHighlightColor:
                                            const Color(0xFF8BBF5A),
                                        endRangeSelectionColor:
                                            const Color(0xFF8BBF5A),
                                        startRangeSelectionColor:
                                            const Color(0xFF8BBF5A),
                                        confirmText: "Confirm",
                                        cancelText: "Cancel",
                                        minDate: DateTime.now().subtract(
                                          const Duration(days: 365),
                                        ),
                                        monthCellStyle:
                                            const DateRangePickerMonthCellStyle(
                                          blackoutDateTextStyle: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                            decorationThickness: 3,
                                          ),
                                        ),
                                        monthViewSettings:
                                            DateRangePickerMonthViewSettings(
                                                blackoutDates: [
                                              ...controller.blacklistDate.value!
                                            ]),
                                        selectableDayPredicate:
                                            (DateTime dateTime) {
                                          if (controller.blacklistDate.value!
                                              .contains(dateTime)) {
                                            return false;
                                          }
                                          return true;
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: SizeUtil.f(16)),
              Column(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Duration',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: ColorConstant.grey90,
                  ),
                  SizedBox(height: SizeUtil.f(8)),
                  FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Text(
                      "${controller.duration.value}",
                      style: TextStyle(
                        color: controller.startDate.value == null ||
                                controller.duration.value == 0.0
                            ? ColorConstant.grey50
                            : ColorConstant.black60,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    isExpanded: false,
                  )
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => controller.startDate.value == null
              ? const SizedBox()
              : SizedBox(
                  height: SizeUtil.f(16),
                ),
        ),
        Obx(
          () => controller.startDate.value == null
              ? const SizedBox()
              : Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      controller.startDate.value == null
                          ? ""
                          : "${DateFormat('EEE, dd MMM').format(controller.startDate.value!)} Whole / Half Day",
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: ColorConstant.grey90,
                    ),
                    CommonWidget.textPrimaryWidget(
                      '*',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorConstant.red60,
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => controller.startDate.value == null
              ? const SizedBox()
              : FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: Text(
                    controller.startDateTimeText.value,
                    style: TextStyle(
                      color: controller.startDateTimeText.value == 'Select'
                          ? ColorConstant.grey50
                          : ColorConstant.black60,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: ["Whole Day", "AM", "PM"],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setStartDateTime(e);
                      },
                      value: controller.startDateTimeText.value,
                      title: 'Start Date Leave Type',
                    );
                  },
                ),
        ),
        Obx(
          () => controller.startDate.value == null
              ? const SizedBox()
              : SizedBox(
                  height: SizeUtil.f(16),
                ),
        ),
        Obx(
          () => controller.endDate.value == null
              ? const SizedBox()
              : Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      controller.endDate.value == null
                          ? ""
                          : "${DateFormat('EEE, dd MMM').format(controller.endDate.value!)} Whole / Half Day",
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: ColorConstant.grey90,
                    ),
                    CommonWidget.textPrimaryWidget(
                      '*',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorConstant.red60,
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => controller.endDate.value == null
              ? const SizedBox()
              : FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: Text(
                    controller.endDateTimeText.value,
                    style: TextStyle(
                      color: controller.endDateTimeText.value == 'Select'
                          ? ColorConstant.grey50
                          : ColorConstant.black60,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: ["Whole Day", "AM", "PM"],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setEndDateTime(e);
                      },
                      value: controller.endDateTimeText.value,
                      title: 'End Date Leave Type',
                    );
                  },
                ),
        ),
        Obx(
          () => controller.endDate.value == null
              ? const SizedBox()
              : SizedBox(height: SizeUtil.f(16)),
        ),
        Row(
          children: [
            CommonWidget.textPrimaryWidget(
              'Remark',
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: ColorConstant.grey90,
            ),
          ],
        ),
        const SizedBox(height: 8),
        CommonWidget.textFieldWidget(
          controller: controller.remarkController,
          placeholder: 'Remarks',
          maxLines: 3,
          maxLength: 200,
          validator: [],
          isDense: true,
          textStyle: CommonWidget.textStyleRoboto(
            fontWeight: FontWeight.w400,
            fontSize: SizeUtil.f(12),
            color: ColorConstant.black60,
          ),
          placeholderStyle: CommonWidget.textStyleRoboto(
            fontWeight: FontWeight.w400,
            fontSize: SizeUtil.f(12),
            color: ColorConstant.grey50,
          ),
        ),
        SizedBox(height: SizeUtil.f(16)),
        Obx(
          () => Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'File Attachment',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              if (controller.selectedTypeOfLeave.value?.name == "Medical" ||
                  controller.selectedTypeOfLeave.value?.name ==
                      "Hospitalization")
                CommonWidget.textPrimaryWidget(
                  '*',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: ColorConstant.red60,
                ),
            ],
          ),
        ),
        SizedBox(height: SizeUtil.f(8)),
        Row(
          children: [
            CommonWidget.textPrimaryWidget(
              'Please upload your supporting document',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorConstant.grey50,
            ),
          ],
        ),
        SizedBox(height: SizeUtil.f(8)),
        GestureDetector(
          onTap: () => controller.chooseImage(),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: Get.width * 0.85,
                decoration: CommonWidget.defBoxDecoration(),
                child: Column(
                  children: [
                    Obx(
                      () {
                        if (controller.imgType.value == ImgType.file) {
                          return CommonWidget.imageWidget(
                            path: controller.imgPath.value,
                            imgPathType: ImgPathType.file,
                            fit: BoxFit.cover,
                          );
                        } else if (controller.imgType.value ==
                            ImgType.network) {
                          return ClipOval(
                            child: CommonWidget.imageWidget(
                              path: controller.imgPath.value,
                              imgPathType: ImgPathType.network,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              withBaseEndpoint: false,
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(height: SizeUtil.f(16)),
                              CommonWidget.imageWidget(
                                imgPathType: ImgPathType.asset,
                                path: 'assets/svgs/ic_upload_cloud.svg',
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(height: SizeUtil.f(16)),
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Browse',
                                      style: TextStyle(
                                        color: Color(0xFF8BBF5A),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0.11,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' to choose a file',
                                      style: TextStyle(
                                        color: Color(0xFFAFAFAF),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0.11,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: SizeUtil.f(16)),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: SizeUtil.f(16)),
        Center(
          child: Column(
            children: [
              CommonWidget.textPrimaryWidget(
                'Acceptable file types are pictures.',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: ColorConstant.grey50,
              ),
              CommonWidget.textPrimaryWidget(
                " Max file size is 15 MB.",
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: ColorConstant.grey50,
              )
            ],
          ),
        ),
        SizedBox(height: SizeUtil.f(30)),
        Obx(
          () => CustomFilledButton(
            key: const Key('submit_request'),
            width: double.infinity,
            title: 'Submit Request',
            isLoading: controller.isLoading.value,
            onPressed: () {
              if (controller.isLoading.value) {
                CommonWidget.showErrorNotif(
                    "Please wait for process to finish loading");
              } else {
                controller.doSubmit();
              }
            },
          ),
        ),
      ]),
    );
  }
}
