import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveApprovalDetailPage extends GetView<LeaveApprovalController> {
  const LeaveApprovalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        "Approval Leave Detail",
        isBack: true,
        bgColor: ColorConstant.backgroundColor,
      ),
      backgroundColor: ColorConstant.backgroundColor,
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
                  _body(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 24,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.titleAndValue(
            "Employee Name",
            controller.currentLeaveApproval.value?.employeeList?.employeename ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Employee ID",
            controller.currentLeaveApproval.value?.employeeList?.employeeid ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Status",
            controller.getStatus((controller.currentLeaveApproval.value
                                ?.employeeLeaveResponse?.status ??
                            0)
                        .toInt() ??
                    0) ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Leave Type",
            controller
                    .findById(
                      (controller.currentLeaveApproval.value
                                  ?.employeeLeaveResponse?.leaveTypeId ??
                              0)
                          .toInt(),
                    )
                    .name ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Start Date",
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                        ?.startDate !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.startDate ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Start Date Leave Type',
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                        ?.startLeaveType !=
                    null
                ? controller.getLeaveId(
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.startLeaveType
                            ?.toInt() ??
                        0,
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "End Date",
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                        ?.endDate !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.endDate ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "End Date Leave Type",
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                        ?.endLeaveType !=
                    null
                ? controller.getLeaveId(
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.endLeaveType
                            ?.toInt() ??
                        0,
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Number of Days",
            controller
                    .currentLeaveApproval.value?.employeeLeaveResponse?.dayCount
                    .toString() ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Remarks",
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                    ?.remark ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Created By",
            (controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.createdBy ??
                        "-")
                    .toString() ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Created Date",
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                        ?.createdAt !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.createdAt ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndComponent(
            'Supporting Document',
            controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.leaveDocument ==
                        null ||
                    controller.currentLeaveApproval.value?.employeeLeaveResponse
                            ?.leaveDocument ==
                        ""
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
                                "https://ezyhr.rmagroup.com.sg/Public/OpenFile?filename=${controller.currentLeaveApproval.value?.employeeLeaveResponse?.leaveDocument!}&route=${controller.sessionService.getInstanceName()}",
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
            divider: true,
          ),
          controller.currentLeaveApproval.value?.employeeLeaveResponse
                      ?.status ==
                  2
              ? Container(
                  padding: EdgeInsets.all(
                    16,
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonWidget.primaryButtonWidget(
                          caption: "Reject",
                          onTap: () {
                            controller.rejectLeave();
                          },
                          bgColor: Color(0xFFED2115),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CommonWidget.primaryButtonWidget(
                          caption: "Approve",
                          onTap: () {
                            controller.approveLeave();
                          },
                          bgColor: Color(0xFF8BBF5A),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
