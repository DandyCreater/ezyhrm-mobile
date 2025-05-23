import 'package:ezyhr_mobile_apps/module/profile/app_info/app_info_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfoPage extends GetView<AppInfoController> {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior()
              .copyWith(overscroll: true, scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonWidget.fieldAndValue(
              'App Name',
              controller.appName.value ?? '',
              null,
              false,
            ),
            CommonWidget.fieldAndValue(
              'Version',
              controller.version.value ?? '',
              null,
              false,
            ),
            CommonWidget.fieldAndValue(
              'Build Number',
              controller.buildNumber.value ?? '',
              null,
              false,
            ),
          ],
        ),
      ),
    );
  }
}
