import 'package:ezyhr_mobile_apps/module/reimbursement/list_reimbursement/list_reimbursement_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ReimbursementBalancePage extends GetView<ReimbursementController> {
  const ReimbursementBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Reimbursement Balance',
        isBack: true,
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
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: SizeUtil.f(8),
                    horizontal: SizeUtil.f(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeUtil.f(16),
                    horizontal: SizeUtil.f(16),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      if (controller.nhcReimbursement.value == null) ...[
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                      if (controller.nhcReimbursement.value != null) ...[
                        balanceCard(
                          "Communication",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountCommunication ??
                              "0",
                          controller.getApprovedAmmount("Communication"),
                          (int.parse(controller
                                          .nhcReimbursement
                                          .value!
                                          .result!
                                          .allowanceAmountType!
                                          .amountCommunication ??
                                      "0") -
                                  int.parse(controller
                                      .getApprovedAmmount("Communication")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Counter Fixed",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountCounterfixed ??
                              "0",
                          controller.getApprovedAmmount("CounterFixed"),
                          (int.parse(controller
                                          .nhcReimbursement
                                          .value!
                                          .result!
                                          .allowanceAmountType!
                                          .amountCounterfixed ??
                                      "0") -
                                  int.parse(controller
                                      .getApprovedAmmount("CounterFixed")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Counter Variable",
                          controller
                                  .nhcReimbursement
                                  .value!
                                  .result
                                  ?.allowanceAmountType
                                  ?.amountCountervariable ??
                              "0",
                          controller.getApprovedAmmount("CounterVariable"),
                          (int.parse(controller
                                          .nhcReimbursement
                                          .value!
                                          .result!
                                          .allowanceAmountType!
                                          .amountCounterfixed ??
                                      "0") -
                                  int.parse(controller
                                      .getApprovedAmmount("CounterVariable")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Dental",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountDental ??
                              "0",
                          controller.getApprovedAmmount("Dental"),
                          (int.parse(controller.nhcReimbursement.value!.result!
                                          .allowanceAmountType!.amountDental ??
                                      "0") -
                                  int.parse(
                                      controller.getApprovedAmmount("Dental")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Entertainment",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountEntertainment ??
                              "0",
                          controller.getApprovedAmmount("Entertainment"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountEntertainment ??
                                        "0",
                                  ) -
                                  int.parse(controller
                                      .getApprovedAmmount("Entertainment")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Groceries",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountGroceries ??
                              "0",
                          controller.getApprovedAmmount("Groceries"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountGroceries ??
                                        "0",
                                  ) -
                                  int.parse(controller
                                      .getApprovedAmmount("Groceries")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Housing Fixed",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountHousingfixed ??
                              "0",
                          controller.getApprovedAmmount("HousingFixed"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountHousingfixed ??
                                        "0",
                                  ) -
                                  int.parse(controller
                                      .getApprovedAmmount("HousingFixed")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Meal",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountMealallowance ??
                              "0",
                          controller.getApprovedAmmount("Meal"),
                          (int.parse(controller
                                          .nhcReimbursement
                                          .value!
                                          .result!
                                          .allowanceAmountType!
                                          .amountMealallowance ??
                                      "0") -
                                  int.parse(
                                      controller.getApprovedAmmount("Meal")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Medical",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountMedical ??
                              "0",
                          controller.getApprovedAmmount("Medical"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountMedical ??
                                        "0",
                                  ) -
                                  int.parse(
                                      controller.getApprovedAmmount("Medical")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Mileage",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountMileage ??
                              "0",
                          controller.getApprovedAmmount("Mileage"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountMileage ??
                                        "0",
                                  ) -
                                  int.parse(
                                      controller.getApprovedAmmount("Mileage")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Mobile Allowance",
                          controller
                                  .nhcReimbursement
                                  .value!
                                  .result
                                  ?.allowanceAmountType
                                  ?.amountMobileallowance ??
                              "0",
                          controller.getApprovedAmmount("MobileAllowance"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountMobileallowance ??
                                        "0",
                                  ) -
                                  int.parse(controller
                                      .getApprovedAmmount("MobileAllowance")))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "MVC Variable",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountMvcvariable ??
                              "0",
                          controller.getApprovedAmmount("MVCVariable"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountMvcvariable ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "MVCVariable",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Night Court Fixed",
                          controller
                                  .nhcReimbursement
                                  .value!
                                  .result
                                  ?.allowanceAmountType
                                  ?.amountNightcourtfixed ??
                              "0",
                          controller.getApprovedAmmount("NightCourtFixed"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountNightcourtfixed ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "NightCourtFixed",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Out Patient",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountOutpatient ??
                              "0",
                          controller.getApprovedAmmount("OutPatient"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountOutpatient ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "OutPatient",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Others",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountOthers ??
                              "0",
                          controller.getApprovedAmmount("OutPatient"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountOthers ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "Others",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Overtime",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountOvertime ??
                              "0",
                          controller.getApprovedAmmount("Overtime"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountOvertime ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "Overtime",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Shift Allowance",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountShiftallowance ??
                              "0",
                          controller.getApprovedAmmount("ShiftAllowance"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountShiftallowance ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "ShiftAllowance",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Stationeries",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountStationeries ??
                              "0",
                          controller.getApprovedAmmount("Stationeries"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountStationeries ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "Stationeries",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Transportation Fixed",
                          controller.nhcReimbursement.value!.result
                                  ?.allowanceAmountType?.amountTransportfixed ??
                              "0",
                          controller.getApprovedAmmount("TransportFixed"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountTransportfixed ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "TransportFixed",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                        balanceCard(
                          "Transportation Variable",
                          controller
                                  .nhcReimbursement
                                  .value!
                                  .result
                                  ?.allowanceAmountType
                                  ?.amountTransportvariable ??
                              "0",
                          controller.getApprovedAmmount("TransportVariable"),
                          (int.parse(
                                    controller
                                            .nhcReimbursement
                                            .value!
                                            .result!
                                            .allowanceAmountType!
                                            .amountTransportvariable ??
                                        "0",
                                  ) -
                                  int.parse(controller.getApprovedAmmount(
                                    "TransportVariable",
                                  )))
                              .toString(),
                        ),
                        Divider(height: 1, thickness: 1),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget balanceCard(
    String title,
    String initialAmmount,
    String approvedAmount,
    String balance,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeUtil.f(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Claim Type',
                style: TextStyle(
                  color: Color(0xFF545454),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Initial Amount',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    initialAmmount.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF784DFF),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Approved Amount',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    approvedAmount.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF784DFF),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    balance.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF784DFF),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
