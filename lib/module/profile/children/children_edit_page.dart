import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ChildrenEditPage extends GetView<PersonalDetailsController> {
  const ChildrenEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        '${controller.isAddChildren.value ? 'Add' : 'Edit'} Children',
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
                'NRIC',
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
                        controller: controller.childrenNricCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'NRIC',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Gender',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: CommonWidget.textPrimaryWidget(
                    controller.currentAddChildrenGender.value,
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
                      data: [
                        "Male",
                        "Female",
                      ],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.currentAddChildrenGender.value = e;
                      },
                      value: controller.currentAddChildrenGender.value,
                      title: 'Gender',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Birth Cert Number',
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
                        controller: controller.childrenBirthCertNumberCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Birth Cert Number',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Date of Birth',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => {
                  showDialog(
                    context: Get.context!,
                    builder: (ctx) {
                      var paddingHz = 36.0;
                      var el = Get.width / Get.height;
                      if (el > 1.3) {
                        paddingHz = Get.width * .3;
                      }
                      return Dialog(
                        insetPadding: EdgeInsets.symmetric(
                            horizontal: paddingHz, vertical: 48),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: CommonWidget.textPrimaryWidget(
                                      'Select Date',
                                      color: ColorConstant.grey90,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                                    InkWell(
                                        onTap: Get.back,
                                        child: Icon(Icons.close,
                                            size: SizeUtil.f(20))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SfDateRangePicker(
                                  onSelectionChanged:
                                      controller.onChildrenDobChange,
                                  selectionColor: Colors.green,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  view: DateRangePickerView.month,
                                  showActionButtons: true,
                                  onSubmit: (dynamic value) {
                                    controller.onChildrenDobConfirm(value);

                                    Get.back();
                                  },
                                  rangeSelectionColor:
                                      const Color(0xFF8BBF5A).withOpacity(0.3),
                                  todayHighlightColor: const Color(0xFF8BBF5A),
                                  endRangeSelectionColor:
                                      const Color(0xFF8BBF5A),
                                  startRangeSelectionColor:
                                      const Color(0xFF8BBF5A),
                                  confirmText: "Confirm",
                                  cancelText: "Cancel",
                                  onCancel: () {
                                    Get.back();
                                  },
                                  initialSelectedDate:
                                      controller.currentAddChildrenDob.value,
                                  maxDate: DateTime.now(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                },
                child: Obx(
                  () => Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: controller.personalDetails.value == null
                          ? const Color(0xFFF5F5F5)
                          : const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorConstant.grey40,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.yMMMEd()
                                .format(controller.currentAddChildrenDob.value),
                            style: CommonWidget.textStyleRoboto(
                              fontWeight: FontWeight.w400,
                              fontSize: SizeUtil.f(16),
                              color: ColorConstant.grey90,
                            ),
                          ),
                        ),
                        const SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color(0xFFAFAFAF),
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Birth Cert Name',
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
                        controller: controller.chidlrenBirthCertNameCtl,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Birth Cert Name',
                      ),
              ),
              const SizedBox(height: 24),
              Container(
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!controller.isAddChildren.value)
                        CustomFilledButton(
                          width: Get.width / 2 - 30,
                          title: 'Delete',
                          isLoading: controller.isLoading.value,
                          color: Colors.red,
                          onPressed: () {
                            controller.deleteChildren();
                          },
                        ),
                      CustomFilledButton(
                        width: controller.isAddChildren.value
                            ? Get.width - 48
                            : Get.width / 2 - 30,
                        title: 'Submit',
                        isLoading: controller.isLoading.value,
                        onPressed: () {
                          controller.childrenEditSubmit();
                        },
                      )
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
