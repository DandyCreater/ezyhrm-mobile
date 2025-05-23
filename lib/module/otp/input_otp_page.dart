import 'package:ezyhr_mobile_apps/module/otp/otp_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../widget/button.dart';

class InputOtpScreen extends GetView<OtpController> {
  const InputOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        '',
        bgColor: Colors.white,
        isBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 184,
                height: 184,
                margin: const EdgeInsets.only(top: 80, bottom: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/img_input_otp.png'),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 286,
                    child: Text(
                      'Input OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: 345,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Please enter your most recent 6 digit verification code on authenticator app.',
                            style: TextStyle(
                              color: Color(0xFFAFAFAF),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 2.5,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 34),
          Form(
            key: controller.otpFormKey,
            child: Center(
              child: Pinput(
                length: 6,
                controller: controller.otpController,
                onCompleted: (pin) {
                  if (!controller.isLoading.value) controller.doVerifyOtp();
                },
                inputFormatters: CommonUtil.inputFormatNumber(),
                validator: (val) =>
                    (val?.length ?? 0) < 6 ? 'Masukkan OTP' : null,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _windowOpenText(),
          const SizedBox(height: 24),
          Obx(
            () => CustomFilledButton(
              width: double.infinity,
              title: 'Verify',
              isLoading: controller.isLoading.value,
              onPressed: () async {
                if (!controller.isLoading.value) controller.doVerifyOtp();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _windowOpenText() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 345,
          child: Text(
            'Keep this window open while you check your authenticator, then type the mentioned code above.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
