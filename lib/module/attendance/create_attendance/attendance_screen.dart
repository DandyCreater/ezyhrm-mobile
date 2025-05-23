import 'package:ezyhr_mobile_apps/module/attendance/create_attendance/attendance_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/theme/theme.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Attendance',
      ),
      floatingActionButton: Container(
        width: Get.width * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => CustomFilledButton(
                width: double.infinity,
                title: controller.isUserCheckin() ? 'Clock In' : 'Clock Out',
                onPressed: () {
                  if (!controller.isLoading.value ||
                      !controller.isLocation.value) {
                    controller.doAttend();
                  } else {
                    CommonWidget.showErrorNotif(
                        "Please wait for process to finish loading");
                  }
                },
                color: controller.isUserCheckin() ? greenColor : redColor,
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return CommonWidget.expandedScrollWidget(
      physics: AlwaysScrollableScrollPhysics(),
      top: [
        attendanceWidget(),
      ],
    );
  }

  Widget headerWidget() {
    return Stack(
      children: [
        Container(
          height: SizeUtil.f(150),
          width: Get.width,
          decoration: const BoxDecoration(
            color: Color(0xff8bbf5a),
          ),
        ),
        Positioned(
          right: 0,
          child: CommonWidget.imageWidget(
            path: 'assets/images/vector.png',
            imgPathType: ImgPathType.asset,
            fit: BoxFit.fill,
            width: Get.width,
            height: 250,
            isFlexible: true,
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: SizeUtil.f(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: SizeUtil.f(4)),
                              CommonWidget.textPrimaryWidget(
                                'Attendance',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeUtil.f(14)),
                        CommonWidget.textPrimaryWidget(
                          'Please complete the form below to continue request.',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget attendanceWidget() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          width: Get.width,
          decoration: CommonWidget.defBoxDecoration(),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: greenColor,
                    size: 16,
                  ),
                  SizedBox(width: SizeUtil.f(4)),
                  CommonWidget.textPrimaryWidget(
                    'Location',
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: greenColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      'IP Address',
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    const Spacer(),
                    CommonWidget.textPrimaryWidget(
                      '${controller.ipAdd.value}',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      'Latitude',
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    const Spacer(),
                    controller.latitude.value == 0.0
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 63,
                              height: 18,
                              decoration: ShapeDecoration(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          )
                        : CommonWidget.textPrimaryWidget(
                            "${controller.latitude.value}",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      'Longitude',
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    const Spacer(),
                    controller.latitude.value == 0.0
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 63,
                              height: 18,
                              decoration: ShapeDecoration(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          )
                        : CommonWidget.textPrimaryWidget(
                            "${controller.longitude.value}",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    CommonWidget.textPrimaryWidget(
                      'Address',
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    Spacer(),
                    controller.address.value == ''
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 63,
                              height: 18,
                              decoration: ShapeDecoration(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          )
                        : Flexible(
                            child: CommonWidget.textPrimaryWidget(
                              '${controller.address.value}',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => controller.chooseImage(),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
                        width: double.infinity,
                        decoration: CommonWidget.defBoxDecoration(),
                        child: Column(
                          children: [
                            Obx(
                              () {
                                if (controller.imgType.value == ImgType.file) {
                                  return Container(
                                    child: Stack(
                                      children: [
                                        CommonWidget.imageWidget(
                                          path: controller.imgPath.value,
                                          imgPathType: ImgPathType.file,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.mode_edit_outline_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (controller.imgType.value ==
                                    ImgType.network) {
                                  return ClipOval(
                                    child: CommonWidget.imageWidget(
                                      path: controller.imgPath.value,
                                      imgPathType: ImgPathType.network,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      withBaseEndpoint: false,
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 32),
                                      SizedBox(height: SizeUtil.f(16)),
                                      CommonWidget.imageWidget(
                                        imgPathType: ImgPathType.asset,
                                        path: 'assets/svgs/camera.svg',
                                        width: 25,
                                        height: 25,
                                      ),
                                      SizedBox(height: SizeUtil.f(16)),
                                      CommonWidget.textPrimaryWidget(
                                        'Take Photo',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: greenColor,
                                      ),
                                      SizedBox(height: SizeUtil.f(16)),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
