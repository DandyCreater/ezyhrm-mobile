import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/notification/notification_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/module/instance/instance_page.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstanceC extends Bindings {
  static const route = '/instance';
  static final page = GetPage(
    name: route,
    page: () => InstancePage(),
    binding: InstanceC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<InstanceController>(() => InstanceController());
  }
}

class InstanceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  BuildContext? context;
  final _sessionService = SessionService.instance;
  final _notificationService = NotificationService.instance;
  final instances = Rxn<List<Instance>>();
  final selectedInstance = Rxn<Instance>();
  @override
  void onReady() {
    instances.value = Get.arguments['instances'];
    selectedInstance.value = Get.arguments['instances'][0];
    log('instances: $instances');
    super.onReady();
  }

  void setSelectInstance(Instance instance) {
    selectedInstance.value = instance;
    _sessionService.saveSelectedInstance(instance);
    _notificationService.setExternalUserId(instance.instanceCode ?? "",
        _sessionService.getEmployeeId().toString());
  }

  String getInstanceByCode(String instanceCode) {
    if (instanceCode == "IF") {
      return "Infoworks";
    } else if (instanceCode == "PR") {
      return "Projects";
    } else if (instanceCode == "CTR") {
      return "Contracts";
    } else if (instanceCode == "CST") {
      return "Consultants";
    } else if (instanceCode == "SL") {
      return "Solusi";
    } else if (instanceCode == "LTE") {
      return "LTE";
    } else if (instanceCode == "SG") {
      return "RMA Singapore";
    } else if (instanceCode == "MY") {
      return "RMA Malaysia";
    } else if (instanceCode == "VN") {
      return "RMA Vietnam";
    } else if (instanceCode == "ID") {
      return "RMA Indonesia";
    } else if (instanceCode == "SL") {
      return "Solusi";
    } else if (instanceCode == "IF") {
      return "Infoworks";
    }
    return instanceCode;
  }
}
