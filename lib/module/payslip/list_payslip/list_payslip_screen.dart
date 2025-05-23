import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constant/color_constant.dart';
import '../../widget/common_widget.dart';
import 'list_payslip_controller.dart';

class PayslipScreen extends GetView<PayslipController> {
  const PayslipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Payslip',
        isBack: true,
        bgColor: Color(0xFFD8EAC8),
        centerTitle: true,
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
                payslipWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return Container(
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: ColorConstant.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          children: [
            Obx(
              () => FieldModalWidget.fieldWidget(
                placeholder: 'Select',
                value: CommonWidget.textPrimaryWidget(
                  controller.selectedYear.value.toString(),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: ColorConstant.grey90,
                ),
                onTap: () {
                  CommonUtil.unFocus(context: controller.context);
                  FieldModalWidget.showModal<String, String>(
                    data: controller.yearList.value!,
                    caption: (e) => e,
                    onSelect: (e) {
                      controller.setYear(int.parse(e));
                    },
                    value: controller.selectedYear.value.toString(),
                    title: 'Year',
                  );
                },
                isLoading: controller.yearList.value == null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getListPayslipWidget() {
    if (controller.isLoading.value) {
      return [1, 2, 3, 4]
          .map((e) => Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                child: Shimmer.fromColors(
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
                ),
              ))
          .toList();
    } else if (controller.payslipHistory.value == null) {
      return [
        SizedBox(height: SizeUtil.f(32)),
        SizedBox(
          height: SizeUtil.f(16),
          child: Center(
            child: CommonWidget.textPrimaryWidget(
              'No Data Available',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ColorConstant.grey90,
            ),
          ),
        ),
        SizedBox(height: SizeUtil.f(700)),
      ];
    } else if (controller.payslipHistory.value!.result?.length == 0) {
      return [
        SizedBox(height: SizeUtil.f(32)),
        SizedBox(
          height: SizeUtil.f(16),
          child: Center(
            child: CommonWidget.textPrimaryWidget(
              'No Data Available',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ColorConstant.grey90,
            ),
          ),
        ),
      ];
    }
    List<Widget> listWidget = [];
    for (var i = 0; i < controller.payslipHistory.value!.result!.length; i++) {
      final data = controller.payslipHistory.value!.result?[i];
      int month = data!.month!;
      int year = data.year!;
      listWidget.add(
        payslipItem(
          year,
          month,
          "Paid",
          data.finalNetPay!,
        ),
      );
    }
    return listWidget;
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  payslipWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                'Payslip List',
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ColorConstant.grey90,
              ),
            ],
          ),
          Obx(
            () => Column(
              children: getListPayslipWidget(),
            ),
          ),
        ],
      ),
    );
  }

  payslipItem(
    int year,
    int month,
    String paid,
    double amount,
  ) {
    return InkWell(
      onTap: () {
        RouteUtil.to(
          '/detail-payslip',
          arguments: {
            'employeeId': controller.sessionService.getEmployeeId(),
            'year': year,
            'month': month,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeUtil.f(8)),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: CommonWidget.defBoxDecoration(),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      'Period',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: ColorConstant.grey90,
                    ),
                    SizedBox(height: SizeUtil.f(8)),
                    CommonWidget.textPrimaryWidget(
                      '${getMonth(month)} $year',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: ColorConstant.grey90,
                    ),
                    SizedBox(height: SizeUtil.f(8)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: Color(0xFFE8FFE4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: CommonWidget.textPrimaryWidget(
                        paid,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF00DD00),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    CommonWidget.singaporeanCurrencyWidget(
                      value: amount,
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        RouteUtil.to(
                          '/detail-payslip',
                          arguments: {
                            'employeeId':
                                controller.sessionService.getEmployeeId(),
                            'year': year,
                            'month': month,
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
