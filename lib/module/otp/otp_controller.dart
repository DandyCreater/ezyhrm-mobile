import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/auth/login/login_service.dart';
import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/instance/instance_controller.dart';
import 'package:ezyhr_mobile_apps/module/notification/notification_service.dart';
import 'package:ezyhr_mobile_apps/module/otp/input_otp_page.dart';
import 'package:ezyhr_mobile_apps/module/otp/otp_service.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpC extends Bindings {
  static const route = '/otp';
  static final page = GetPage(
    name: route,
    page: () => const InputOtpScreen(),
    binding: OtpC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}

class OtpController extends GetxController {
  final sessionService = SessionService.instance;

  @override
  void onInit() {
    super.onInit();
    otpController.addListener(() {
      validateOtp(otpController.text);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    otpController.dispose();

    super.onClose();
  }

  final countdownDuration = 360;

  final _otpService = OtpService.instance;
  final _loginService = LoginService.instance;
  final _notificationService = NotificationService.instance;
  final _countdown = RxInt(0);
  final _sessionService = SessionService.instance;
  int get countdown => _countdown.value;
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final otpTx = TextEditingController();

  final otpController = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;

  final digitController = TextEditingController();

  void doVerifyOtp() async {
    validateOtp(otpController.text);
    if (error.value == "" && otpController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final OtpResponse response = await _otpService.otpVerificationV2(
          _sessionService.getEmail() ?? '',
          otpController.text,
        );
        sessionService.saveOtpResponse(response);
        sessionService.saveToken(response.result.accessToken);

        sessionService.saveIsLoggedIn(true);
        if (response.result.instances.isEmpty) {
          CommonWidget.showErrorNotif('No Entity Found');
          return;
        } else if (response.result.instances.length == 1) {
          sessionService.saveSelectedInstance(response.result.instances[0]);

          _notificationService.setExternalUserId(
            response.result.instances[0].instanceCode.toString(),
            sessionService.getEmployeeId().toString(),
          );

          RouteUtil.offAll(DashboardC.route);
          return;
        } else {
          sessionService.saveInstances(response.result.instances);
          sessionService.saveSelectedInstance(response.result.instances[0]);

          RouteUtil.to(
            InstanceC.route,
            arguments: {'instances': response.result.instances},
          );
          return;
        }
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      CommonWidget.showErrorNotif('Please enter OTP');
      error.value = "Please enter OTP";
    }

    log('error.value: ${error.value}');
  }

  String? validateOtp(String value) {
    if (value.isEmpty || value == "") {
      error.value = 'Please enter OTP';
    } else {
      error.value = "";
      return null;
    }
    return null;
  }
}
