import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/leave_approval/leave_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveApprovalPage extends GetView<LeaveApprovalController> {
  const LeaveApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Approval Leave",
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
                  Obx(() => _body()),
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
            'List of Employee Leave Request',
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
          ),
        ],
      ),
    );
  }

  Widget _body() {
    Widget content;
    if (controller.isLoading.value) {
      content = Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 400,
            ),
          ],
        ),
      );
    } else if (controller.leaveApprovalDto.value?.isEmpty ?? true) {
      content = Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Column(
            children: [
              Text("No data to show"),
              SizedBox(
                height: 400,
              ),
            ],
          ),
        ),
      );
    } else {
      content = Column(
        children: [
          ...controller.leaveApprovalDto.value!
              .map(
                (e) => _leaveCard(e),
              )
              .toList(),
          SizedBox(
            height: 400,
          ),
        ],
      );
    }

    return Container(
      child: content,
    );
  }

  Widget _leaveCard(LeaveApprovalDto leave) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 8,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.textPrimaryWidget(
                    "Requestor Name",
                    color: Color(0xFF545454),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  CommonWidget.textPrimaryWidget(
                    leave.employeeList!.employeename,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.setCurrentLeaveApproval(leave);
                    },
                    child: CommonWidget.textPrimaryWidget(
                      "See detail",
                      color: Color(0xFF784DFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.titleAndValue(
                        "Created Date",
                        leave.employeeLeaveResponse?.createdAt == null
                            ? "-"
                            : DateFormat('d MMMM yyyy').format(
                                leave.employeeLeaveResponse?.createdAt ??
                                    DateTime.now(),
                              ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CommonWidget.titleAndValue(
                        "Leave Type",
                        controller
                                .findById(leave
                                        .employeeLeaveResponse?.leaveTypeId
                                        ?.toInt() ??
                                    0)
                                .name ??
                            "-",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CommonWidget.titleAndValue(
                        "Start Date",
                        DateFormat('d MMMM yyyy').format(
                          leave.employeeLeaveResponse?.startDate ??
                              DateTime.now(),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.titleAndValue(
                        "Employee ID",
                        leave.employeeLeaveResponse?.employeeId.toString() ??
                            "-",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CommonWidget.titleAndValue(
                        "Number of Days",
                        leave.employeeLeaveResponse?.dayCount.toString() ?? "-",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CommonWidget.titleAndValue(
                        "End Date",
                        DateFormat('d MMMM yyyy').format(
                          leave.employeeLeaveResponse?.endDate ??
                              DateTime.now(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
