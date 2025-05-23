import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constant/color_constant.dart';
import '../../widget/common_widget.dart';
import 'detail_payslip_controller.dart';

class DetailPayslipScreen extends GetView<DetailPayslipController> {
  const DetailPayslipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Details Payslip',
        isBack: true,
        centerTitle: true,
        bottomWidget: null,
      ),
      body: payslipWidgetV2(),
    );
  }

  valueLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  valueLoaderFixed() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 50,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  header() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: CommonWidget.defBoxDecoration(),
          child: Column(
            children: [
              Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Name of Employee',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Date of Payment',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    controller.isLoading.value
                        ? valueLoaderFixed()
                        : CommonWidget.textPrimaryWidget(
                            controller
                                    .payslip.value!.result!.pay!.employeeName ??
                                '',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                    const Spacer(),
                    controller.isLoading.value
                        ? valueLoaderFixed()
                        : CommonWidget.textPrimaryWidget(
                            DateFormat("d/M/y").format(controller
                                    .payslip.value!.result!.pay!.createdAt!) ??
                                '',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Nett Pay',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey70,
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Mode of Payment',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Obx(
                    () => controller.isLoading.value
                        ? valueLoaderFixed()
                        : CommonWidget.singaporeanCurrencyWidget(
                            value: controller
                                    .payslip.value!.result!.pay!.finalNetPay!
                                    .toDouble() ??
                                0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ),
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Bank Transfer',
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  detailPayroll() {
    return SingleChildScrollView(
      child: Container(
        decoration: CommonWidget.defBoxDecoration(),
        child: ExpansionTile(
          title: CommonWidget.textPrimaryWidget(
            'Detail Payroll',
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: ColorConstant.grey90,
          ),
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Basic Pay',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                          const Spacer(),
                          Obx(() => controller.isLoading.value ||
                                  controller.payslip.value == null
                              ? valueLoaderFixed()
                              : CommonWidget.singaporeanCurrencyWidget(
                                  value: controller.payslip.value!.result!.pay!
                                          .basicSalary!
                                          .toDouble() ??
                                      0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ColorConstant.grey90,
                                  ),
                                )),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.textPrimaryWidget(
                                  'Total Allowance',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: ColorConstant.grey90,
                                ),
                                const SizedBox(height: 4),
                                controller.isLoading.value ||
                                        controller.payslip.value == null
                                    ? valueLoaderFixed()
                                    : controller.payslip.value!.result!
                                                .payDetails!.isNotEmpty ||
                                            controller.reimbursmentList.value !=
                                                null
                                        ? CommonWidget.textPrimaryWidget(
                                            '(Breakdown shown below)',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.grey70,
                                          )
                                        : Container(),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => controller.isLoading.value ||
                                    controller.payslip.value == null
                                ? valueLoaderFixed()
                                : CommonWidget.singaporeanCurrencyWidget(
                                    value: controller.totalAllowance.value,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => controller.payslip.value == null
                            ? Container()
                            : Column(
                                children: [
                                  if (controller.payslip.value!.result!
                                      .payDetails!.isNotEmpty)
                                    ...controller
                                        .payslip.value!.result!.payDetails!
                                        .map(
                                      (e) {
                                        if (e.pidDirection == 1) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CommonWidget
                                                      .textPrimaryWidget(
                                                    "${e.owAw == "AW" ? "Annual Wage Supplement" : "Ordinary Wage Supplement"}",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: ColorConstant.grey90,
                                                  ),
                                                  const Spacer(),
                                                  controller.isLoading.value
                                                      ? valueLoaderFixed()
                                                      : CommonWidget
                                                          .singaporeanCurrencyWidget(
                                                          value: e.amount!
                                                              .toDouble(),
                                                          textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: ColorConstant
                                                                .grey90,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ).toList(),
                                  if (controller.reimbursmentList.value != null)
                                    ...controller.reimbursmentList.value!
                                        .map((e) {
                                      if (e.remark2 == "allowance" ||
                                          e.remark2 == "Allowance") {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                CommonWidget.textPrimaryWidget(
                                                  "${controller.reimbursmentTypeList.value?.where((element) => element.id == e.claimTypeId).first.name ?? " "}",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: ColorConstant.grey90,
                                                ),
                                                const Spacer(),
                                                controller.isLoading.value
                                                    ? valueLoaderFixed()
                                                    : CommonWidget
                                                        .singaporeanCurrencyWidget(
                                                        value: e.claimAmount!
                                                            .toDouble(),
                                                        textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: ColorConstant
                                                              .grey90,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList(),
                                ],
                              ),
                      ),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Gross Pay',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                          const Spacer(),
                          Obx(
                            () => controller.isLoading.value
                                ? valueLoaderFixed()
                                : CommonWidget.singaporeanCurrencyWidget(
                                    value: controller.payslip.value!.result!
                                            .pay!.basicSalary!
                                            .toDouble() +
                                        controller.totalAllowance.value,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.textPrimaryWidget(
                                'Total Deduction',
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: ColorConstant.grey90,
                              ),
                              const SizedBox(height: 4),
                              CommonWidget.textPrimaryWidget(
                                '(Breakdown shown below)',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.grey70,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                            () => controller.isLoading.value
                                ? valueLoaderFixed()
                                : CommonWidget.singaporeanCurrencyWidget(
                                    value: controller.totalDeduction.value,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => controller.payslip.value == null
                            ? Container()
                            : Column(
                                children: [
                                  if (controller.payslip.value!.result!
                                      .payDetails!.isNotEmpty)
                                    ...controller
                                        .payslip.value!.result!.payDetails!
                                        .map(
                                      (e) {
                                        if (e.pidDirection == -1) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CommonWidget
                                                      .textPrimaryWidget(
                                                    "${e.owAw == "AW" ? "Annual Wage Supplement" : "Ordinary Wage Supplement"}",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: ColorConstant.grey90,
                                                  ),
                                                  const Spacer(),
                                                  controller.isLoading.value
                                                      ? valueLoaderFixed()
                                                      : CommonWidget
                                                          .singaporeanCurrencyWidget(
                                                          value: e.amount!
                                                              .toDouble(),
                                                          textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: ColorConstant
                                                                .grey90,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ).toList(),
                                ],
                              ),
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? valueLoaderFixed()
                            : Row(
                                children: [
                                  CommonWidget.textPrimaryWidget(
                                    'Total Donation',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorConstant.grey80,
                                  ),
                                  const Spacer(),
                                  CommonWidget.singaporeanCurrencyWidget(
                                    value: (controller.payslip.value?.result
                                                    ?.pay?.donation ??
                                                0.0)
                                            .toDouble() *
                                        -1,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.grey80,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => controller.isLoading.value
                            ? valueLoaderFixed()
                            : Row(
                                children: [
                                  CommonWidget.textPrimaryWidget(
                                    'Total NS Leave',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorConstant.grey80,
                                  ),
                                  const Spacer(),
                                  CommonWidget.singaporeanCurrencyWidget(
                                    value: (controller.payslip.value?.result
                                                    ?.pay?.totalNsLeave ??
                                                0.0)
                                            .toDouble() *
                                        -1,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.grey80,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => controller.payslip.value == null
                            ? Container()
                            : Column(
                                children: [
                                  if (controller.noPayLeave.value != 0.0)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            CommonWidget.textPrimaryWidget(
                                              "No Pay Leave",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: ColorConstant.grey90,
                                            ),
                                            const Spacer(),
                                            controller.isLoading.value
                                                ? valueLoaderFixed()
                                                : CommonWidget
                                                    .singaporeanCurrencyWidget(
                                                    value: controller.noPayLeave
                                                        .toDouble(),
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color:
                                                          ColorConstant.grey90,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    )
                                ],
                              ),
                      ),
                      const SizedBox(height: 4),
                      const SizedBox(height: 4),
                      Divider(
                        height: 1,
                        color: ColorConstant.grey50,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.textPrimaryWidget(
                                'Employee`s CPF Contribution',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.grey80,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                            () => controller.isLoading.value
                                ? valueLoaderFixed()
                                : CommonWidget.singaporeanCurrencyWidget(
                                    value: controller.payslip.value!.result!
                                        .pay!.employeeContribution!
                                        .toDouble(),
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.f(8)),
          ],
        ),
      ),
    );
  }

  overtimeDetails() {
    return Container(
      decoration: CommonWidget.defBoxDecoration(),
      child: ExpansionTile(
        title: CommonWidget.textPrimaryWidget(
          'Overtime Details',
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: ColorConstant.grey90,
        ),
        children: [
          SizedBox(height: SizeUtil.f(8)),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                          'Overtime Hours Worked',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isLoading.value
                              ? valueLoaderFixed()
                              : CommonWidget.textPrimaryWidget(
                                  "${controller.payslip.value!.result!.pay!.totalOtHours ?? " "}",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: ColorConstant.grey90,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      height: 1,
                      color: ColorConstant.grey50,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                          'Total Overtime Pay',
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isLoading.value
                              ? valueLoaderFixed()
                              : CommonWidget.textPrimaryWidget(
                                  "${controller.payslip.value!.result!.pay!.totalOtHours! * controller.payslip.value!.result!.pay!.hourlyPayRate!}",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: ColorConstant.grey90,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
        ],
      ),
    );
  }

  additional() {
    return SingleChildScrollView(
        child: Container(
      decoration: CommonWidget.defBoxDecoration(),
      child: ExpansionTile(
        title: CommonWidget.textPrimaryWidget(
          'Additional',
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: ColorConstant.grey90,
        ),
        children: [
          SizedBox(height: SizeUtil.f(8)),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.textPrimaryWidget(
                              'Others Additional Payments',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isLoading.value
                              ? valueLoaderFixed()
                              : CommonWidget.singaporeanCurrencyWidget(
                                  value: controller.totalAdditional.value,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: ColorConstant.grey90,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Obx(() => controller.payslip.value == null ||
                            !controller
                                .payslip.value!.result!.payDetails!.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 4),
                              Divider(
                                height: 1,
                                color: ColorConstant.grey50,
                              ),
                              const SizedBox(height: 4),
                            ],
                          )
                        : Container()),
                    Obx(
                      () => controller.payslip.value == null ||
                              !controller
                                  .payslip.value!.result!.payDetails!.isNotEmpty
                          ? Container()
                          : Column(
                              children: [
                                if (controller.reimbursmentList.value != null)
                                  ...controller.reimbursmentList.value!
                                      .map((e) {
                                    if (e.remark2 == "Claim" ||
                                        e.remark2 == "claim") {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              CommonWidget.textPrimaryWidget(
                                                "${controller.reimbursmentTypeList.value?.where((element) => element.id == e.claimTypeId).first.name ?? " "}",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: ColorConstant.grey90,
                                              ),
                                              const Spacer(),
                                              controller.isLoading.value
                                                  ? valueLoaderFixed()
                                                  : CommonWidget
                                                      .singaporeanCurrencyWidget(
                                                      value: e.claimAmount!
                                                          .toDouble(),
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: ColorConstant
                                                            .grey90,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                              ],
                            ),
                    ),
                    const SizedBox(height: 4),
                    Divider(
                      height: 1,
                      color: ColorConstant.grey50,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CommonWidget.textPrimaryWidget(
                          'Net Pay',
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isLoading.value
                              ? valueLoaderFixed()
                              : CommonWidget.singaporeanCurrencyWidget(
                                  value: controller
                                      .payslip.value!.result!.pay!.finalNetPay!
                                      .toDouble(),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: ColorConstant.grey90,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      height: 1,
                      color: ColorConstant.grey50,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.textPrimaryWidget(
                              'Employer`s CPF Contribution',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isLoading.value
                              ? valueLoaderFixed()
                              : CommonWidget.singaporeanCurrencyWidget(
                                  value: controller.payslip.value!.result!.pay!
                                      .employeerContribution!
                                      .toDouble(),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: ColorConstant.grey90,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtil.f(8)),
        ],
      ),
    ));
  }

  payslipWidgetV2() {
    return CommonWidget.expandedScrollWidget(
      physics: BouncingScrollPhysics(),
      top: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: SizeUtil.f(8)),
              header(),
              SizedBox(height: SizeUtil.f(8)),
              detailPayroll(),
              SizedBox(height: SizeUtil.f(8)),
              overtimeDetails(),
              SizedBox(height: SizeUtil.f(8)),
              additional()
            ],
          ),
        ),
      ],
    );
  }
}
