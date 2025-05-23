import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChildrenPage extends GetView<PersonalDetailsController> {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Children Details',
        isBack: true,
        actions: [
          InkWell(
            onTap: () => controller.editChildren(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  CommonWidget.textPrimaryWidget(
                    'Edit',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF784DFF),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
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
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: CommonWidget.defBoxDecoration(
            bgColor: Colors.white,
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.fieldAndValue(
                  "NRIC",
                  controller
                          .personalDetails
                          .value
                          ?.childrenDetails![controller.currChildrenIndex.value]
                          .nric ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Gender",
                  controller
                          .personalDetails
                          .value
                          ?.childrenDetails![controller.currChildrenIndex.value]
                          .gender ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Birth Cert Number",
                  controller
                          .personalDetails
                          .value
                          ?.childrenDetails![controller.currChildrenIndex.value]
                          .birthCertNumber ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Birth Cert Name",
                  controller
                          .personalDetails
                          .value
                          ?.childrenDetails![controller.currChildrenIndex.value]
                          .birthCertName ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Date of Birth",
                  controller
                              .personalDetails
                              .value
                              ?.childrenDetails![
                                  controller.currChildrenIndex.value]
                              .dateOfBirth ==
                          null
                      ? "-"
                      : DateFormat.yMMMEd().format(
                          controller
                                  .personalDetails
                                  .value
                                  ?.childrenDetails![
                                      controller.currChildrenIndex.value]
                                  .dateOfBirth ??
                              DateTime.now(),
                        ),
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
