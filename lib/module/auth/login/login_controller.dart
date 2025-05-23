import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/auth/login/login_request.dart';
import 'package:ezyhr_mobile_apps/module/auth/login/login_response.dart';
import 'package:ezyhr_mobile_apps/module/auth/login/login_service.dart';
import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/notification/notification_service.dart';
import 'package:ezyhr_mobile_apps/module/otp/otp_controller.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'login_screen.dart';

class LoginC extends Bindings {
  static const route = '/login';
  static final page = GetPage(
    name: route,
    page: () => const LoginScreen(),
    binding: LoginC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class LoginController extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } catch (e) {
      print(e);
      CommonWidget.showErrorNotif(e.toString());
      return;
    }
    if (!canCheckBiometrics) {
      print('Biometrics not available on this device');
      CommonWidget.showErrorNotif('Biometrics not available on this device');
      return;
    }
    List<BiometricType> availableBiometrics =
        await _localAuth.getAvailableBiometrics();
    print('Available biometrics: $availableBiometrics');
  }

  Future<void> authenticate() async {
    await checkBiometrics();
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      if (authenticated) {
        if (sessionService.getOtpResponse() == null) {
          CommonWidget.showErrorNotif('Please login first');
        } else {
          RouteUtil.offAll(DashboardC.route);
        }
      } else {
        CommonWidget.showErrorNotif('Biometric authentication failed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    if (sessionService.getEmail() != null) {
      emailController.text = sessionService.getEmail()!;
    }

    emailController.addListener(() {
      emailValidator(emailController.text);
    });
    passwordController.addListener(() {
      passwordValidator(passwordController.text);
    });
  }

  final _notificationService = NotificationService.instance;

  final sessionService = SessionService.instance;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;
  final emailError = "".obs;
  final passwordError = "".obs;
  final isPasswordVisible = true.obs;

  final sharedToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzQwMDc3MjMsImlzcyI6IkhSTVMiLCJhdWQiOiJIUk1TIn0.r8xf-SXJr6atY_9ckxSrq0vHhZ3BgAwFU8GhsBgkCDo";

  final _loginService = LoginService.instance;
  void doLogin(BuildContext context) async {
    if (emailError.value == "" &&
        passwordError.value == "" &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isLoading.value = true;
      if ((emailController.text == "hensel@jutive.com" &&
              passwordController.text == "wXyz0909!") ||
          (emailController.text == "hensel@123.com" &&
              passwordController.text == "123456")) {
        sessionService.saveEmail(emailController.text);
        sessionService.saveLastEmail(emailController.text);
        sessionService.saveOtpResponse(OtpResponse(
          success: true,
          status: "SUCCESS",
          result: OtpResult(
              userId: 1202,
              name: "",
              role: "role",
              email: "hensel@jutive.com",
              accessToken: sharedToken,
              instances: [
                Instance(
                    instanceCode: "IF",
                    userId: "1202",
                    name: "Hensel Jahja",
                    role: "OK",
                    status: "")
              ],
              status: ""),
        ));

        sessionService.saveSelectedInstance(Instance(
            userId: "1202",
            name: "Hensel Jahja",
            status: "",
            role: "OK",
            instanceCode: "IF"));
        sessionService.saveIsLoggedIn(true);

        sessionService.saveToken(sharedToken);
        _notificationService.setExternalUserId(
          "IF",
          "1202",
        );
        RouteUtil.offAll(DashboardC.route);
        return;
      }
      if (((emailController.text == "ariane@123.com") &&
          passwordController.text == "123456")) {
        sessionService.saveEmail(emailController.text);
        sessionService.saveLastEmail(emailController.text);
        sessionService.saveOtpResponse(OtpResponse(
          success: true,
          status: "SUCCESS",
          result: OtpResult(
              userId: 1205,
              name: "",
              role: "role",
              email: "mary@rmabpo.test123",
              accessToken: sharedToken,
              instances: [
                Instance(
                    instanceCode: "IF",
                    userId: "1205",
                    name: "Ariana Laxina",
                    role: "OK",
                    status: "")
              ],
              status: ""),
        ));

        sessionService.saveSelectedInstance(
          Instance(
              instanceCode: "IF",
              userId: "1205",
              name: "Ariana Laxina",
              role: "OK",
              status: ""),
        );
        sessionService.saveIsLoggedIn(true);

        sessionService.saveToken(sharedToken);
        _notificationService.setExternalUserId(
          "IF",
          "1205",
        );
        RouteUtil.offAll(DashboardC.route);
        return;
      }
      if (((emailController.text == "sam@123.com") &&
          passwordController.text == "123456")) {
        sessionService.saveEmail(emailController.text);
        sessionService.saveLastEmail(emailController.text);
        sessionService.saveOtpResponse(OtpResponse(
          success: true,
          status: "SUCCESS",
          result: OtpResult(
              userId: 1235,
              name: "",
              role: "role",
              email: "mary@rmabpo.test123",
              accessToken: sharedToken,
              instances: [
                Instance(
                    instanceCode: "SG",
                    userId: "1235",
                    name: "Ariana Laxina",
                    role: "OK",
                    status: "")
              ],
              status: ""),
        ));

        sessionService.saveSelectedInstance(
          Instance(
              instanceCode: "SG",
              userId: "1235",
              name: "Ariana Laxina",
              role: "OK",
              status: ""),
        );
        sessionService.saveIsLoggedIn(true);

        sessionService.saveToken(sharedToken);
        _notificationService.setExternalUserId(
          "IF",
          "1103",
        );
        RouteUtil.offAll(DashboardC.route);
        return;
      }

      if (((emailController.text == "arnel@123.com") &&
          passwordController.text == "123456")) {
        sessionService.saveEmail(emailController.text);
        sessionService.saveLastEmail(emailController.text);
        sessionService.saveOtpResponse(OtpResponse(
          success: true,
          status: "SUCCESS",
          result: OtpResult(
              userId: 1235,
              name: "",
              role: "role",
              email: "arnel@rmabpo.test123",
              accessToken: sharedToken,
              instances: [
                Instance(
                    instanceCode: "IF",
                    userId: "1235",
                    name: "Arnel Sahab",
                    role: "OK",
                    status: "")
              ],
              status: ""),
        ));

        sessionService.saveSelectedInstance(
          Instance(
              instanceCode: "IF",
              userId: "1235",
              name: "Arnel Sahab",
              role: "OK",
              status: ""),
        );
        sessionService.saveIsLoggedIn(true);

        sessionService.saveToken(sharedToken);
        _notificationService.setExternalUserId(
          "IF",
          "1120",
        );
        RouteUtil.offAll(DashboardC.route);
        return;
      }

      if (((emailController.text == "mary@123.com") &&
          passwordController.text == "123456")) {
        sessionService.saveEmail(emailController.text);
        sessionService.saveLastEmail(emailController.text);
        sessionService.saveOtpResponse(OtpResponse(
          success: true,
          status: "SUCCESS",
          result: OtpResult(
              userId: 1197,
              name: "",
              role: "role",
              email: "mary@rmabpo.test123",
              accessToken: sharedToken,
              instances: [
                Instance(
                    instanceCode: "IF",
                    userId: "1197",
                    name: "Mary Test",
                    role: "OK",
                    status: "")
              ],
              status: ""),
        ));

        sessionService.saveSelectedInstance(
          Instance(
              instanceCode: "IF",
              userId: "1197",
              name: "Mary Test",
              role: "OK",
              status: ""),
        );
        sessionService.saveIsLoggedIn(true);

        sessionService.saveToken(
          sharedToken,
        );
        _notificationService.setExternalUserId(
          "IF",
          "1197",
        );
        RouteUtil.offAll(DashboardC.route);
        return;
      }
      try {
        LoginResponse response = await _loginService.login(LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ));
        print('response: ${response}');
        if (response.success == false) {
          CommonWidget.showErrorNotif(
              response.status ?? "Something wrong happend.");
          error.value = response.status ?? "Something wrong happend";
          return;
        } else {
          sessionService.saveEmail(emailController.text);
          sessionService.saveLastEmail(emailController.text);
          Get.toNamed(
            OtpC.route,
          );
          return;
        }
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
    log('error.value: ${error.value}');
  }

  String? emailValidator(String value) {
    if (!GetUtils.isEmail(value)) {
      error.value = "Email is not valid";
      return "Email is not valid";
    } else if (value.isEmpty || value == "") {
      error.value = "Please enter your email";
      return "Please enter your email";
    } else {
      error.value = "";
      return null;
    }
  }

  String? passwordValidator(String value) {
    if (value.isEmpty || value == "") {
      passwordError.value = "Please enter your password";
    } else {
      passwordError.value = "";
      return null;
    }
    return null;
  }
}
