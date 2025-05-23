import 'package:ezyhr_mobile_apps/module/reimbursement/list_reimbursement/list_reimbursement_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReimbursementDetailPage extends GetView<ReimbursementController> {
  const ReimbursementDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Reimbursement Details',
        isBack: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: headerWidget(),
    );
  }

  headerWidget() {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.fieldAndValue(
                  "Date",
                  controller.currentReimbursement.value.date == null
                      ? '-'
                      : DateFormat('EEEE, MMMM d, y')
                          .format(controller.currentReimbursement.value.date!),
                  null,
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Status",
                  controller.currentReimbursement.value.claimTypeId == null
                      ? '-'
                      : controller.getReimbursementProgress(
                          (controller.currentReimbursement.value.status ?? 0)
                              .toInt(),
                        ),
                  null,
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Reimbursement Type",
                  controller.currentReimbursement.value.claimTypeId == null
                      ? '-'
                      : controller
                              .getReimbursementTypeById(
                                controller
                                    .currentReimbursement.value.claimTypeId!
                                    .toInt(),
                              )
                              .name ??
                          '-',
                  null,
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Claim Amount",
                  controller.currentReimbursement.value.remark1 == null
                      ? '-'
                      : "${controller.currentReimbursement.value.remark1 ?? "-"} ${controller.currentReimbursement.value.claimAmount.toString()}",
                  null,
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Supporting Document",
                  "",
                  controller.currentReimbursement.value.claimDocument == null
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
                                      "https://ezyhr.rmagroup.com.sg/upload/${controller.sessionService.getInstanceName()}/reimbursement/${controller.currentReimbursement.value.claimDocument}",
                                  title: 'Reimbursement Document',
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
                  "Approved Amount",
                  controller.currentReimbursement.value.approvedAmount == null
                      ? '-'
                      : "${controller.currentReimbursement.value.remark1 ?? "-"} ${controller.currentReimbursement.value.approvedAmount.toString()}",
                  null,
                  controller.isLoading.value,
                ),
                CommonWidget.fieldAndValue(
                  "Remark",
                  controller.currentReimbursement.value.remark == null ||
                          controller.currentReimbursement.value.remark == ""
                      ? '-'
                      : controller.currentReimbursement.value.remark ?? "-",
                  null,
                  controller.isLoading.value,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
