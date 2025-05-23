import 'package:ezyhr_mobile_apps/module/timesheet/timesheet_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class TimesheetListPage extends GetView<TimesheetController> {
  const TimesheetListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Timesheet',
        isBack: true,
        bgColor: Color(0xFFD8EAC8),
      ),
      body: _body(),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            if (controller.employeeTimesheet.value![0].status == 0) {
              if (controller.isLoading.value) {
                CommonWidget.showErrorNotif(
                    "Please wait for process to finish loading");
              } else {
                controller.doSubmit();
              }
            } else {
              CommonWidget.showErrorNotif(
                  "This timesheet has been submitted. You can't submit it anymore.");
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: controller.employeeTimesheet.value.isEmpty
                ? Colors.green[300]
                : controller.employeeTimesheet.value?[0].status != 0
                    ? Colors.grey[400]
                    : Colors.green[300],
          ),
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _body() {
    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: () => controller.getData(),
      child: Obx(
        () => CommonWidget.expandedScrollWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          overscroll: false,
          top: [
            headerWidgetV2(),
            filterWidget(),
            listTimesheet(),
          ],
        ),
      ),
    );
  }

  headerWidgetV2() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: SizeUtil.f(400),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD8EAC8),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: CommonWidget.defBoxDecoration(),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.textPrimaryWidget(
                "Your Summary Timesheet",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 4,
              ),
              CommonWidget.textPrimaryWidget(
                "In ${controller.selectedMonth.value} ${controller.selectedYear.value}",
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.textPrimaryWidget(
                            "Total Working Hours",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CommonWidget.imageWidget(
                                path:
                                    "assets/v2/reimbursement/total_working_hours.svg",
                                imgPathType: ImgPathType.asset,
                                width: 28,
                                height: 28,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              CommonWidget.textPrimaryWidget(
                                "${controller.monthlyWorkedHours.value.toStringAsFixed(2)}",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              )
                            ],
                          )
                        ]),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.textPrimaryWidget(
                            "Total Overtime Hours",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CommonWidget.imageWidget(
                                path:
                                    "assets/v2/reimbursement/total_ot_hours.svg",
                                imgPathType: ImgPathType.asset,
                                width: 28,
                                height: 28,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              CommonWidget.textPrimaryWidget(
                                "${controller.monthlyOtHours.value.toStringAsFixed(2)}",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              )
                            ],
                          )
                        ]),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  filterWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          CommonWidget.textPrimaryWidget(
            "Sort By",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
          Spacer(),
          Obx(
            () => FieldModalWidget.fieldWidget(
              placeholder: 'Select',
              value: CommonWidget.textPrimaryWidget(
                controller.selectedYear.value.toString(),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
              onTap: () {
                CommonUtil.unFocus(context: controller.context);
                FieldModalWidget.showModal<String, String>(
                  data: controller.yearList.value!,
                  caption: (e) => e,
                  onSelect: (e) {
                    controller.setYear(int.parse(e));
                  },
                  value: controller.selectedYear.value.toString(),
                  title: 'Year',
                );
              },
              isLoading: controller.yearList.value == null,
              isExpanded: false,
            ),
          ),
          SizedBox(width: SizeUtil.f(16)),
          Obx(
            () => Expanded(
              child: FieldModalWidget.fieldWidget(
                placeholder: 'Select',
                value: Expanded(
                  child: CommonWidget.textPrimaryWidget(
                    controller.selectedMonth.value,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  Icon(Icons.keyboard_arrow_down,
                      size: SizeUtil.f(20), color: ColorConstant.grey90),
                ],
                onTap: () {
                  CommonUtil.unFocus(context: controller.context);
                  FieldModalWidget.showModal<String, String>(
                    data: months,
                    caption: (e) => e,
                    onSelect: (e) {
                      controller.setMonth(e);
                    },
                    value: controller.selectedMonth.value,
                    title: 'Year',
                  );
                },
                isExpanded: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  headerWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 27),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/vector.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFD8EAC8),
      ),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: CommonWidget.textPrimaryWidget(
                      controller.selectedYear.value.toString(),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorConstant.grey90,
                    ),
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      FieldModalWidget.showModal<String, String>(
                        data: controller.yearList.value!,
                        caption: (e) => e,
                        onSelect: (e) {
                          controller.setYear(int.parse(e));
                        },
                        value: controller.selectedYear.value.toString(),
                        title: 'Year',
                      );
                    },
                    isLoading: controller.yearList.value == null,
                    isExpanded: false,
                  ),
                ),
                SizedBox(width: SizeUtil.f(8)),
                Obx(
                  () => Expanded(
                    child: FieldModalWidget.fieldWidget(
                      placeholder: 'Select',
                      value: Expanded(
                        child: CommonWidget.textPrimaryWidget(
                          controller.selectedMonth.value,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                      ),
                      actions: [
                        Icon(Icons.keyboard_arrow_down,
                            size: SizeUtil.f(20), color: ColorConstant.grey90),
                      ],
                      onTap: () {
                        CommonUtil.unFocus(context: controller.context);
                        FieldModalWidget.showModal<String, String>(
                          data: months,
                          caption: (e) => e,
                          onSelect: (e) {
                            controller.setMonth(e);
                          },
                          value: controller.selectedMonth.value,
                          title: 'Year',
                        );
                      },
                      isExpanded: false,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.f(16)),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  quotaTag(
                      "Total Working Hours",
                      "${controller.monthlyWorkedHours.value.toStringAsFixed(2)}",
                      controller.isLoading.value),
                  CommonWidget.imageWidget(
                    path: 'assets/svgs/ic_line.svg',
                    imgPathType: ImgPathType.asset,
                    height: 50,
                    width: 42,
                  ),
                  quotaTag(
                      " Total Overtime Hours",
                      "${controller.monthlyOtHours.value.toStringAsFixed(2)}",
                      controller.isLoading.value),
                ],
              ),
            ),
            SizedBox(height: SizeUtil.f(16)),
          ],
        ),
      ),
    );
  }

  Widget listTimesheet() {
    return controller.groupDays.value == null || controller.isLoading.value
        ? Column(
            children: [1, 2, 3, 4]
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.all(8),
                    width: double.infinity,
                    height: 100,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 63,
                        height: 18,
                        decoration: ShapeDecoration(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Column(
            children: [
              ...controller.groupDays.value!
                  .asMap()
                  .map(
                    (i, e) => MapEntry(
                      i,
                      e.startDate.compareTo(DateTime.now()) > 0
                          ? Container()
                          : InkWell(
                              onTap: () {
                                controller.setWeek(i);
                              },
                              child: recentRequestWidgetV2(
                                "${e.listDatetime.length.toString()} days",
                                '${DateFormat('dd MMM yyyy').format(e.startDate)}',
                                '${DateFormat('dd MMM yyyy').format(e.endDate)}',
                                "${e.hoursWorked.toStringAsFixed(2)}",
                                "${e.otHours.toStringAsFixed(2)}",
                              ),
                            ),
                    ),
                  )
                  .values
                  .toList(),
              SizedBox(height: SizeUtil.f(24)),
            ],
          );
  }

  Widget submitButton() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CommonWidget.primaryButtonWidget(
              caption: 'Submit',
              prefixIcon: Icons.add,
              isLoading: controller.isLoading.value,
              onTap: () {
                if (controller.employeeTimesheet.value![0].status == 0) {
                  if (controller.isLoading.value) {
                    CommonWidget.showErrorNotif(
                        "Please wait for process to finish loading");
                  } else {
                    controller.doSubmit();
                  }
                } else {
                  CommonWidget.showErrorNotif(
                      "This timesheet has been submitted. You can't submit it anymore.");
                }
              },
              bgColor: controller.employeeTimesheet.value.isEmpty
                  ? Colors.green[300]
                  : controller.employeeTimesheet.value?[0].status != 0
                      ? Colors.grey[400]
                      : Colors.green[300],
            ),
          ),
          SizedBox(width: SizeUtil.f(16)),
          Expanded(
            child: CommonWidget.primaryButtonWidget(
              caption: 'Save',
              prefixIcon: Icons.save_as_outlined,
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
          ),
        ],
      ),
    );
  }

  Widget recentRequestWidgetV2(
    String? days,
    String? startDate,
    String? endDate,
    String? workedHours,
    String? otHours,
  ) {
    return Container(
      decoration: CommonWidget.defBoxDecoration(
        blurRadius: 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      "Date",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonWidget.textPrimaryWidget(
                          startDate ?? '',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        endDate == null
                            ? Container()
                            : CommonWidget.textPrimaryWidget(
                                ' to ',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xFF545454),
                              ),
                        SizedBox(
                          width: 8,
                        ),
                        endDate == null
                            ? Container()
                            : CommonWidget.textPrimaryWidget(
                                endDate ?? '',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: SizeUtil.f(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.textPrimaryWidget(
                          "Total Working Hours",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF545454),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        CommonWidget.textPrimaryWidget(
                          workedHours ?? '',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF0689FF),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.textPrimaryWidget(
                          "Total Overtime Hours",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF545454),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        CommonWidget.textPrimaryWidget(
                          otHours ?? '',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF0689FF),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: SizeUtil.f(24)),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: SizeUtil.f(20),
            color: ColorConstant.grey90,
          ),
        ],
      ),
    );
  }

  Widget recentRequestWidget(
    String? days,
    String? startDate,
    String? endDate,
    String? workedHours,
    String? otHours,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: CommonWidget.defBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      startDate ?? '',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    endDate == null
                        ? Container()
                        : CommonWidget.textPrimaryWidget(
                            ' - ',
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                    endDate == null
                        ? Container()
                        : CommonWidget.textPrimaryWidget(
                            endDate ?? '',
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                  ],
                ),
                SizedBox(height: SizeUtil.f(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quotaTag(
                      "Total Working Hours",
                      workedHours ?? "",
                      controller.isLoading.value,
                    ),
                    CommonWidget.imageWidget(
                      path: 'assets/svgs/ic_line.svg',
                      imgPathType: ImgPathType.asset,
                    ),
                    quotaTag(
                      "Total Overtime Hours",
                      otHours ?? "",
                      controller.isLoading.value,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: SizeUtil.f(24)),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: SizeUtil.f(20),
            color: ColorConstant.grey90,
          ),
        ],
      ),
    );
  }

  quotaTag(String title, String value, bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF545454),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            : Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
      ],
    );
  }
}

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
