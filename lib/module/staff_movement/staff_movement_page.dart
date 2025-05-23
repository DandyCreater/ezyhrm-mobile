import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_controller.dart';
import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StaffMovementView extends GetView<StaffMovementController> {
  const StaffMovementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Staff Movement List",
        isBack: false,
        bgColor: ColorConstant.greenBackground,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorConstant.primary,
          onRefresh: () async => controller.getData(),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _headerWidget(),
                  _body(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: CommonWidget.primaryButtonWidget(
          caption: "Add Movement",
          onTap: () {
            Get.toNamed(
              StaffMovementC.routeCreate,
            );
          },
          captionColor: Colors.white,
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      color: Colors.white,
      child: Column(
        children: [
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
                          controller.startDateVar.value == null
                              ? 'Select Date'
                              : "${controller.startDateStringQuery.value ?? ""} - ${controller.endDateStringQuery.value ?? ""}",
                          style: TextStyle(
                            color: controller.startDateVar.value == null
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
                                backgroundColor: Colors.white,
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
                                              DateRangePickerSelectionMode
                                                  .range,
                                          view: DateRangePickerView.month,
                                          showActionButtons: true,
                                          onSubmit: (dynamic value) {
                                            controller.onConfirm(value);

                                            Get.back();
                                          },
                                          backgroundColor: Colors.white,
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
                                              DateRangePickerMonthCellStyle(
                                            cellDecoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                            blackoutDateTextStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              decorationThickness: 3,
                                            ),
                                          ),
                                          selectableDayPredicate:
                                              (DateTime dateTime) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Obx(() => Column(
            children: _innerBody(),
          )),
    );
  }

  List<Widget> _innerBody() {
    if (controller.isLoading.value) {
      return List.generate(
          5,
          (index) => Container(
                height: 100,
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ));
    } else if (controller.staffMovementPageable.value != null) {
      if (controller.staffMovementPageable.value!.items!.isEmpty) {
        return [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: CommonWidget.textPrimaryWidget(
              "No data found",
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 400,
          )
        ];
      } else {
        return [
          ...controller.staffMovementPageable.value!.items!.map((e) {
            log("Staff Movement: $e");
            return _staffMovementCard(e);
          }).toList(),
          SizedBox(
            height: 400,
          )
        ];
      }
    } else {
      return [];
    }
  }

  Widget _staffMovementCard(StaffMovementResponse staffMovement) {
    return InkWell(
      onTap: () {
        controller.setCurrentStaffMovement(staffMovement);
        Get.toNamed(
          StaffMovementC.routeDetail,
          arguments: staffMovement,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      staffMovement.fullName ?? "-",
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "${DateFormat('HH:mm dd MMM yyyy').format(staffMovement.dateFrom ?? DateTime.now())} - ${DateFormat('HH:mm dd MMM yyyy').format(staffMovement.dateTo ?? DateTime.now())}",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonWidget.titleAndValue(
                      "Remarks", staffMovement.remarks ?? "-"),
                ),
                Spacer(),
                CommonWidget.titleAndValue(
                    "Status",
                    controller.getLeaveTypeByIdd(staffMovement.status ?? 0) ??
                        "-"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
