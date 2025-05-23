import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../shared/constant/color_constant.dart';
import '../../shared/utils/size_util.dart';
import 'common_widget.dart';

class FieldModalWidget {
  static Widget textFieldWidget<T>({
    required TextEditingController controller,
    required List<T>? data,
    required T? value,
    required String Function(T t) caption,
    required Function(T t) onSelect,
    String popupTitle = '',
    String placeholder = '',
    Widget? leading,
    List<Widget> actions = const [],
    List<FieldValidator> validator = const [],
  }) {
    return TextFormField(
      controller: controller,
      onTap: () {
        showModal<T, String>(
          data: data ?? [],
          value: value,
          caption: caption,
          onSelect: (T t) {
            if (t != null) {
              controller.text = caption(t);
            }
            onSelect(t);
          },
          title: popupTitle,
        );
      },
      showCursor: false,
      readOnly: true,
      validator: MultiValidator([...validator]),
      decoration: CommonWidget.inputDecoration(
        placeholder: placeholder,
        prefix: leading,
        suffix: Padding(
          padding:
              const EdgeInsets.only(left: 18, top: 12, bottom: 12, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions,
              if (data == null)
                SizedBox(
                  height: SizeUtil.f(10),
                  width: SizeUtil.f(10),
                  child: CircularProgressIndicator(
                      color: ColorConstant.primary, strokeWidth: 1),
                ),
              if (data != null)
                Icon(Icons.keyboard_arrow_down,
                    size: SizeUtil.f(20), color: ColorConstant.grey90),
            ],
          ),
        ),
      ),
    );
  }

  static Widget fieldWidget(
      {Widget? leading,
      Widget? value,
      String placeholder = '',
      List<Widget> actions = const [],
      Function()? onTap,
      bool? isLoading,
      backgroundColor = Colors.white,
      bool? isExpanded}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: SizeUtil.f(56),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 1, color: ColorConstant.grey40),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading, const SizedBox(width: 14)],
            if (isExpanded != null && isExpanded || isExpanded == null)
              Expanded(
                child: value ??
                    CommonWidget.textPrimaryWidget(
                      placeholder,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorConstant.grey60,
                    ),
              ),
            if (isExpanded != null && !isExpanded)
              value ??
                  CommonWidget.textPrimaryWidget(
                    placeholder,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: ColorConstant.grey60,
                  ),
            ...actions,
            if (isLoading != null) ...[
              if (isLoading)
                SizedBox(
                  height: SizeUtil.f(10),
                  width: SizeUtil.f(10),
                  child: CircularProgressIndicator(
                      color: ColorConstant.primary, strokeWidth: 1),
                ),
              if (!isLoading)
                Icon(Icons.keyboard_arrow_down,
                    size: SizeUtil.f(20), color: ColorConstant.grey90),
            ],
          ],
        ),
      ),
    );
  }

  static void showModal<T, E>({
    required List<T> data,
    required T? value,
    required E Function(T t) caption,
    required Function(T t) onSelect,
    String title = '',
  }) {
    var paddingHz = 24.0;
    var el = Get.width / Get.height;
    if (el > 1.3) {
      paddingHz = Get.width * .3;
    }

    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return Dialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: paddingHz, vertical: 24),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CommonWidget.textPrimaryWidget(
                          title,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: ColorConstant.grey90,
                        )),
                        InkWell(
                            onTap: Get.back,
                            child: Icon(Icons.close, size: SizeUtil.f(20))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ...data
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: InkWell(
                                onTap: () {
                                  onSelect(e);
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: value == e
                                        ? Border.all(
                                            color: ColorConstant.primary)
                                        : Border.all(
                                            color: ColorConstant.grey40),
                                  ),
                                  child: Row(
                                    children: [
                                      CommonWidget.textPrimaryWidget(
                                        '${caption(e)}',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstant.grey90,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
