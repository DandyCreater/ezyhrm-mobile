import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalDetailsPage extends GetView<PersonalDetailsController> {
  const PersonalDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Personal Details',
        isBack: true,
        actions: [
          InkWell(
            onTap: () => Get.toNamed('/personalDetailsEditPage'),
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
                  "Employee Name",
                  controller.personalDetails.value?.employeeName ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "First Name",
                  controller.personalDetails.value?.firstName ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Last Name",
                  controller.personalDetails.value?.lastName ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Date of Birth",
                  controller.personalDetails.value == null
                      ? "-"
                      : DateFormat.yMMMEd().format(
                          controller.personalDetails.value?.dateOfBirth ??
                              DateTime.now(),
                        ),
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Place of Birth",
                  controller.personalDetails.value?.placeOfBirth ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Nationality",
                  controller.personalDetails.value?.nationality ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "NRIC FIN NO",
                  controller.personalDetails.value?.nricFinNo ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Passport No",
                  controller.personalDetails.value?.passportNo ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Gender",
                  controller.personalDetails.value?.gender ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Race",
                  controller.personalDetails.value?.race ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Religion",
                  controller.personalDetails.value?.religion ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Marital Status",
                  controller.personalDetails.value?.maritalStatus ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Mobile Number",
                  controller.personalDetails.value?.mobileNo ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Home Number",
                  controller.personalDetails.value?.homeNo ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Email",
                  controller.personalDetails.value?.email ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Highest Qualification",
                  controller.personalDetails.value?.highestQualification ?? "-",
                  null,
                  controller.isLoading.value ||
                      controller.personalDetails.value == null,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
