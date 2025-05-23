import 'package:ezyhr_mobile_apps/module/attendance/list_attendance/list_attendance_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceDetailsPage extends GetView<ListAttendanceController> {
  const AttendanceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Attendance Details',
        isBack: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: RefreshIndicator(
        color: ColorConstant.primary,
        onRefresh: () => controller.getData(),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior()
              .copyWith(overscroll: true, scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                headerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          decoration: CommonWidget.defBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.textPrimaryWidget(
                'Checkin Date',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : CommonWidget.textPrimaryWidget(
                        controller.currentAttendance.value?.checkinDate == null
                            ? '-'
                            : DateFormat('EEEE, MMMM d, y, h:mm:ss a').format(
                                controller
                                    .currentAttendance.value!.checkinDate!),
                        color: ColorConstant.grey90,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Checkin Photo',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: Get.context!,
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: Get.height * 0.9,
                              child: WebViewApp(
                                initialUrl:
                                    "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/timesheet/facial/${controller.currentAttendance.value?.photoinTime}",
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
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Location In Time',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : CommonWidget.textPrimaryWidget(
                        controller.currentAttendance.value?.locationinTime ==
                                null
                            ? '-'
                            : controller
                                .currentAttendance.value!.locationinTime!,
                        color: ColorConstant.grey90,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
              ),
              const SizedBox(height: 24),
              Divider(),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Checkout Date',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : CommonWidget.textPrimaryWidget(
                        controller.currentAttendance.value?.checkoutDate == null
                            ? '-'
                            : DateFormat('EEEE, MMMM d, y, h:mm:ss a').format(
                                controller
                                    .currentAttendance.value!.checkoutDate!),
                        color: ColorConstant.grey90,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Checkout Photo',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : controller.currentAttendance.value?.photooutTime == null
                        ? Text("-")
                        : InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: Get.context!,
                                isScrollControlled: true,
                                builder: (context) => Container(
                                  height: Get.height * 0.9,
                                  child: WebViewApp(
                                    initialUrl:
                                        "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/timesheet/facial/${controller.currentAttendance.value?.photooutTime}",
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
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Location Out Time',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.currentAttendance.value == null
                    ? Shimmer.fromColors(
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
                      )
                    : CommonWidget.textPrimaryWidget(
                        controller.currentAttendance.value?.locationoutTime ==
                                null
                            ? '-'
                            : controller
                                .currentAttendance.value!.locationoutTime!,
                        color: ColorConstant.grey90,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        )
      ],
    );
  }
}
