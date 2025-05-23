import 'package:ezyhr_mobile_apps/module/attendance/response/attendance_data.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'list_attendance_controller.dart';

class ListAttendanceScreen extends GetView<ListAttendanceController> {
  const ListAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Employee Attendance List',
        bgColor: Color(0xFFD8EAC8),
        isBack: true,
      ),
      body: _body(),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/attendance');
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Add Attendance',
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
    return Column(
      children: [
        filterWidget(),
        leaveAttendanceWidget(),
      ],
    );
  }

  Widget headerWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF8BBF5A),
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 21,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF739F4B),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.setApproved();
                  controller.getAttendanceApproved();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 12,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isApproved.value ? Colors.white : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      'Approve',
                      style: TextStyle(
                        color: controller.isApproved.value
                            ? Color(0xFF8BBF5A)
                            : Color(0xFF8BBF5A),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.setRequest();
                  controller.getNonApprovedAttendance();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 12,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isApproved.value ? null : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      'Request',
                      style: TextStyle(
                        color: controller.isApproved.value
                            ? Color(0xFF8BBF5A)
                            : Color(0xFF8BBF5A),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  leaveAttendanceWidget() {
    return Expanded(
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
          child: ScrollConfiguration(
            behavior:
                ScrollBehavior().copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Column(
                        children: getAttendanceList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getWorkingHours(DateTime? checkinDate, DateTime? checkoutDate) {
    if (checkinDate == null || checkoutDate == null) {
      return "";
    }
    final diff = checkoutDate.difference(checkinDate);
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);
    return "${hours}h ${minutes}m ${seconds}s";
  }

  String getStatus(int status) {
    switch (status) {
      case 0:
        return "New";
      case 1:
        return "Init";
      case 2:
        return "Checkin Only";
      case 3:
        return "Complete";
      default:
        return "New";
    }
  }

  MaterialColor getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color getBackgroundStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue[50]!;
      case 1:
        return Colors.grey[50]!;
      case 2:
        return Colors.yellow[50]!;
      case 3:
        return Colors.green[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  List<Widget> getAttendanceList() {
    if (controller.isLoading.value) {
      return [1, 2, 3, 4]
          .map((e) => Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 70,
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
              ))
          .toList();
    } else if (controller.attendance.value == null) {
      return [
        SizedBox(height: SizeUtil.f(32)),
        SizedBox(
          height: SizeUtil.f(16),
          child: Center(
            child: CommonWidget.textPrimaryWidget(
              'No Data Available',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ColorConstant.grey90,
            ),
          ),
        ),
        SizedBox(height: SizeUtil.f(500)),
      ];
    } else if (controller.attendance.value!.data!.length > 0) {
      List<Widget> attendanceList = [];
      for (var i = 0; i < controller.attendance.value!.data!.length; i++) {
        final data = controller.attendance.value!.data![i];
        print('data: ${data.toJson()}');
        String? name = "Emerson";
        String? title = "IT Supervisor";
        String? grade = "M";

        String? date = data.checkinDate == null
            ? ""
            : DateFormat('dd MMM yyyy').format(data.checkinDate!);
        String? inTime = data.checkinDate == null
            ? ""
            : DateFormat('HH.mm').format(data.checkinDate!);
        String? outTime = data.checkoutDate == null
            ? ""
            : DateFormat('HH.mm').format(data.checkoutDate!);
        String status = getStatus(data.status!);

        String? profile = "assets/images/icon_profile.png";
        String? totalTimeIn = data.checkinDate == null
            ? ""
            : getWorkingHours(data.checkinDate, data.checkoutDate);
        String? totalTimeOut = "8h 0m 0s";

        Duration? duration = data.checkinDate == null ||
                data.checkoutDate == null
            ? Duration.zero
            : data.checkoutDate!.difference(data.checkinDate!) ?? Duration.zero;
        int workingHours = 8 * 60 * 60;

        double percentage = data.checkinDate == null
            ? 0.0
            : (duration.inSeconds / workingHours);
        MaterialColor statusColor = getStatusColor(data.status!);
        Color? backgroundStatusColor = getBackgroundStatusColor(data.status!);
        attendanceList.add(
          attendanceCard(
            name,
            title,
            grade,
            date,
            inTime,
            outTime,
            status,
            profile,
            totalTimeIn,
            totalTimeOut,
            statusColor ?? Colors.grey,
            backgroundStatusColor,
            percentage,
            data.locationinTime,
            data,
          ),
        );

        attendanceList.add(
          SizedBox(
            height: SizeUtil.f(12),
          ),
        );
      }
      attendanceList = attendanceList.reversed.toList();
      attendanceList.add(
        SizedBox(
          height: SizeUtil.f(100),
        ),
      );
      return attendanceList;
    } else {
      return [
        SizedBox(height: SizeUtil.f(32)),
        SizedBox(
          height: SizeUtil.f(16),
          child: Center(
            child: CommonWidget.textPrimaryWidget(
              'No Data Available',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ColorConstant.grey90,
            ),
          ),
        ),
        SizedBox(height: SizeUtil.f(700)),
      ];
    }
  }

  attendanceCard(
    String name,
    String title,
    String grade,
    String date,
    String inTime,
    String outTime,
    String status,
    String profile,
    String? totalTimeIn,
    String? totalTimeOut,
    MaterialColor statusColor,
    Color backgroundStatusColor,
    double percentage,
    String? location,
    AttendanceData data,
  ) {
    return InkWell(
      onTap: () {
        controller.setCurrentAttendance(data);
        RouteUtil.to("/attendance-details");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: CommonWidget.defBoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            date,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: backgroundStatusColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: CommonWidget.textPrimaryWidget(
                              status,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'In Time',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          CommonWidget.textPrimaryWidget(
                            inTime ?? "-",
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Out Time',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          CommonWidget.textPrimaryWidget(
                            outTime ?? "-",
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorConstant.grey90,
            ),
          ],
        ),
      ),
    );
  }

  filterWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: SizeUtil.f(80),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD8EAC8),
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 6),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
                                size: SizeUtil.f(20),
                                color: ColorConstant.grey90),
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
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void showDetail() {
    Get.bottomSheet(Container(
      height: SizeUtil.f(Get.height * .40),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        color: ColorConstant.grey0,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Attendance Detail',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorConstant.grey70,
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: const Icon(Icons.close),
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
