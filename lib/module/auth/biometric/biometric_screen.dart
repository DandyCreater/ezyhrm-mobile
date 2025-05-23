import 'package:ezyhr_mobile_apps/module/auth/biometric/biometric_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/response/app_asset_res.dart';

class BiometricScreen extends StatelessWidget {
  final BiometricController _biometricController =
      Get.put(BiometricController());

  BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await _biometricController.checkBiometrics();
            if (_biometricController.isAuthenticated.value) {
              Get.offNamed('/home');
            } else {
              await _biometricController.authenticate();
              Get.offNamed('/home');
            }
          },
          child: SizedBox(
              width: double.infinity,
              height: 80,
              child: CommonWidget.imageWidget(
                path: 'assets/svgs/face_id.svg',
                imgPathType: ImgPathType.asset,
                height: 20,
                width: double.infinity,
              )),
        ),
      ),
    );
  }
}
