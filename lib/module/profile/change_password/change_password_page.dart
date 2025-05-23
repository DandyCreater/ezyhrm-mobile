import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/theme/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Change Password',
        isBack: true,
        bgColor: Colors.white,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior()
            .copyWith(overscroll: true, scrollbars: false),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _form(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.textPrimaryWidget(
              "Change Password",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 4,
            ),
            CommonWidget.textPrimaryWidget(
              "Your password must be at least 6 characters and should include combination of numbers, letters and special characters.",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFAFAFAF),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  "Current Password",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CommonWidget.textPrimaryWidget(
                  " *",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.currentPasswordController,
                decoration: DesignSystem.inputDecoration(
                  hintText: 'Input current password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isCurrentPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isCurrentPasswordVisible.value =
                          !controller.isCurrentPasswordVisible.value;
                    },
                  ),
                ),
                obscureText: controller.isCurrentPasswordVisible.value,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  "New Password",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CommonWidget.textPrimaryWidget(
                  " *",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.newPasswordController,
                decoration: DesignSystem.inputDecoration(
                  hintText: 'Input new password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isNewPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isNewPasswordVisible.value =
                          !controller.isNewPasswordVisible.value;
                    },
                  ),
                ),
                obscureText: controller.isNewPasswordVisible.value,
                validator: (value) {
                  return controller.changePasswordService
                      .isPasswordValid(value ?? "");
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                CommonWidget.textPrimaryWidget(
                  "Confirm New Password",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CommonWidget.textPrimaryWidget(
                  " *",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.confirmPasswordController,
                decoration: DesignSystem.inputDecoration(
                  hintText: 'Confirm new password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isConfirmPasswordVisible.value =
                          !controller.isConfirmPasswordVisible.value;
                    },
                  ),
                ),
                obscureText: controller.isConfirmPasswordVisible.value,
                validator: (value) {
                  return controller.changePasswordService
                      .isPasswordValid(value ?? "");
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Obx(
              () => CustomFilledButton(
                title: 'Change Password',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.onSubmit();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
