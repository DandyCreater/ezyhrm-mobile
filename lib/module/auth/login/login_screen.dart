import 'package:ezyhr_mobile_apps/module/auth/login/login_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/theme/design_system.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return CommonWidget.expandedScrollWidget(
      physics: const BouncingScrollPhysics(),
      crossAlign: CrossAxisAlignment.center,
      overscroll: true,
      top: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          height: 208,
          margin: const EdgeInsets.only(
            top: 130,
            bottom: 10,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/img_otp_login.png',
              ),
            ),
          ),
        ),
        Column(
          children: [
            CommonWidget.textPrimaryWidget(
              'Login with OTP',
              color: ColorConstant.black60,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const SizedBox(height: 12),
            CommonWidget.textPrimaryWidget(
              'Please enter the details below to continue.',
              color: ColorConstant.grey60,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              softWrap: true,
              align: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 32),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtil.f(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignSystem.formLabel(
                label: 'Email',
                isRequired: true,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: DesignSystem.inputDecoration(
                    hintText: 'Input Your Email',
                    leftIcon: 'assets/svgs/Message.svg',
                    errorText: controller.emailError.value == ""
                        ? null
                        : controller.emailError.value,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.emailController,
                  validator: (value) {
                    return controller.emailValidator(value ?? "");
                  },
                ),
              ),
              const SizedBox(height: 16),
              DesignSystem.formLabel(
                label: 'Password',
                isRequired: true,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: DesignSystem.inputDecoration(
                    hintText: 'Input Your Password',
                    errorText: controller.passwordError.value == ""
                        ? null
                        : controller.passwordError.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value;
                      },
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.passwordController,
                  validator: (value) {
                    return controller.passwordValidator(value ?? "");
                  },
                  obscureText: controller.isPasswordVisible.value,
                ),
              ),
              const SizedBox(height: 16),
              CustomFilledButton(
                width: double.infinity,
                title: 'Login',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  if (!controller.isLoading.value) controller.doLogin(context);
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  controller.authenticate();
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 25,
                    child: CommonWidget.imageWidget(
                      path: 'assets/svgs/face_id.svg',
                      imgPathType: ImgPathType.asset,
                      height: 20,
                      width: double.infinity,
                    )),
              ),
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }
}
