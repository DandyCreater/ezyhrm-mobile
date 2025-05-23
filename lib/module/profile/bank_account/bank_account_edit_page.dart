import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BankAccountEditPage extends GetView<PersonalDetailsController> {
  const BankAccountEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Edit Bank Account',
        isBack: true,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          decoration: CommonWidget.defBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Bank Name',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.currBankAccount.value != null &&
                          controller.bankCodeList.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.currBankAccount.value!.bankName ?? ""}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        ),
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller
                          .getBankNameList("bankName")
                          .map((e) => e.bankName ?? "")
                          .toList(),
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setCurrBankAccount(e, "bankName");
                      },
                      value: controller.currBankAccount.value?.bankName ?? "",
                      title: 'Bank Name',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Bank Code',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.currBankAccount.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.currBankAccount.value!.bankCode ?? ""}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller
                          .getBankNameList("bankCode")
                          .map((e) => e.bankCode ?? "")
                          .toList(),
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setCurrBankAccount(e, "bankCode");
                      },
                      value: controller.currBankAccount.value?.bankCode ?? "",
                      title: 'Bank Code',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Branch Name',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.currBankAccount.value != null
                      ? CommonWidget.textPrimaryWidget(
                          controller.currBankAccount.value?.branchName ?? "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller
                          .getBankNameList("branchName")
                          .map((e) => e.branchName ?? "")
                          .toList(),
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setCurrBankAccount(e, "branchName");
                      },
                      value: controller.currBankAccount.value?.branchName ?? "",
                      title: 'Branch Name',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Branch Code',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.currBankAccount.value != null
                      ? CommonWidget.textPrimaryWidget(
                          controller.currBankAccount.value?.branchCode ?? "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller
                          .getBankNameList("branchCode")
                          .map((e) => e.branchCode!)
                          .toList(),
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setCurrBankAccount(e, "branchCode");
                      },
                      value: controller.currBankAccount.value?.branchCode ?? "",
                      title: 'Branch Code',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Swift Code',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalParticular.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : Container(
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEEEEEE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFE2E2E2)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: CommonWidget.textFieldWidget(
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          textStyle: const TextStyle(
                            color: Color(0xFFAFAFAF),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          ),
                          placeholder:
                              controller.currBankAccount.value?.swiftCode ?? "",
                          enabled: false,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Bank Account Number',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalParticular.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.bankAccountNumberCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Bank Account Number',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Bank Account Name',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalParticular.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.bankAccountNameCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Bank Account Name',
                      ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomFilledButton(
                  width: double.infinity,
                  title: 'Submit',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.onBankAccountSubmit();
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        )
      ],
    );
  }
}
