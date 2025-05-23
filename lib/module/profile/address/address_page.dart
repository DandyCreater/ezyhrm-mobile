import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends GetView<PersonalDetailsController> {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Address',
        isBack: true,
        actions: [
          InkWell(
            onTap: () => Get.toNamed('/addressEditPage'),
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
                  "Country",
                  controller.personalDetails.value?.address?.country ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Postal Code",
                  controller.personalDetails.value?.address?.postalCode ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Block",
                  controller.personalDetails.value?.address?.block ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Street",
                  controller.personalDetails.value?.address?.street ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Unit",
                  controller.personalDetails.value?.address?.unit ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Building",
                  controller.personalDetails.value?.address?.unit ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "State",
                  controller.personalDetails.value?.address?.state ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
