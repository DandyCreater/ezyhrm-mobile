import 'package:currency_picker/currency_picker.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_options_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/theme/theme.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'reimbursement_form_controller.dart';

class ReimbursementFormScreen extends GetView<ReimbursementFormController> {
  const ReimbursementFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Reimbursement Form',
        isBack: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return CommonWidget.expandedScrollWidget(
      physics: const BouncingScrollPhysics(),
      top: [
        reimbursementFormWidget(context),
      ],
    );
  }

  reimbursementFormWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Type of Reimbursement',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              CommonWidget.textPrimaryWidget(
                '*',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.red60,
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          Obx(
            () => controller.reimbursementOptionList.value != null
                ? FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: CommonWidget.textPrimaryWidget(
                      controller.reimbursementOptionList.value?.length == 0
                          ? "No Options Available"
                          : controller.selectedReimbursementOption.value == null
                              ? ""
                              : "${controller.selectedReimbursementOption.value!.reimbursmentTypeResponse.name} - Balance SGD ${controller.selectedReimbursementOption.value!.balance}",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: controller.reimbursementOptionList.value.isEmpty
                          ? ColorConstant.grey50
                          : ColorConstant.grey90,
                    ),
                    actions: [
                      Icon(Icons.keyboard_arrow_down,
                          size: SizeUtil.f(20), color: ColorConstant.grey90),
                    ],
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      print(
                          " controller.reimbursementOptionList.value.isEmpty ${controller.reimbursementOptionList.value.isEmpty}");
                      controller.reimbursementOptionList.value.isEmpty
                          ? null
                          : FieldModalWidget.showModal<
                              ReimbursementOptionsResponse, String>(
                              data: controller.reimbursementOptionList.value!,
                              caption: (e) =>
                                  "${e.reimbursmentTypeResponse.name ?? ""} - Balance SGD ${double.parse(e.balance) ?? ""}",
                              onSelect: (e) {
                                controller.setSelectedValue(e);
                              },
                              title: "Type of Reimbursement",
                              value: controller
                                          .selectedReimbursementOption.value ==
                                      null
                                  ? ReimbursementOptionsResponse(
                                      reimbursmentTypeResponse:
                                          ReimbursementTypeResponse(
                                        id: -1,
                                        name: "",
                                      ),
                                      balance: "0",
                                      remarkOrBalance: "Claim",
                                    )
                                  : controller
                                      .selectedReimbursementOption.value!,
                            );
                    },
                    isExpanded: true,
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 44,
                      width: Get.width * 0.85,
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Currency',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              CommonWidget.textPrimaryWidget(
                '*',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.red60,
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          Obx(() => FieldModalWidget.fieldWidget(
                placeholder: 'Select',
                value: CommonWidget.textPrimaryWidget(
                  controller.selectedCurrency.value == null
                      ? "Select a Currency"
                      : "${controller.selectedCurrency.value!.name} - ${controller.selectedCurrency.value!.symbol}",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: controller.reimbursementOptionList.value.isEmpty
                      ? ColorConstant.grey50
                      : ColorConstant.grey90,
                ),
                actions: [
                  Icon(Icons.attach_money,
                      size: SizeUtil.f(20), color: ColorConstant.grey90),
                ],
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      print('Select currency: ${currency.code}');
                      print('Select currency: ${currency.name}');
                      print('Select currency: ${currency.number}');
                      controller.selectedCurrency.value = currency;
                    },
                    theme: CurrencyPickerThemeData(
                      flagSize: 25,
                      titleTextStyle: TextStyle(fontSize: 17),
                      subtitleTextStyle: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).hintColor,
                      ),
                      bottomSheetHeight:
                          MediaQuery.of(context).size.height / 1.5,
                      inputDecoration: const InputDecoration(
                        hintText: 'Start typing to search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                isExpanded: true,
              )),
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Incurred Date',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              CommonWidget.textPrimaryWidget(
                '*',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.red60,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() => FieldModalWidget.fieldWidget(
                placeholder: 'Select',
                value: CommonWidget.textPrimaryWidget(
                  controller.incurredDate.value == null
                      ? "Select incurred date"
                      : DateFormat.yMMMEd().format(
                          controller.incurredDate.value ?? DateTime.now(),
                        ),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: controller.incurredDate.value == null
                      ? Color(0xFFAFAFAF)
                      : Color(0xFF000000),
                ),
                actions: [
                  Icon(Icons.calendar_month,
                      size: SizeUtil.f(20), color: ColorConstant.grey90),
                ],
                onTap: () {
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
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                    )),
                                    InkWell(
                                        onTap: Get.back,
                                        child: Icon(Icons.close,
                                            size: SizeUtil.f(20))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SfDateRangePicker(
                                  maxDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1,
                                  ),
                                  onSelectionChanged:
                                      controller.onDateSelectionChanged,
                                  selectionColor: Colors.green,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  view: DateRangePickerView.month,
                                  showActionButtons: true,
                                  onSubmit: (dynamic value) {
                                    if (value == null) {
                                      value = DateTime.now();
                                    }
                                    controller.onConfirm(value);

                                    Get.back();
                                  },
                                  rangeSelectionColor:
                                      Color(0xFF8BBF5A).withOpacity(0.3),
                                  todayHighlightColor: Color(0xFF8BBF5A),
                                  endRangeSelectionColor: Color(0xFF8BBF5A),
                                  startRangeSelectionColor: Color(0xFF8BBF5A),
                                  confirmText: "Confirm",
                                  cancelText: "Cancel",
                                  onCancel: () {
                                    Get.back();
                                  },
                                  initialSelectedDate:
                                      controller.incurredDate.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                isExpanded: true,
              )),
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Amount',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              CommonWidget.textPrimaryWidget(
                '*',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.red60,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => SizedBox(
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Input Amount",
                  hintStyle: lightTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  errorText: controller.error.value == ""
                      ? null
                      : controller.error.value,
                  prefixIcon: Icon(
                    Icons.attach_money_outlined,
                    color: ColorConstant.grey50,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8D8D8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8D8D8),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8D8D8),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.amountController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                enabled: controller.reimbursementOptionList.value.isEmpty
                    ? false
                    : true,
              ),
            ),
          ),
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Remarks',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
            ],
          ),
          const SizedBox(height: 8),
          CommonWidget.textFieldWidget(
            controller: controller.remarkController,
            placeholder: 'Remarks',
            maxLines: 3,
            maxLength: 200,
            validator: [],
            isDense: true,
            textStyle: CommonWidget.textStyleRoboto(
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f(14),
              color: ColorConstant.black60,
            ),
            placeholderStyle: CommonWidget.textStyleRoboto(
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f(14),
              color: ColorConstant.grey50,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(200),
            ],
            enabled:
                controller.reimbursementOptionList.value.isEmpty ? false : true,
          ),
          SizedBox(height: SizeUtil.f(16)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'File Attachment',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
              SizedBox(width: SizeUtil.f(2)),
              CommonWidget.textPrimaryWidget(
                '*',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.red60,
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Please upload your supporting document',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorConstant.grey50,
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
          GestureDetector(
            onTap: () => controller.chooseImage(),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: Get.width * 0.85,
                  decoration: CommonWidget.defBoxDecoration(),
                  child: Column(
                    children: [
                      Obx(
                        () {
                          if (controller.imgType.value == ImgType.file) {
                            return CommonWidget.imageWidget(
                              path: controller.imgPath.value,
                              imgPathType: ImgPathType.file,
                              fit: BoxFit.cover,
                            );
                          } else if (controller.imgType.value ==
                              ImgType.network) {
                            return ClipOval(
                              child: CommonWidget.imageWidget(
                                path: controller.imgPath.value,
                                imgPathType: ImgPathType.network,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                withBaseEndpoint: false,
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: SizeUtil.f(16)),
                                CommonWidget.imageWidget(
                                  imgPathType: ImgPathType.asset,
                                  path: 'assets/svgs/ic_upload_cloud.svg',
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(height: SizeUtil.f(16)),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Browse',
                                        style: TextStyle(
                                          color: Color(0xFF8BBF5A),
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0.11,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' to choose a file',
                                        style: TextStyle(
                                          color: Color(0xFFAFAFAF),
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0.11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: SizeUtil.f(16)),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: SizeUtil.f(16)),
          Center(
            child: Column(
              children: [
                CommonWidget.textPrimaryWidget(
                  'Acceptable file types are Images. ',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: ColorConstant.grey50,
                ),
                CommonWidget.textPrimaryWidget(
                  'Max file size is 5MB. ',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: ColorConstant.grey50,
                ),
              ],
            ),
          ),
          SizedBox(height: SizeUtil.f(30)),
          Obx(
            () => Column(
              children: [
                CustomFilledButton(
                  width: double.infinity,
                  title: 'Submit Request',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (controller.reimbursementOptionList.value.isEmpty) {
                      CommonWidget.showErrorNotif(
                          "You have no reimbursement balance");
                    } else if (controller.isLoading.value) {
                      CommonWidget.showErrorNotif(
                          "Please wait for data to load");
                    } else {
                      controller.doSubmit();
                    }
                  },
                  color: controller.reimbursementOptionList.value.isEmpty
                      ? Colors.grey
                      : Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
