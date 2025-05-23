import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceApprovalDetailScreen
    extends GetView<AttendanceApprovalController> {
  const AttendanceApprovalDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        "Attendance Details",
      ),
      backgroundColor: ColorConstant.backgroundColor,
      body: Obx(() => Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.fieldAndValue(
                  "Employee Name",
                  controller.currentAttendanceApprovalDto.value?.employeeList
                          ?.employeename ??
                      "-",
                  null,
                  controller.isLoading.value,
                  isDivider: false,
                ),
                CommonWidget.fieldAndValue(
                  "Checkin Date",
                  controller.currentAttendanceApprovalDto.value
                              ?.attendanceResponse!.checkinDate ==
                          null
                      ? "-"
                      : DateFormat("HH:mm, EEEE, dd MMM yyyy").format(
                          controller.currentAttendanceApprovalDto.value!
                              .attendanceResponse!.checkinDate!,
                        ),
                  null,
                  controller.isLoading.value,
                  isDivider: false,
                ),
                CommonWidget.fieldAndValue(
                  "Checkin Location",
                  controller.currentAttendanceApprovalDto.value
                          ?.attendanceResponse!.locationinTime ??
                      "-",
                  null,
                  controller.isLoading.value,
                  isDivider: false,
                ),
                CommonWidget.fieldAndValue(
                  "Checkin Photo",
                  "",
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: Get.height * 0.9,
                          child: WebViewApp(
                            initialUrl:
                                "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/timesheet/facial/${controller.currentAttendanceApprovalDto.value?.attendanceResponse?.photoinTime ?? "-"}",
                            title: 'Photo',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.file_present,
                          size: SizeUtil.f(28),
                        ),
                        SizedBox(width: SizeUtil.f(4)),
                        CommonWidget.textPrimaryWidget(
                          'See file',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: ColorConstant.green90,
                        ),
                      ],
                    ),
                  ),
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Checkout Date",
                  controller.currentAttendanceApprovalDto.value
                              ?.attendanceResponse?.checkoutDate ==
                          null
                      ? "-"
                      : DateFormat("HH:mm, EEEE, dd MMM yyyy").format(
                          controller.currentAttendanceApprovalDto.value!
                              .attendanceResponse!.checkoutDate!,
                        ),
                  null,
                  controller.isLoading.value,
                  isDivider: false,
                ),
                CommonWidget.fieldAndValue(
                  "Checkout Location",
                  controller.currentAttendanceApprovalDto.value
                          ?.attendanceResponse?.locationoutTime ??
                      "-",
                  null,
                  controller.isLoading.value,
                  isDivider: false,
                ),
                CommonWidget.fieldAndValue(
                  "Checkout Photo",
                  "",
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: Get.height * 0.9,
                          child: WebViewApp(
                            initialUrl:
                                "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/timesheet/facial/${controller.currentAttendanceApprovalDto.value?.attendanceResponse?.photooutTime ?? "-"}",
                            title: 'Photo',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.file_present,
                          size: SizeUtil.f(28),
                        ),
                        SizedBox(width: SizeUtil.f(4)),
                        CommonWidget.textPrimaryWidget(
                          'See file',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: ColorConstant.green90,
                        ),
                      ],
                    ),
                  ),
                  controller.isLoading.value,
                  isDivider: false,
                )
              ],
            ),
          )),
    );
  }
}
