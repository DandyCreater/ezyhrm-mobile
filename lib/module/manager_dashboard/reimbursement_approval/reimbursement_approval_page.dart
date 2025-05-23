import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/reimbursement_approval/reimbursement_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ReimbursementApprovalPage
    extends GetView<ReimbursementApprovalController> {
  const ReimbursementApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Reimbursement Approval",
        isBack: true,
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
    );
  }

  Widget _headerWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.textPrimaryWidget(
            'List of Employee Reimbursement',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 8,
          ),
          CommonWidget.textPrimaryWidget(
            'Filter',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Obx(
                () => Expanded(
                  child: FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Expanded(
                      child: CommonWidget.textPrimaryWidget(
                        controller.currentEmployee.value?.employeename ??
                            "Employee",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: ColorConstant.grey90,
                      ),
                    ),
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      FieldModalWidget.showModal<SupervisorEmployeeResponse,
                          String>(
                        data: controller.employeeList.value ?? [],
                        caption: (e) => e.employeename,
                        onSelect: (e) {
                          controller.setCurrentEmployee(e);
                        },
                        value: controller.currentEmployee.value,
                        title: 'Employee',
                      );
                    },
                    isExpanded: false,
                  ),
                ),
              ),
              SizedBox(width: SizeUtil.f(12)),
              Obx(
                () => Expanded(
                  child: FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Expanded(
                      child: CommonWidget.textPrimaryWidget(
                        controller.selectedStatus.value,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: ColorConstant.grey90,
                      ),
                    ),
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      FieldModalWidget.showModal<String, String>(
                        data: controller.statuses.value,
                        caption: (e) => e,
                        onSelect: (e) {
                          controller.setStatus(e);
                        },
                        value: controller.selectedStatus.value,
                        title: 'Status',
                      );
                    },
                    isExpanded: false,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(12)),
          Row(
            children: [
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
                    isLoading: controller.isLoading.value,
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
              SizedBox(width: SizeUtil.f(12)),
              Obx(
                () => Expanded(
                  child: FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Expanded(
                      child: CommonWidget.textPrimaryWidget(
                        controller.selectedYear.value.toString(),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: ColorConstant.grey90,
                      ),
                    ),
                    isLoading: controller.isLoading.value,
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
                    isExpanded: false,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Obx(
      () => controller.isLoading.value ||
              controller.reimbursementApprovalList.value == null
          ? Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  height: 100,
                  width: double.infinity,
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
                );
              }),
            )
          : Column(
              children: controller.reimbursementApprovalList.value!
                  .map((e) => _reimbursementCard(e))
                  .toList(),
            ),
    );
  }

  Widget _reimbursementCard(ReimbursementApprovalDto leave) {
    return InkWell(
      onTap: () {
        controller.setCurrentReimbursement(leave);
        Get.toNamed(
          ReimbursementApprovalC.detailRoute,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color: controller.getReimbursementColorBackground(
                    (leave.reimbursementList?.status ?? 0).toInt(),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(
                  controller.getReimbursementProgress(
                    (leave.reimbursementList?.status ?? 0).toInt(),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.getReimbursementColor(
                      (leave.reimbursementList?.status ?? 0).toInt(),
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.fieldAndValue(
                        "Employee Name",
                        leave.employee?.employeename ?? "-",
                        null,
                        controller.isLoading.value,
                      ),
                      CommonWidget.fieldAndValue(
                        "Created Date",
                        DateFormat("dd MMMM yyyy").format(
                            leave.reimbursementList?.applyDate ??
                                DateTime.now()),
                        null,
                        controller.isLoading.value,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.fieldAndValue(
                        "Reimbursement Type",
                        controller
                                .getReimbursementTypeById(
                                    (leave.reimbursementList?.claimTypeId ?? 0)
                                        .toInt())
                                .name ??
                            "-",
                        null,
                        controller.isLoading.value,
                      ),
                      CommonWidget.fieldAndValue(
                        "Amount",
                        controller
                                .getReimbursementTypeById(
                                  (leave.reimbursementList?.claimTypeId ?? 0)
                                      .toInt(),
                                )
                                .name ??
                            "-",
                        CommonWidget.singaporeanCurrencyWidget(
                          value: (leave.reimbursementList?.claimAmount ?? 0)
                              .toDouble(),
                        ),
                        controller.isLoading.value,
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  controller.setCurrentReimbursement(leave);
                },
                child: CommonWidget.textPrimaryWidget(
                  "See detail ",
                  color: Color(0xFF784DFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
