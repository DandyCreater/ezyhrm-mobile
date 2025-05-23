import 'package:ezyhr_mobile_apps/module/staff_movement/staff_movement_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StaffMovementDetail extends GetView<StaffMovementController> {
  const StaffMovementDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: CommonWidget.appBar(
          "Staff Movement Detail",
          isBack: true,
          bgColor: ColorConstant.greenBackground,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _body(),
              ],
            ),
          ),
        ));
  }

  Widget _body() {
    return Container(
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.fieldAndValue(
                    "ID",
                    controller.currentStaffMovement.value?.id == null
                        ? '-'
                        : (controller.currentStaffMovement.value?.id ?? 0)
                            .toString(),
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Name",
                    controller.currentStaffMovement.value?.fullName == null
                        ? '-'
                        : controller.currentStaffMovement.value?.fullName ??
                            "-",
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Time From",
                    controller.currentStaffMovement.value?.dateFrom == null
                        ? '-'
                        : DateFormat('hh:mm a').format(
                            controller.currentStaffMovement.value!.dateFrom!),
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Date From",
                    controller.currentStaffMovement.value?.dateFrom == null
                        ? '-'
                        : DateFormat('EEEE, MMMM d, y').format(
                            controller.currentStaffMovement.value!.dateFrom!),
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Time To",
                    controller.currentStaffMovement.value?.dateTo == null
                        ? '-'
                        : DateFormat('hh:mm a').format(
                            controller.currentStaffMovement.value!.dateTo!),
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Date To",
                    controller.currentStaffMovement.value?.dateTo == null
                        ? '-'
                        : DateFormat('EEEE, MMMM d, y').format(
                            controller.currentStaffMovement.value!.dateTo!),
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                  CommonWidget.fieldAndValue(
                    "Remarks",
                    controller.currentStaffMovement.value?.remarks == null
                        ? '-'
                        : controller.currentStaffMovement.value?.remarks ?? "-",
                    null,
                    controller.isLoading.value ||
                        controller.currentStaffMovement.value == null,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
