import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:ezyhr_mobile_apps/module/file/file_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/reimbursement_service.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/request/reimbursement_request.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/nhc_reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_options_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_response.dart';
import 'package:ezyhr_mobile_apps/module/reimbursement/response/reimbursement_type_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/common_constant.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'reimbursement_form_screen.dart';

class ReimbursementFormC extends Bindings {
  static const route = '/reimbursement-form';
  static final page = GetPage(
    name: route,
    page: () => const ReimbursementFormScreen(),
    binding: ReimbursementFormC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<ReimbursementFormController>(
        () => ReimbursementFormController());
  }
}

class ReimbursementFormController extends GetxController {
  final isLoading = true.obs;
  final sessionService = SessionService.instance;
  final fileUploadService = FileUploadService.instance;
  final reimbursmentService = ReimbursementService.instance;
  final amountController = TextEditingController();
  final error = ''.obs;
  final remarkController = TextEditingController();

  final reimbursmentTypeList = Rxn<List<ReimbursementTypeResponse>>();
  final reimbursmentType = Rxn<ReimbursementTypeResponse>();
  final selectedTypeOfReimbursement = Rxn<ReimbursementTypeResponse>();

  final reimbursementOptionList = Rxn<List<ReimbursementOptionsResponse>>();
  final selectedReimbursementOption = Rxn<ReimbursementOptionsResponse>();
  final claimOrRemark = "Claim".obs;

  final nhcReimbursement = Rxn<NhcReimbursementResponse>();
  final reimbursmentListNow = Rxn<List<ReimbursementResponse>>();
  final selectedCurrency = Rxn<Currency>(
    CurrencyService().findByCode('SGD'),
  );
  final incurredDate = Rxn<DateTime>();

  final imgPath = ''.obs;
  final imgType = ImgType.svg.obs;
  File? imgFile;
  BuildContext? context;

  final isTypeOfReimbursementSelected = RxBool(false);
  final isThereReimbursement = false.obs;

  final imgPhSvg = 'assets/svgs/ic_upload_cloud.svg';
  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onInit();
    amountController.dispose();
    remarkController.dispose();
  }

  void onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print('onDateSelectionChanged ${args.value}}');
    incurredDate.value = args.value;
  }

  void onConfirm(DateTime args) {
    incurredDate.value = args;
  }

  Future<void> getData() async {
    getReimbursementType();
  }

  String? amountValidator(String value) {
    if (!GetUtils.isNum(value)) {
      error.value = "Please input the correct amount";
      return "Please input the correct amount";
    } else if (value.isEmpty || value == "") {
      error.value = "Please Input Amount";
      return "Please Input Amount";
    } else if (double.parse(selectedReimbursementOption.value!.balance) <
        double.parse(value)) {
      error.value = "Amount must be less than or equal to balance";
      return "Amount must be less than or equal to balance";
    } else {
      error.value = "";
      return null;
    }
  }

  void setSelectedValue(ReimbursementOptionsResponse e) {
    selectedReimbursementOption.value = e;
    claimOrRemark.value = e.remarkOrBalance;
  }

  void getReimbursementType() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getReimbursementType();
      final response2 = await reimbursmentService.getReimbursementFilter(
        sessionService.getEmployeeId(),
        DateTime.now().month,
        DateTime.now().year,
        4,
      );
      final response3 = await reimbursmentService.getNhcReimbursement(
        sessionService.getEmployeeId(),
      );
      nhcReimbursement.value = response3;
      reimbursmentListNow.value = response2;
      reimbursmentTypeList.value = response;

      final reimbursmentTypeListTemp =
          List<ReimbursementOptionsResponse>.empty(growable: true);
      if (nhcReimbursement.value?.result?.allowanceAmountType != null) {
        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountCommunication ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Communication",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Communication"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountCommunication ??
                          "0") -
                      int.parse(getApprovedAmmount("Communication")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeCommunication ??
                  "Claim"));
        }
        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountDental ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Dental",
                orElse: () => ReimbursementTypeResponse(id: -1, name: "Dental"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountDental ??
                          "0") -
                      int.parse(getApprovedAmmount("Dental")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeDental ??
                  "Claim"));
        }
        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountMealallowance ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Meal",
                orElse: () => ReimbursementTypeResponse(id: -1, name: "Meal"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountMealallowance ??
                          "0") -
                      int.parse(getApprovedAmmount("Meal")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeMealallowance ??
                  "Claim"));
        }
        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountCounterfixed ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "CounterFixed",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Counter Fixed"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountCounterfixed ??
                          "0") -
                      int.parse(getApprovedAmmount("Fixed")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeCounterfixed ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement.value?.result?.allowanceAmountType
                    ?.amountCountervariable ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "CounterVariable",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Counter Variable"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountCountervariable ??
                          "0") -
                      int.parse(getApprovedAmmount("CounterVariable")))
                  .toString(),
              remarkOrBalance: nhcReimbursement.value?.result
                      ?.allowanceAmountType?.typeCountervariable ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountEntertainment ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Entertainment",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Entertainment"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountEntertainment ??
                          "0") -
                      int.parse(getApprovedAmmount("Entertainment")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeEntertainment ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountGroceries ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Groceries",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Groceries"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountGroceries ??
                          "0") -
                      int.parse(getApprovedAmmount("Groceries")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeGroceries ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountHousingfixed ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "HousingFixed",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Housing Fixed"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountHousingfixed ??
                          "0") -
                      int.parse(getApprovedAmmount("HousingFixed")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeHousingfixed ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountMedical ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Medical",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Medical"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountMedical ??
                          "0") -
                      int.parse(getApprovedAmmount("Medical")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeMedical ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountMileage ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Mileage",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Mileage"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountMileage ??
                          "0") -
                      int.parse(getApprovedAmmount("Mileage")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeMileage ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement.value?.result?.allowanceAmountType
                    ?.amountMobileallowance ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "MobileAllowance",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Mobile Allowance"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountMobileallowance ??
                          "0") -
                      int.parse(getApprovedAmmount("MobileAllowance")))
                  .toString(),
              remarkOrBalance: nhcReimbursement.value?.result
                      ?.allowanceAmountType?.typeMobileallowance ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountMvcvariable ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "MVCVariable",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Mvc Variable"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountMvcvariable ??
                          "0") -
                      int.parse(getApprovedAmmount("MVCVariable")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeMvcvariable ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement.value?.result?.allowanceAmountType
                    ?.amountNightcourtfixed ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "NightCourtFixed",
                orElse: () => ReimbursementTypeResponse(
                    id: -1, name: "Night Court Fixed"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountNightcourtfixed ??
                          "0") -
                      int.parse(getApprovedAmmount("NightCourtFixed")))
                  .toString(),
              remarkOrBalance: nhcReimbursement.value?.result
                      ?.allowanceAmountType?.typeNightcourtfixed ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountOutpatient ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "OutPatient",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Out Patient"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountOutpatient ??
                          "0") -
                      int.parse(getApprovedAmmount("OutPatient")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeOutpatient ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountOvertime ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Overtime",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Overtime"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountOvertime ??
                          "0") -
                      int.parse(getApprovedAmmount("Overtime")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeOvertime ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountShiftallowance ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "ShiftAllowance",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Shift Allowance"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountShiftallowance ??
                          "0") -
                      int.parse(getApprovedAmmount("ShiftAllowance")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeShiftallowance ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountStationeries ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "Stationeries",
                orElse: () =>
                    ReimbursementTypeResponse(id: -1, name: "Stationeries"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountStationeries ??
                          "0") -
                      int.parse(getApprovedAmmount("Stationeries")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeStationeries ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement
                    .value?.result?.allowanceAmountType?.amountTransportfixed ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "TransportationFixed",
                orElse: () => ReimbursementTypeResponse(
                    id: -1, name: "Transportation Fixed"),
              ),
              balance: (int.parse(nhcReimbursement.value!.result!
                              .allowanceAmountType!.amountTransportfixed ??
                          "0") -
                      int.parse(getApprovedAmmount("TransportationFixed")))
                  .toString(),
              remarkOrBalance: nhcReimbursement
                      .value?.result?.allowanceAmountType?.typeTransportfixed ??
                  "Claim"));
        }

        if (int.parse(nhcReimbursement.value?.result?.allowanceAmountType
                    ?.amountTransportvariable ??
                "0") >
            0) {
          reimbursmentTypeListTemp.add(ReimbursementOptionsResponse(
              reimbursmentTypeResponse: reimbursmentTypeList.value!.firstWhere(
                (element) => element.name == "TransportationVariable",
                orElse: () => ReimbursementTypeResponse(
                    id: -1, name: "Transportation Variable"),
              ),
              balance: (int.parse(nhcReimbursement.value?.result
                              ?.allowanceAmountType?.amountTransportvariable ??
                          "0") -
                      int.parse(getApprovedAmmount("TransportationVariable")))
                  .toString(),
              remarkOrBalance: nhcReimbursement.value?.result
                      ?.allowanceAmountType?.typeTransportvariable ??
                  "Claim"));
        }
      }
      reimbursementOptionList.value = reimbursmentTypeListTemp;
    } catch (e) {
      print(e);
    } finally {
      setTypeOfReimbursementType(reimbursmentTypeList.value?.first.name ?? "");
      isLoading.value = false;
    }
  }

  String getApprovedAmmount(String claimType) {
    num sum = 0;
    if (reimbursmentTypeList.value == null) {
      return '0';
    }
    final claimTypeId = reimbursmentTypeList.value!.firstWhere(
        (element) => element.name == claimType,
        orElse: () => ReimbursementTypeResponse(id: -1));
    if (claimTypeId.id == -1) {
      return '0';
    }

    if (reimbursmentListNow.value == null) {
      return '0';
    }
    final int approvedAmmount = reimbursmentListNow.value!
        .where(
          (element) => element.claimTypeId == claimTypeId.id,
        )
        .toList()
        .length;
    if (approvedAmmount == 0) {
      return '0';
    }
    for (var i = 0; i < reimbursmentListNow.value!.length; i++) {
      sum += reimbursmentListNow.value![i].approvedAmount!;
    }

    return sum.toString();
  }

  setTypeOfReimbursementType(String type) {
    isTypeOfReimbursementSelected.value = true;
    selectedTypeOfReimbursement.value = reimbursmentTypeList.value
        ?.firstWhere((element) => element.name == type);
  }

  void chooseImage() {
    CommonUtil.unFocus();
    CommonWidget.chooseImage(
      onChoose: (file) {
        if (file != null) {
          imgPath.value = file.path;
          imgFile = File(file.path);
          imgType.value = ImgType.file;
        } else {
          imgPath.value = imgPhSvg;
          imgFile = null;
          imgType.value = ImgType.svg;
        }
      },
      showGallery: true,
    );
  }

  void getNhcReimbursement() async {
    try {
      isLoading.value = true;
      final response = await reimbursmentService.getNhcReimbursement(
        sessionService.getEmployeeId(),
      );
      nhcReimbursement.value = response;
      if (nhcReimbursement.value?.result!.allowanceAmountType == null) {
        isThereReimbursement.value = false;
      } else {
        double tmpAmount = 0.0;
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCommunication ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCounterfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountCountervariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountHousingfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement.value?.result
                ?.allowanceAmountType?.amountNightshiftallowance ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMvcvariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountNightcourtfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountShiftallowance ??
            "0");
        tmpAmount += double.parse(
            nhcReimbursement.value?.result?.allowanceAmountType?.amountOthers ??
                "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountTransportfixed ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountTransportvariable ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMealallowance ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMobileallowance ??
            "0");
        tmpAmount += double.parse(
            nhcReimbursement.value?.result?.allowanceAmountType?.amountDental ??
                "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountEntertainment ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountOutpatient ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMedical ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountOvertime ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountMileage ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountStationeries ??
            "0");
        tmpAmount += double.parse(nhcReimbursement
                .value?.result?.allowanceAmountType?.amountGroceries ??
            "0");
        if (tmpAmount == 0) {
          isThereReimbursement.value = false;
        } else {
          isThereReimbursement.value = true;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  bool doValidate() {
    if (selectedTypeOfReimbursement.value == null ||
        selectedReimbursementOption.value == null) {
      CommonWidget.showErrorNotif("Please Select a Type of Reimbursement");
      return false;
    }
    if (selectedCurrency.value == null) {
      CommonWidget.showErrorNotif("Please Select a Currency");
      return false;
    }
    if (amountValidator(amountController.text) != null) {
      CommonWidget.showErrorNotif(amountValidator(amountController.text)!);
      return false;
    }
    if (incurredDate.value == null) {
      CommonWidget.showErrorNotif("Please Select Incurred Date");
      return false;
    }
    if (imgPath.value == '') {
      CommonWidget.showErrorNotif('Please choose image');
      return false;
    }

    return true;
  }

  void doSubmit() async {
    if (!doValidate()) return;
    if (imgPath.value != '') {
      try {
        isLoading.value = true;
        final response = await fileUploadService.uploadImage(
            imgPath.value, sessionService.getInstanceName(), "reimbursement");
      } catch (e) {
        CommonWidget.showErrorNotif("Failed to upload Image, Please try again");
        isLoading.value = false;
        print('error: $e');
      }
    }

    final reimbursmentRequest = ReimbursementRequest(
      claimTypeId:
          selectedReimbursementOption.value?.reimbursmentTypeResponse.id,
      employeeId: sessionService.getEmployeeId(),
      claimAmount: int.parse(amountController.text),
      date: DateTime.now(),
      claimDocument: p.basename(imgPath.value),
      fileName: p.basename(imgPath.value),
      applyDate: DateTime.now(),
      approvedAmount: int.parse(amountController.text),
      incurredDate: incurredDate.value,
      status: 2,
      remark: remarkController.text,
      remark1: selectedCurrency.value!.code ?? "SGD",
      remark2: claimOrRemark.value,
      createdAt: DateTime.now(),
      createdBy: sessionService.getEmployeeId(),
      updatedAt: DateTime.now(),
      updatedBy: sessionService.getEmployeeId(),
    );
    print('reimbursmentRequest: ${reimbursmentRequest.toJson()}');
    try {
      isLoading.value = true;
      final response =
          await reimbursmentService.createReimbursement(reimbursmentRequest);

      print('response: $response');
      CommonWidget.showNotif('Success', color: Colors.green);
      RouteUtil.back();
    } catch (e) {
      print('error: $e');
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
