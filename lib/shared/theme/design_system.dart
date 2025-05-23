import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class DesignSystem {
  static formLabel({
    String? label,
    bool? isRequired,
  }) {
    return Row(
      children: [
        CommonWidget.textPrimaryWidget(
          label ?? '',
          color: ColorConstant.black60,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        isRequired == true
            ? CommonWidget.textPrimaryWidget(
                '*',
                fontSize: 16,
                color: ColorConstant.red60,
              )
            : Container(),
      ],
    );
  }

  static inputDecoration({
    String? leftIcon,
    String? hintText,
    String? labelText,
    String? helperText,
    String? errorText,
    bool? isDense,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hintText ?? '',
      hintStyle: lightTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorText: errorText ?? null,
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFD8D8D8),
        ),
      ),
      suffixIcon: suffixIcon,
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
    );
  }
}
