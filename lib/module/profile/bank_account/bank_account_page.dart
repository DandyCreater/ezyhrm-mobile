import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountPage extends GetView<PersonalDetailsController> {
  const BankAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Bank Account',
        isBack: true,
        actions: [
          InkWell(
            onTap: () => Get.toNamed('/bankAccountEditPage'),
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
        onRefresh: () => controller.getBankCode(),
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
                  "Bank Name",
                  controller.nonEditedBankAccount.value?.bankName ?? "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Bank Code",
                  controller.nonEditedBankAccount.value?.bankCode ?? "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Branch Name",
                  controller.nonEditedBankAccount.value?.branchName ?? "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Branch Code",
                  controller.nonEditedBankAccount.value?.branchCode ?? "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Swift Code",
                  controller.nonEditedBankAccount.value?.swiftCode ?? "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Bank Account Number",
                  controller.personalParticular.value?.bankAccount
                          ?.bankAccountNumber ??
                      "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
                CommonWidget.fieldAndValue(
                  "Bank Account Name",
                  controller.personalParticular.value?.bankAccount
                          ?.bankAccountName ??
                      "=",
                  null,
                  controller.isLoading.value ||
                      controller.nonEditedBankAccount.value == null,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
