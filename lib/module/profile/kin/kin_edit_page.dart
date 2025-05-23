import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class KinEditPage extends GetView<PersonalDetailsController> {
  const KinEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        "${controller.isAddKin.value ? 'Add' : 'Edit'} Next of Kin",
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
                'Name',
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
                        controller: controller.kinNameCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Name',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Relationship',
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
                        controller: controller.kinRelationshipCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Relationship',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Email',
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
                        controller: controller.kinEmailCtl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Email',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Mobile Number',
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
                        controller: controller.kinMobileNoCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Mobile Number',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Home Number',
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
                        controller: controller.kinHomeNoCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Home Number',
                      ),
              ),
              const SizedBox(height: 24),
              Container(
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!controller.isAddKin.value)
                        CustomFilledButton(
                          width: Get.width / 2 - 30,
                          title: 'Delete',
                          isLoading: controller.isLoading.value,
                          color: Colors.red,
                          onPressed: () {
                            controller.deleteKin();
                          },
                        ),
                      CustomFilledButton(
                        width: controller.isAddKin.value
                            ? Get.width - 48
                            : Get.width / 2 - 30,
                        title: 'Submit',
                        isLoading: controller.isLoading.value,
                        onPressed: () {
                          controller.kinEditSubmit();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
