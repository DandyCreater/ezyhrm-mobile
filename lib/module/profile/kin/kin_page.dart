import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KinPage extends GetView<PersonalDetailsController> {
  const KinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Kin Details',
        isBack: true,
        actions: [
          InkWell(
            onTap: () => controller.editKin(),
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
                  "Name",
                  controller
                          .personalDetails
                          .value
                          ?.nextOfKinContact?[controller.currKinIndex.value]
                          .name ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Relation",
                  controller
                          .personalDetails
                          .value
                          ?.nextOfKinContact?[controller.currKinIndex.value]
                          .relationshipToEmployee ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Email",
                  controller
                          .personalDetails
                          .value
                          ?.nextOfKinContact?[controller.currKinIndex.value]
                          .email ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Mobile No",
                  controller
                          .personalDetails
                          .value
                          ?.nextOfKinContact?[controller.currKinIndex.value]
                          .mobileNo ??
                      "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Home No",
                  controller
                          .personalDetails
                          .value
                          ?.nextOfKinContact?[controller.currKinIndex.value]
                          .homeNo ??
                      "-",
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
