import 'package:ezyhr_mobile_apps/module/dahboard/dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/instance/instance_controller.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstancePage extends GetView<InstanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 184,
                height: 184,
                margin: const EdgeInsets.only(
                  top: 80,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/img_input_otp.png',
                    ),
                  ),
                ),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 286,
                    child: Text(
                      'Select Instance',
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
                                'We detected multiple Instance for your account. Please select the role you want to use.',
                            style: TextStyle(
                              color: Color(0xFFAFAFAF),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.5,
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
          Obx(
            () => controller.instances.value == null
                ? CircularProgressIndicator()
                : FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Text(
                      controller.getInstanceByCode(
                          controller.selectedInstance.value?.instanceCode ??
                              "IF"),
                      style: TextStyle(
                        color: ColorConstant.black60,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      Icon(Icons.keyboard_arrow_down,
                          size: SizeUtil.f(20), color: ColorConstant.grey90),
                    ],
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      FieldModalWidget.showModal<Instance, String>(
                        data: controller.instances.value ?? [],
                        caption: (e) => controller
                            .getInstanceByCode(e.instanceCode ?? "IF"),
                        onSelect: (e) {
                          controller.setSelectInstance(e);
                        },
                        value: controller.selectedInstance.value,
                        title: 'Select Instance',
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24),
          CustomFilledButton(
            width: double.infinity,
            title: 'Confirm',
            onPressed: () {
              RouteUtil.offAll(DashboardC.route);
            },
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
            'Keep this window open while you check your mailbox, then type the mentioned code above.',
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
