import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constant/color_constant.dart';
import '../../shared/utils/size_util.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Profile',
        isBack: false,
        bgColor: Color(0xFFD8EAC8),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: RefreshIndicator(
        color: ColorConstant.primary,
        onRefresh: () => controller.getData(),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior()
              .copyWith(overscroll: true, scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                headerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: SizeUtil.f(250),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD8EAC8),
            ),
          ),
        ),
        Container(
          color: ColorConstant.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
            child: Column(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.chooseImage();
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller.profilePicture.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    decoration: CommonWidget.defBoxDecoration(
                      bgColor: Colors.white,
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          _information(
                            'Name',
                            controller.profileHrms.value?.employeeName == null
                                ? "-"
                                : controller.profileHrms.value?.employeeName ??
                                    '-',
                            controller.isLoading.value,
                          ),
                          const SizedBox(height: 8),
                          _information(
                            'Job',
                            controller.nhcFormDetails.value?.result
                                    ?.employeeDetailsModel?.jobTitle ??
                                "-",
                            controller.isLoading.value,
                          ),
                          const SizedBox(height: 8),
                          _information(
                            'Departement',
                            controller.nhcFormDetails.value?.result
                                    ?.employeeDetailsModel?.department ??
                                "-",
                            controller.isLoading.value,
                          ),
                          const SizedBox(height: 8),
                          _information(
                            'Employee Id',
                            controller.profileHrms.value?.employeeId == null
                                ? "-"
                                : controller.profileHrms.value?.employeeId ??
                                    '-',
                            controller.isLoading.value,
                          ),
                          const SizedBox(height: 8),
                          _information(
                            'Email',
                            controller.profileHrms.value?.email == null
                                ? "-"
                                : controller.profileHrms.value?.email ?? '-',
                            controller.isLoading.value,
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: SizeUtil.f(16)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ...controller.menuList.value!
                          .map(
                            (e) => InkWell(
                              onTap: e.route,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 0,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 0,
                                ),
                                child: Row(
                                  children: [
                                    e.icon ?? Container(),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CommonWidget.textPrimaryWidget(
                                            e.label ?? '',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_sharp,
                                              color: Colors.black,
                                              size: SizeUtil.f(24)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: SizeUtil.f(16)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ...controller.settingList.value!
                          .map(
                            (e) => InkWell(
                              onTap: e.route,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 0,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 0,
                                ),
                                child: Row(
                                  children: [
                                    e.icon ?? Container(),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CommonWidget.textPrimaryWidget(
                                            e.label ?? '',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_sharp,
                                              color: Colors.black,
                                              size: SizeUtil.f(24)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: SizeUtil.f(16)),
                InkWell(
                  onTap: () {
                    controller.logout();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 74,
                      vertical: 12,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFF2C20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _information(String label, String value, bool isLoading) {
    return Row(
      children: [
        CommonWidget.textPrimaryWidget(
          label,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
        ),
        const Spacer(),
        isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: Get.width * .35,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            : CommonWidget.textPrimaryWidget(
                value ?? '',
                color: ColorConstant.grey70,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
      ],
    );
  }
}
