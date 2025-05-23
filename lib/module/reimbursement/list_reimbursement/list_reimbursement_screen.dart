import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'list_reimbursement_controller.dart';

class ReimbursementScreen extends GetView<ReimbursementController> {
  const ReimbursementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Reimbursement',
        bgColor: Color(0xFFD8EAC8),
        isBack: true,
      ),
      body: Column(
        children: [
          quotaWidget(),
          filterWidget(),
          reimbursementWidget(),
        ],
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/reimbursement-form');
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Add Reimbursement Request',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget quotaWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: SizeUtil.f(150),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFD8EAC8),
            ),
          ),
        ),
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
          child: Obx(
            () => Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reimbursement Balance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(4),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Text(
                                'View All',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF784DFF),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/reimbursement-balance');
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
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
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
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

  filterWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeUtil.f(8),
        horizontal: SizeUtil.f(8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: CommonWidget.textPrimaryWidget(
                    controller.selectedYear.value.toString(),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
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
                  isExpanded: false,
                ),
              ),
              SizedBox(width: SizeUtil.f(8)),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: CommonWidget.textPrimaryWidget(
                    controller.selectedMonth.value,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: controller.months.value,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.setMonth(e);
                      },
                      value: controller.selectedMonth.value,
                      title: 'Month',
                    );
                  },
                  isExpanded: false,
                ),
              ),
              SizedBox(width: SizeUtil.f(8)),
              Obx(
                () => Expanded(
                  child: FieldModalWidget.fieldWidget(
                    placeholder: 'Select',
                    value: Expanded(
                      child: CommonWidget.textPrimaryWidget(
                        controller.selectedStatus.value,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.grey90,
                      ),
                    ),
                    actions: [
                      Icon(Icons.keyboard_arrow_down,
                          size: SizeUtil.f(20), color: ColorConstant.grey90),
                    ],
                    onTap: () {
                      CommonUtil.unFocus(context: controller.context);
                      FieldModalWidget.showModal<String, String>(
                        data: controller.statuses.value,
                        caption: (e) => e,
                        onSelect: (e) {
                          controller.setStatus(e);
                        },
                        value: controller.selectedStatus.value,
                        title: 'Status',
                      );
                    },
                    isExpanded: false,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  reimbursementWidget() {
    return Expanded(
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
          child: ScrollConfiguration(
            behavior:
                ScrollBehavior().copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: SizeUtil.f(8),
                  horizontal: SizeUtil.f(8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Obx(
                      () => Column(
                        children: getReimbursementListWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getReimbursementListWidget() {
    if (controller.isLoading.value) {
      return [1, 2, 3, 4]
          .map((e) => Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 120,
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
    } else if (controller.reimbursmentList.value == null) {
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
        SizedBox(height: SizeUtil.f(600)),
      ];
    } else if (controller.reimbursmentList.value!.length == 0) {
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
        SizedBox(height: SizeUtil.f(600)),
      ];
    } else {
      List<Widget> listWidget = [];
      for (var i = 0; i < controller.reimbursmentList.value!.length; i++) {
        final data = controller.reimbursmentList.value![i];
        print('claimAmount: ${data.claimAmount}');
        listWidget.add(
          reimbursmentWidgetItem(
            data.id!.toInt(),
            data.docNo!,
            data.status!.toInt(),
            data.claimTypeId!.toInt(),
            data.createdAt!,
            data.claimAmount!.toInt(),
            data.fileName!,
          ),
        );
      }
      var resWidget = listWidget.reversed.toList();
      resWidget.add(
        SizedBox(
          height: SizeUtil.f(100),
        ),
      );
      return resWidget;
    }
  }

  reimbursmentWidgetItem(
    int id,
    String docNo,
    int status,
    int claimTypeId,
    DateTime claimDate,
    int amount,
    String file,
  ) {
    return InkWell(
      onTap: () {
        controller.setCurrentReimbursement(id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: CommonWidget.defBoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 20,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0689FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.textPrimaryWidget(
                            "#${docNo}",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: ColorConstant.grey60,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CommonWidget.textPrimaryWidget(
                            NumberFormat.currency(locale: 'en_SG')
                                .format(amount),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CommonWidget.textPrimaryWidget(
                            DateFormat('dd MMM yyyy').format(claimDate),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: getColorByIdLighter(claimTypeId),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
              child: CommonWidget.textPrimaryWidget(
                controller.getReimbursementTypeById(claimTypeId).name!,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: getColorById(claimTypeId),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorById(int id) {
    switch (id) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.yellow;
      case 6:
        return Colors.purple;
      case 7:
        return Colors.brown;
      case 8:
        return Colors.teal;
      case 9:
        return Colors.pink;
      case 10:
        return Colors.indigo;
      case 11:
        return Colors.lightBlue;
      case 12:
        return Colors.deepOrange;
      case 13:
        return Colors.deepPurple;
      case 14:
        return Colors.blueGrey;
      case 15:
        return Colors.amber;
      case 16:
        return Colors.cyan;
      case 17:
        return Colors.lime;
      case 18:
        return Colors.lightGreen;
      case 19:
        return Colors.deepPurpleAccent;
      case 20:
        return Colors.orangeAccent;
      case 21:
        return Colors.deepOrangeAccent;
      case 22:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color getColorByIdLighter(int id) {
    switch (id) {
      case 1:
        return Colors.red.shade100;
      case 2:
        return Colors.blue.shade200;
      case 3:
        return Colors.green.shade100;
      case 4:
        return Colors.orange.shade100;
      case 5:
        return Colors.yellow.shade100;
      case 6:
        return Colors.purple.shade100;
      case 7:
        return Colors.brown.shade100;
      case 8:
        return Colors.teal.shade100;
      case 9:
        return Colors.pink.shade100;
      case 10:
        return Colors.indigo.shade100;
      case 11:
        return Colors.lightBlue.shade100;
      case 12:
        return Colors.deepOrange.shade100;
      case 13:
        return Colors.deepPurple.shade100;
      case 14:
        return Colors.blueGrey.shade100;
      case 15:
        return Colors.amber.shade100;
      case 16:
        return Colors.cyan.shade100;
      case 17:
        return Colors.lime.shade100;
      case 18:
        return Colors.lightGreen.shade100;
      case 19:
        return Colors.deepPurpleAccent.shade100;
      case 20:
        return Colors.orangeAccent.shade100;
      case 21:
        return Colors.deepOrangeAccent.shade100;
      case 22:
        return Colors.grey.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  getReimbursementColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      case 4:
        return Colors.green;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  getReimbursementColorBackground(int status) {
    switch (status) {
      case 0:
        return Colors.grey[100];
      case 1:
        return Colors.blue[100];
      case 2:
        return Colors.yellow[100];
      case 3:
        return Colors.red[100];
      case 4:
        return Colors.green[100];
      case 5:
        return Colors.red[100];
      default:
        return Colors.grey[100];
    }
  }

  getReimbursementProgress(int status) {
    switch (status) {
      case 0:
        return 'Inactive';
      case 1:
        return 'Active';
      case 2:
        return 'Pending';
      case 3:
        return 'Cancelled';
      case 4:
        return 'Approved';
      case 5:
        return 'Rejected';
      default:
        return 'Inactive';
    }
  }

  void showModal<T, E>({
    required List<T> data,
    required T? value,
    required E Function(T t) caption,
    required Function(T t) onSelect,
    String title = '',
  }) {
    var paddingHz = 6.0;
    var el = Get.width / Get.height;
    if (el > 1.3) {
      paddingHz = Get.width * .3;
    }

    showDialog(
      context: Get.context!,
      builder: (ctx) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      CommonWidget.textPrimaryWidget(
                        "Reimbursement Balance",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ColorConstant.grey90,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorConstant.grey90,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green[100],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Claim',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          CommonWidget.textPrimaryWidget(
                            'Type',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Initial',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          CommonWidget.textPrimaryWidget(
                            'Amount',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CommonWidget.textPrimaryWidget(
                            'Approved',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          CommonWidget.textPrimaryWidget(
                            'Amount',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Spacer(),
                      CommonWidget.textPrimaryWidget(
                        'Balance',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorConstant.grey90,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              if (controller.nhcReimbursement.value ==
                                  null) ...[
                                const SizedBox(height: 4),
                                ...List.generate(
                                    3, (index) => _mockLoadWidget()),
                              ],
                              if (controller.nhcReimbursement.value != null)
                                _tableRow(
                                  "Communication",
                                  controller
                                          .nhcReimbursement
                                          .value!
                                          .result
                                          ?.allowanceAmountType
                                          ?.amountCommunication ??
                                      "0",
                                  controller
                                      .getApprovedAmmount("Communication"),
                                  (int.parse(controller
                                                  .nhcReimbursement
                                                  .value!
                                                  .result!
                                                  .allowanceAmountType!
                                                  .amountCommunication ??
                                              "0") -
                                          int.parse(
                                              controller.getApprovedAmmount(
                                                  "Communication")))
                                      .toString(),
                                ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Dental",
                                controller.nhcReimbursement.value!.result
                                        ?.allowanceAmountType?.amountDental ??
                                    "0",
                                controller.getApprovedAmmount("Dental"),
                                (int.parse(controller
                                                .nhcReimbursement
                                                .value!
                                                .result!
                                                .allowanceAmountType!
                                                .amountDental ??
                                            "0") -
                                        int.parse(controller
                                            .getApprovedAmmount("Dental")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Meal",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountMealallowance ??
                                    "0",
                                controller.getApprovedAmmount("Meal"),
                                (int.parse(controller
                                                .nhcReimbursement
                                                .value!
                                                .result!
                                                .allowanceAmountType!
                                                .amountMealallowance ??
                                            "0") -
                                        int.parse(controller
                                            .getApprovedAmmount("Meal")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Counter Fixed",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountCounterfixed ??
                                    "0",
                                controller.getApprovedAmmount("CounterFixed"),
                                (int.parse(controller
                                                .nhcReimbursement
                                                .value!
                                                .result!
                                                .allowanceAmountType!
                                                .amountCounterfixed ??
                                            "0") -
                                        int.parse(controller.getApprovedAmmount(
                                            "CounterFixed")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Counter Variable",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountCountervariable ??
                                    "0",
                                controller
                                    .getApprovedAmmount("CounterVariable"),
                                (int.parse(controller
                                                .nhcReimbursement
                                                .value!
                                                .result!
                                                .allowanceAmountType!
                                                .amountCounterfixed ??
                                            "0") -
                                        int.parse(controller.getApprovedAmmount(
                                            "CounterVariable")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Entertainment",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountEntertainment ??
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
                                        int.parse(controller.getApprovedAmmount(
                                            "Entertainment")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Groceries",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountGroceries ??
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
                              _tableRow(
                                "Housing Fixed",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountHousingfixed ??
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
                                        int.parse(controller.getApprovedAmmount(
                                            "HousingFixed")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
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
                                        int.parse(controller
                                            .getApprovedAmmount("Medical")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
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
                                        int.parse(controller
                                            .getApprovedAmmount("Mileage")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "Mobile Allowance",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountMobileallowance ??
                                    "0",
                                controller
                                    .getApprovedAmmount("MobileAllowance"),
                                (int.parse(
                                          controller
                                                  .nhcReimbursement
                                                  .value!
                                                  .result!
                                                  .allowanceAmountType!
                                                  .amountMobileallowance ??
                                              "0",
                                        ) -
                                        int.parse(controller.getApprovedAmmount(
                                            "MobileAllowance")))
                                    .toString(),
                              ),
                              Divider(height: 1, thickness: 1),
                              _tableRow(
                                "MVC Variable",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountMvcvariable ??
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
                              _tableRow(
                                "Night Court Fixed",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountNightcourtfixed ??
                                    "0",
                                controller
                                    .getApprovedAmmount("NightCourtFixed"),
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
                              _tableRow(
                                "Out Patient",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountOutpatient ??
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
                              _tableRow(
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
                              _tableRow(
                                "Shift Allowance",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountShiftallowance ??
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
                              _tableRow(
                                "Stationeries",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountStationeries ??
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
                              _tableRow(
                                "Transportation Fixed",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountTransportfixed ??
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
                              _tableRow(
                                "Transportation Variable",
                                controller
                                        .nhcReimbursement
                                        .value!
                                        .result
                                        ?.allowanceAmountType
                                        ?.amountTransportvariable ??
                                    "0",
                                controller
                                    .getApprovedAmmount("TransportVariable"),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mockLoadWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: CommonWidget.textLoadingWidget(
          height: 28, color: ColorConstant.grey40, width: double.infinity),
    );
  }

  Widget _tableRow(
    String? claimtype,
    String? initialAmmount,
    String? approvedAmount,
    String? balance,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 8,
            bottom: 8,
          ),
          child: Row(
            children: [
              const SizedBox(width: 24),
              Expanded(
                child: CommonWidget.textPrimaryWidget(
                  claimtype ?? "-",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorConstant.grey90,
                ),
              ),
              Expanded(
                child: Center(
                  child: CommonWidget.textPrimaryWidget(
                    initialAmmount ?? "-",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                    align: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: CommonWidget.textPrimaryWidget(
                    approvedAmount ?? "-",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                    align: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: CommonWidget.textPrimaryWidget(
                    balance == null
                        ? "0"
                        : int.parse(balance) < 0
                            ? "0"
                            : balance,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                    align: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
