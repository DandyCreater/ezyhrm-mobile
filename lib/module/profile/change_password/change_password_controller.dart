import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_request.dart';
import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordC extends Bindings {
  static const route = '/changePassword';
  static final page = GetPage(
    name: route,
    page: () => const ChangePasswordPage(),
    binding: ChangePasswordC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final changePasswordService = ChangePasswordService.instance;
  final _sessionService = SessionService.instance;

  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> onSubmit() async {
    if (formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        CommonWidget.showErrorNotif(
            "New password and confirm password not match");
        return;
      }
      try {
        isLoading.value = true;
        final res =
            await changePasswordService.changePassword(ChangePasswordRequest(
          email: _sessionService.getEmail() ?? "",
          oldpass: currentPasswordController.text,
          newpass: newPasswordController.text,
        ));
        if (res.success == false) {
          CommonWidget.showErrorNotif(res.status ?? "");
        } else {
          CommonWidget.showNotif("Password changed successfully");
          Get.back();
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
