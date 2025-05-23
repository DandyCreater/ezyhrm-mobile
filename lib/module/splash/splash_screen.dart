import 'package:ezyhr_mobile_apps/module/splash/splash_controller.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/theme/theme.dart';

class SplashScreen extends GetView<SplashC> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonUtil.unFocus(context: context);

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Container(
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ezyhr_logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
