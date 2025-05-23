import 'package:ezyhr_mobile_apps/module/manager_dashboard/supervisor_employee_response.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TimesheetApprovalPage extends GetView<TimesheetApprovalController> {
  const TimesheetApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "Timesheet Approval",
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
            'List of Employee Timesheet',
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
                        data: controller.yearList.value ?? ["2023", "2024"],
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
    return Obx(() => Column(children: _innerBody()));
  }

  List<Widget> _innerBody() {
    if (controller.isLoading.value) {
      return List.generate(5, (index) {
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
      });
    } else if (controller.timesheetApprovalList.value?.isEmpty ?? true) {
      return [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: CommonWidget.textPrimaryWidget(
            "No data found",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        )
      ];
    } else if (controller.timesheetApprovalList.value?.isNotEmpty ?? false) {
      return controller.timesheetApprovalList.value!.map((e) {
        return timesheetCard(e);
      }).toList();
    } else {
      return [];
    }
  }

  Widget timesheetCard(TimesheetApprovalDto timesheetApprovalDto) {
    return InkWell(
      onTap: () {
        controller.setTimesheetApproval(timesheetApprovalDto);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color: controller.getStatusBackgroundColor(
                      timesheetApprovalDto.timesheetApprovalWeeklyDto.first
                              .timesheet.first.timesheet.status ??
                          0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.getStatus(timesheetApprovalDto.status),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller
                            .getStatusColor(timesheetApprovalDto.status),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.purpleAccent,
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.fieldAndValue(
                    "Employee Name",
                    timesheetApprovalDto.employee.employeename ?? "-",
                    null,
                    controller.isLoading.value,
                  ),
                  CommonWidget.fieldAndValue(
                    "Month",
                    (timesheetApprovalDto.timesheetApprovalWeeklyDto.first
                                .startDate.month ??
                            0)
                        .toString(),
                    null,
                    controller.isLoading.value,
                  )
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.fieldAndValue(
                    "Employee ID",
                    timesheetApprovalDto.employee.employeeid ?? "-",
                    null,
                    controller.isLoading.value,
                  ),
                  CommonWidget.fieldAndValue(
                    "Year",
                    (timesheetApprovalDto.timesheetApprovalWeeklyDto.first
                                .startDate.year ??
                            0)
                        .toString(),
                    null,
                    controller.isLoading.value,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
