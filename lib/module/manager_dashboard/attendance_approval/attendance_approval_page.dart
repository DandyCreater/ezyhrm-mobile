import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceApprovalPage extends GetView<AttendanceApprovalController> {
  const AttendanceApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Today's Attendance",
        isBack: true,
        bgColor: ColorConstant.greenBackground,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorConstant.primary,
          onRefresh: () => controller.getData(),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    _body(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          controller.attendanceApprovalDto.value == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.greenBackground,
                  ),
                )
              : controller.attendanceApprovalDto.value!.isEmpty
                  ? Container(
                      height: 100,
                      child: Center(
                        child: CommonWidget.textPrimaryWidget(
                          "No attendance request",
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.attendanceApprovalDto.value?.length,
                      itemBuilder: (context, index) {
                        return attendanceCard(
                            controller.attendanceApprovalDto.value![index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 6,
            ),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                indicatorColor: ColorConstant.green90,
                tabs: [
                  Tab(
                    child: CommonWidget.textPrimaryWidget(
                      "Waiting Approval",
                      color: Color(0xFF8BBF5A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Tab(
                    child: CommonWidget.textPrimaryWidget(
                      "Approved",
                      color: Color(0xFF8BBF5A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  "Sort By",
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(),
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
                          data: controller.months.value,
                          caption: (e) => e,
                          onSelect: (e) {
                            controller.setMonth(e);
                          },
                          value: controller.selectedMonth.value,
                          title: 'Month',
                        );
                      },
                      isExpanded: false,
                    ),
                  ),
                ),
                SizedBox(width: SizeUtil.f(16)),
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget attendanceList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                "Approval Request",
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              InkWell(
                child: CommonWidget.textPrimaryWidget(
                  "View All",
                  color: Color(0xFF784DFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Get.toNamed("/attendance-approval");
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          controller.attendanceApprovalDto.value == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.greenBackground,
                  ),
                )
              : controller.attendanceApprovalDto.value!.isEmpty
                  ? Center(
                      child: CommonWidget.textPrimaryWidget(
                        "No attendance request",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.attendanceApprovalDto.value?.length,
                      itemBuilder: (context, index) {
                        return attendanceCard(
                            controller.attendanceApprovalDto.value![index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget attendanceCard(AttendanceApprovalDto data) {
    return InkWell(
        onTap: () {
          controller.setCurrentAttendanceApprovalDto(data);
          Get.toNamed("/attendance-approval-detail", arguments: {
            "attendanceApprovalDto": data,
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      data.employeeList?.employeename ?? "-",
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "In Time",
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      data.attendanceResponse?.checkinDate == null
                          ? "-"
                          : DateFormat('hh:mm a').format(
                              data.attendanceResponse?.checkinDate ??
                                  DateTime.now()),
                      color: Color(0xFF784DFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Color(0xFF545454),
                          size: 16,
                        ),
                        CommonWidget.textPrimaryWidget(
                          "${(data.attendanceResponse?.locationinTime ?? "-").substring(0, 20)}...",
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: controller.getBackgroundStatusColor(
                            data.attendanceResponse?.status ?? 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.getStatus(
                                data.attendanceResponse?.status ?? 0),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: controller.getStatusColor(
                                  data.attendanceResponse?.status ?? 0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "Out Time",
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      data.attendanceResponse?.checkoutDate == null
                          ? "-"
                          : DateFormat('hh:mm a').format(
                              data.attendanceResponse?.checkoutDate ??
                                  DateTime.now()),
                      color: Color(0xFFFF2C20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF545454),
                          size: 16,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ));
  }
}
