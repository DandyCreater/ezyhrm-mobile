import 'package:ezyhr_mobile_apps/module/leave_request/list_leave_request/list_leave_request_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveRequestDetailsPage extends GetView<LeaveRequestController> {
  const LeaveRequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Leave Request Details',
        bgColor: Color(0xFFD8EAC8),
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
                SizedBox(height: SizeUtil.f(24)),
                if (controller.currentLeave.value?.status == 0 ||
                    controller.currentLeave.value?.status == 1 ||
                    controller.currentLeave.value?.status == 2)
                  CustomFilledButton(
                    width: Get.width - 48,
                    title: 'Cancel Request',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.cancelLeave();
                    },
                    color: Colors.red,
                  ),
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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: SizeUtil.f(150),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD8EAC8),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            vertical: SizeUtil.f(8),
            horizontal: SizeUtil.f(8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeUtil.f(16),
            horizontal: SizeUtil.f(16),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.fieldAndValue(
                "Document Number",
                controller.currentLeave.value?.docNo ?? '-',
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                "Leave Type",
                controller.employeeLeaveType.value
                        ?.firstWhere((element) =>
                            element.id ==
                            controller.currentLeave.value?.leaveTypeId)
                        .name ??
                    '-',
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                "Start Date",
                controller.currentLeave.value?.startDate == null
                    ? '-'
                    : DateFormat('EEEE, MMMM d, y, h:mm:ss a').format(
                        controller.currentLeave.value?.startDate ??
                            DateTime.now(),
                      ),
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                'Start Date Leave Type',
                controller.currentLeave.value?.startLeaveType == null
                    ? '-'
                    : controller.getLeaveId(
                        controller.currentLeave.value?.startLeaveType
                                ?.toInt() ??
                            0,
                      ),
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                "End Date",
                controller.currentLeave.value?.endDate == null
                    ? '-'
                    : DateFormat('EEEE, MMMM d, y, h:mm:ss a').format(
                        controller.currentLeave.value?.endDate ??
                            DateTime.now(),
                      ),
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                'End Date Leave Type',
                controller.currentLeave.value?.startLeaveType == null
                    ? '-'
                    : controller.getLeaveId(
                        controller.currentLeave.value?.endLeaveType?.toInt() ??
                            0,
                      ),
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                'Days Count',
                controller.currentLeave.value?.dayCount == null
                    ? '-'
                    : controller.currentLeave.value?.dayCount?.toString() ??
                        "-",
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                'Remark',
                controller.currentLeave.value?.remark == null
                    ? '-'
                    : controller.currentLeave.value?.remark ?? "-",
                null,
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
              CommonWidget.fieldAndValue(
                'Supporting Document',
                controller.currentLeave.value?.remark == null
                    ? '-'
                    : controller.currentLeave.value?.remark ?? "-",
                controller.currentLeave.value?.leaveDocument == null ||
                        controller.currentLeave.value?.leaveDocument == ""
                    ? const Text("-")
                    : InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: Get.context!,
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: Get.height * 0.9,
                              child: WebViewApp(
                                initialUrl:
                                    "https://ezyhr.rmagroup.com.sg/Public/OpenFile?filename=${controller.currentLeave.value?.leaveDocument!}&route=${controller.sessionService.getInstanceName()}",
                                title: 'Leave Request Document',
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
                controller.isLoading.value ||
                    controller.currentLeave.value == null,
              ),
            ],
          ),
        )
      ],
    );
  }
}
