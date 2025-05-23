import 'dart:developer';
import 'dart:io';

import 'package:ezyhr_mobile_apps/module/attendance/attendance_service.dart';
import 'package:ezyhr_mobile_apps/module/attendance/face_detection_service.dart';
import 'package:ezyhr_mobile_apps/module/file/file_service.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/app_info/app_info_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/change_password/change_password_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/nhc_form_details_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_dto.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_hrms_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/profile_service.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_screen.dart';

class ProfileC extends Bindings {
  static const route = '/profile';
  static final page = GetPage(
    name: route,
    page: () => const ProfileScreen(),
    binding: ProfileC(),
  );

  @override
  void dependencies() {}
}

class ProfileController extends GetxController {
  final isLoading = false.obs;
  final profileService = ProfileService.instance;
  final sessionService = SessionService.instance;
  final attendanceService = AttendanceService.instance;
  final FaceDetectionService _faceDetectionService = FaceDetectionService();

  final profileHrms = Rxn<ProfileHrmsResponse>();
  final fileUploadService = FileUploadService.instance;
  final nhcFormDetails = Rxn<NhcFormDetailsResponse>();

  final profilePicture =
      RxString("https://ezyhr.rmagroup.com.sg/img/blank.png");
  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    OtpResponse? otpResponse = sessionService.getOtpResponse();
    print("otpResponse: ${otpResponse?.toJson()}");
    getProfile();
    getNhcFormDetails();
  }

  void getProfile() async {
    try {
      isLoading.value = true;
      print("sessionService.getEmployeeId() ${sessionService.getEmployeeId()}");
      final response =
          await profileService.getProfileHrms(sessionService.getEmployeeId());
      final profilePictureResponse = await profileService
          .getProfilePicture(sessionService.getEmployeeId());
      profileHrms.value = response;
      profilePicture.value = profilePictureResponse!;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void getPict() async {
    try {
      isLoading.value = true;
      final response = await profileService
          .getProfilePicture(sessionService.getEmployeeId());
      profilePicture.value = response!;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    sessionService.saveIsLoggedIn(false);
    Get.offAllNamed('/login');
  }

  final imgPath = ''.obs;
  final imgType = ImgType.svg.obs;
  File? imgFile;
  final imgPhSvg = 'assets/svgs/ic_upload_cloud.svg';

  void chooseImage() {
    CommonUtil.unFocus();
    CommonWidget.chooseImage(
      onChoose: (XFile? file) async {
        if (file != null) {
          imgPath.value = file.path;
          imgFile = File(file.path);
          imgType.value = ImgType.file;
          updateProfile(file.path);
        } else {
          imgPath.value = imgPhSvg;
          imgFile = null;
          imgType.value = ImgType.svg;
        }
      },
      showGallery: true,
      showDelete: false,
    );
  }

  Future<void> updateProfile(String imgPath) async {
    log('imgPath: $imgPath');
    if (imgPath != '') {
      try {
        isLoading.value = true;
        log('before error 1');
        final isFacePresentResponse =
            await _faceDetectionService.isFacePresent(imgPath);
        if (!isFacePresentResponse) {
          log('before error 2222');
          CommonWidget.showErrorNotif("Face not detected, please try again.");
          return;
        }
        log('before error 2');
        final response = await fileUploadService.updateProfilePicture(
            imgPath, sessionService.getEmployeeId());

        log('before error 3');
        CommonWidget.showNotif("Success updating profile picture");
        return;
      } catch (e) {
        log('before error' + e.toString());
        CommonWidget.showErrorNotif("Failed to upload Image");
        log('after error');
        // print('error: $e');
        log('error: $e');
        return;
      } finally {
        getPict();
      }
    } else {
      CommonWidget.showErrorNotif("Please select image");
      return;
    }
  }

  void getNhcFormDetails() async {
    try {
      isLoading.value = true;
      final response = await profileService.getNhcFormDetails(
        sessionService.getEmployeeId(),
      );
      nhcFormDetails.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  final menuList = Rxn<List<ProfileDto>>([
    ProfileDto(
      label: "Personal Details",
      icon: const Icon(
        Icons.person,
        size: 24,
      ),
      route: () => RouteUtil.to(PersonalDetailsC.personalDetailsPageRoute),
    ),
    ProfileDto(
      label: "Address",
      icon: const Icon(
        Icons.home,
        size: 24,
      ),
      route: () => Get.toNamed(PersonalDetailsC.addressPageRoute),
    ),
    ProfileDto(
      label: "Contribution and Donation",
      icon: const Icon(
        Icons.favorite,
        size: 24,
      ),
      route: () => Get.toNamed(PersonalDetailsC.contributionPageRoute),
    ),
    ProfileDto(
      label: "Next of Kin",
      icon: const Icon(
        Icons.people,
        size: 24,
      ),
      route: () => Get.toNamed(PersonalDetailsC.kinListPageRoute),
    ),
    ProfileDto(
      label: "Children Details",
      icon: const Icon(
        Icons.child_care,
        size: 24,
      ),
      route: () => Get.toNamed(PersonalDetailsC.childrenListPageRoute),
    ),
    ProfileDto(
      label: "Bank Account",
      icon: const Icon(
        Icons.account_balance,
        size: 24,
      ),
      route: () => Get.toNamed(PersonalDetailsC.bankAccountPageRoute),
    ),
  ]);
  final settingList = Rxn<List<ProfileDto>>([
    ProfileDto(
      label: "Change Password",
      icon: const Icon(
        Icons.lock,
        size: 24,
      ),
      route: () => Get.toNamed(ChangePasswordC.route),
    ),
    ProfileDto(
      label: "App Info",
      icon: const Icon(
        Icons.info,
        size: 24,
      ),
      route: () => Get.toNamed(
        AppInfoC.route,
      ),
    ),
  ]);
}
