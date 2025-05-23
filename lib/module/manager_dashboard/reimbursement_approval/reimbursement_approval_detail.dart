import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReimbursementApprovalDetailPage
    extends GetView<ReimbursementApprovalController> {
  const ReimbursementApprovalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        "Approval Reimbursement Detail",
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
                  Obx(
                    () => _body(),
                  ),
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
            controller.currentReimbursementApproval.value?.employee
                    ?.employeename ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Employee ID",
            controller
                    .currentReimbursementApproval.value?.employee?.employeeid ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.date !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.date ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Reimbursement Type",
            controller
                    .getReimbursementTypeById(
                      (controller.currentReimbursementApproval.value
                                  ?.reimbursementList?.claimTypeId ??
                              0)
                          .toInt(),
                    )
                    .name ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Reimbursement Amount',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.claimAmount
                    .toString() ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Currency',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.remark1 ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Incurred Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.incurredDate !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.incurredDate ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndComponent(
            'Supporting Document ',
            controller.currentReimbursementApproval.value?.reimbursementList
                            ?.fileName ==
                        null ||
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.fileName ==
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
                                "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/reimbursement/${controller.currentReimbursementApproval.value?.reimbursementList?.fileName}",
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
          CommonWidget.titleAndValue(
            'Approved Amount',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.approvedAmount !=
                    null
                ? controller.currentReimbursementApproval.value
                        ?.reimbursementList?.approvedAmount
                        .toString() ??
                    "-"
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Approved Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.approvedDate !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.applyDate ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Rejected Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.rejectedDate !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.rejectedDate ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            "Status",
            controller.getReimbursementProgress(
                  (controller.currentReimbursementApproval.value
                              ?.reimbursementList?.status ??
                          0)
                      .toInt(),
                ) ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Remarks',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.remark ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Remarks 2',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.remark2 ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Created By',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.createdBy
                    .toString() ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Created Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.createdAt !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.createdAt ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Updated By',
            controller.currentReimbursementApproval.value?.reimbursementList
                    ?.updatedBy
                    .toString() ??
                "-",
            divider: true,
          ),
          CommonWidget.titleAndValue(
            'Updated Date',
            controller.currentReimbursementApproval.value?.reimbursementList
                        ?.updatedAt !=
                    null
                ? DateFormat('d MMMM yyyy').format(
                    controller.currentReimbursementApproval.value
                            ?.reimbursementList?.updatedAt ??
                        DateTime.now(),
                  )
                : "-",
            divider: true,
          ),
          Obx(
            () => controller.currentReimbursementApproval.value!
                        .reimbursementList?.status ==
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
                            caption: "Approve",
                            onTap: () {
                              if (controller.isLoading.value) {
                                CommonWidget.showErrorNotif(
                                    "Please wait until the process is complete");
                              } else {
                                controller.approveReimbursement();
                              }
                            },
                            isLoading: controller.isLoading.value,
                            bgColor: Color(0xFF8BBF5A),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CommonWidget.primaryButtonWidget(
                            caption: "Reject",
                            onTap: () {
                              if (controller.isLoading.value) {
                                CommonWidget.showErrorNotif(
                                    "Please wait until the process is complete");
                              } else {
                                controller.rejectReimbursement();
                              }
                            },
                            isLoading: controller.isLoading.value,
                            bgColor: Color(0xFFED2115),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
