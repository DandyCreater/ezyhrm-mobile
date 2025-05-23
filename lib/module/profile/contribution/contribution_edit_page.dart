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

class ContributionEditPage extends GetView<PersonalDetailsController> {
  const ContributionEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Edit Contribution',
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
                'CDAC',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value!.contributionAndDonation!.cdac ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: contributionList,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value
                            ?.contributionAndDonation!.cdac = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller
                          .personalDetails.value?.contributionAndDonation!.cdac,
                      title: 'CDAC',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'ECF',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value!.contributionAndDonation!.ecf ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: contributionList,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value
                            ?.contributionAndDonation!.ecf = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller
                          .personalDetails.value?.contributionAndDonation!.ecf,
                      title: 'ECF',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'MBMF',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value!.contributionAndDonation!.mbmf ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: contributionList,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value
                            ?.contributionAndDonation!.mbmf = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller
                          .personalDetails.value?.contributionAndDonation!.mbmf,
                      title: 'MBMF',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'SINDA',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value!.contributionAndDonation!.sinda ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: contributionList,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value
                            ?.contributionAndDonation!.sinda = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value
                          ?.contributionAndDonation!.sinda,
                      title: 'SINDA',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Share',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value!.contributionAndDonation!.share ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: contributionList,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value
                            ?.contributionAndDonation!.share = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value
                          ?.contributionAndDonation!.share,
                      title: 'Share',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Share Amount',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
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
                        controller: controller.shareAmountCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Share Amount',
                      ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomFilledButton(
                  width: double.infinity,
                  title: 'Submit',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.onContributionSubmit();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

final contributionList = [
  "Yes",
  "No",
  "Auto",
  "Fixed",
  "Opt-Out",
];
