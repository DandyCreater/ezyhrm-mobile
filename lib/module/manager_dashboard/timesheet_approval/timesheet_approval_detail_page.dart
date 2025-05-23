import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_controller.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/timesheet_approval/timesheet_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimesheetApprovalDetailPage extends GetView<TimesheetApprovalController> {
  const TimesheetApprovalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final a = controller.currentTimesheetApproval.value;
    final b = controller
        .currentTimesheetApproval.value!.timesheetApprovalWeeklyDto.first;
    final c = controller.currentTimesheetApproval.value!
        .timesheetApprovalWeeklyDto.first.timesheet.first;
    final x = controller.currentTimesheetApproval.value!
        .timesheetApprovalWeeklyDto.first.timesheet.first.timesheet.status;
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        "View Timesheet ",
        isBack: true,
        bgColor: ColorConstant.greenBackground,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorConstant.primary,
          onRefresh: () async => printInfo(),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    _headerWidget(),
                    _body(context),
                    controller
                                .currentTimesheetApproval
                                .value!
                                .timesheetApprovalWeeklyDto
                                .first
                                .timesheet
                                .first
                                .timesheet
                                .status ==
                            1
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
                                        controller.approveTimesheet();
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
                                        controller.rejectTimesheet();
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
                  ],
                ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.textPrimaryWidget(
            "${controller.currentTimesheetApproval.value?.employee.employeename ?? "-"} (${controller.currentTimesheetApproval.value?.employee.employeeid ?? "-"})",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Spacer(),
          CommonWidget.textPrimaryWidget(
            DateFormat("MMMM yyyy").format(
                  controller.timesheetApprovalList.value?.first
                          .timesheetApprovalWeeklyDto.first.startDate ??
                      DateTime.now(),
                ) ??
                "-",
            color: Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller
                .currentTimesheetApproval.value?.timesheetApprovalWeeklyDto
                .map((e) => weeklyCard(context, e))
                .toList() ??
            [],
      ),
    );
  }

  Widget weeklyCard(BuildContext context,
      TimesheetApprovalWeeklyDto timesheetApprovalWeeklyDto) {
    return SingleChildScrollView(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  DateFormat("dd MMMM yyyy").format(
                      timesheetApprovalWeeklyDto.startDate ?? DateTime.now()),
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                CommonWidget.textPrimaryWidget(
                  ' to ',
                  color: Color(0xFF545454),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CommonWidget.textPrimaryWidget(
                  DateFormat("dd MMMM yyyy").format(
                      timesheetApprovalWeeklyDto.endDate ?? DateTime.now()),
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timesheetApprovalWeeklyDto.timesheet
                      .map(
                        (e) => dailyCard(
                          context,
                          e,
                        ),
                      )
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget dailyCard(BuildContext context,
      TimesheetApprovalDailyDto timesheetApprovalDailyDto) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                DateFormat("EEEE, dd MMMM yyyy")
                    .format(timesheetApprovalDailyDto.date ?? DateTime.now()),
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CommonWidget.titleAndValue(
                'Start Time',
                timesheetApprovalDailyDto.timesheet.startTime ?? "-",
              ),
              Spacer(),
              CommonWidget.titleAndValue(
                "End Time",
                timesheetApprovalDailyDto.timesheet.endTime ?? "-",
              ),
              Spacer(),
              CommonWidget.titleAndValue(
                "Break",
                timesheetApprovalDailyDto.timesheet.breakTime ?? "-",
              ),
              Spacer(),
              CommonWidget.titleAndValue(
                "Hours Worked",
                timesheetApprovalDailyDto.timesheet.workHours.toString() ?? "-",
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          CommonWidget.titleAndValue(
            "Remarks",
            timesheetApprovalDailyDto.timesheet.remark ?? "-",
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
