import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'list_leave_request_controller.dart';

class LeaveRequestScreen extends GetView<LeaveRequestController> {
  const LeaveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Leave Request',
        bgColor: Color(0xFFD8EAC8),
        isBack: true,
        actions: [
          const SizedBox(
            width: 12,
          )
        ],
      ),
      body: Column(children: [
        _header(),
        _body(),
      ]),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/leave-request');
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Add leave request',
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

  Widget _header() {
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
                  if (controller.tableLeaveBalance.value == null) ...[
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
                  if (controller.tableLeaveBalance.value != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Leave Balance',
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
                                  Get.toNamed('/leave-balance');
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
                    ...controller.tableLeaveBalance.value!.take(1).map(
                          (e) => Column(
                            children: [
                              balanceCard(e.name ?? "", e.leaveEntitle ?? 0.0,
                                  e.leaveBalance ?? 0.0, e.leaveTaken ?? 0.0),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(height: 1, thickness: 1),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        )
                  ]
                ],
              ),
            ))
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: SafeArea(
        child: RefreshIndicator(
          color: ColorConstant.primary,
          backgroundColor: Color(0xFFD8EAC8),
          onRefresh: () => controller.getData(),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CommonWidget.textPrimaryWidget(
                                    'Recent Request',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  const Spacer(),
                                  Obx(
                                    () => Expanded(
                                      child: FieldModalWidget.fieldWidget(
                                        placeholder: 'Select',
                                        value: CommonWidget.textPrimaryWidget(
                                          controller.selectedYear.value
                                              .toString(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: ColorConstant.grey90,
                                        ),
                                        actions: [
                                          Icon(Icons.keyboard_arrow_down,
                                              size: SizeUtil.f(20),
                                              color: ColorConstant.grey90),
                                        ],
                                        onTap: () {
                                          CommonUtil.unFocus(
                                              context: controller.context);
                                          FieldModalWidget.showModal<String,
                                              String>(
                                            data: controller.yearList.value!,
                                            caption: (e) => e,
                                            onSelect: (e) {
                                              controller.setYear(int.parse(e));
                                            },
                                            value: controller.selectedYear.value
                                                .toString(),
                                            title: 'Year',
                                          );
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeUtil.f(16)),
                              Obx(
                                () => controller.employeeLeave.value == null
                                    ? const SizedBox()
                                    : Column(
                                        children: getLeaveRequestWidget(),
                                      ),
                              ),
                              SizedBox(height: SizeUtil.f(100)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget balanceCard(
      String title, double entitlement, double balance, double taken) {
    return Container(
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
                'Leaves type',
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
                    'Entitlement',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entitlement.toString(),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Taken',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    taken.toString(),
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

  String getStatus(int status) {
    switch (status) {
      case 0:
        return "INACTIVE";
      case 1:
        return "ACTIVE";
      case 2:
        return "PENDING";
      case 3:
        return "CANCELED";
      case 4:
        return "APPROVED";
      case 5:
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }

  MaterialColor getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
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

  Color getBackgrounStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey[50]!;
      case 1:
        return Colors.green[50]!;
      case 2:
        return Colors.orange[50]!;
      case 3:
        return Colors.red[50]!;
      case 4:
        return Colors.green[50]!;
      case 5:
        return Colors.red[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  String getLeaveType(int leaveTypeId) {
    String? result;
    controller.employeeLeaveType.value?.forEach((element) {
      if (element.id == leaveTypeId) {
        result = element.name;
        return;
      }
    });
    return result ?? '';
  }

  MaterialColor getLeaveTypeColor(int leaveTypeId) {
    MaterialColor? result;
    controller.employeeLeaveType.value?.forEach((element) {
      if (element.id == leaveTypeId) {
        result = Colors.green;
        return;
      }
    });
    return result ?? Colors.grey;
  }

  List<Widget> getLeaveRequestWidget() {
    if (controller.isLoading.value) {
      return [1, 2, 3, 4]
          .map((e) => Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 80,
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
    } else if (controller.employeeLeave.value == null) {
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
    } else if (controller.employeeLeave.value.isEmpty) {
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
    for (var i = 0; i < controller.employeeLeave.value!.length; i++) {
      final data = controller.employeeLeave.value?[i];
      double? days = data!.dayCount?.toDouble();
      String? startDate =
          DateFormat('EEE, dd MMM').format(data.startDate ?? DateTime.now());
      String? endDate =
          DateFormat('EEE, dd MMM').format(data.endDate ?? DateTime.now());
      String leaveType = getLeaveType(data.leaveTypeId!.toInt());
      MaterialColor leaveTypeColor =
          getLeaveTypeColor((data.leaveTypeId ?? 0).toInt());
      String status = getStatus((data.status ?? 0).toInt());
      MaterialColor statusColor = getStatusColor((data.status ?? 0).toInt());
      Color backgroundStatusColor =
          getBackgrounStatusColor((data.status ?? 0).toInt());
      String daysRange = "$startDate - $endDate";
      listWidget.add(
        recentRequestWidget(
          (data.id ?? 0).toInt(),
          "$days days",
          daysRange,
          leaveType,
          leaveTypeColor,
          status,
          statusColor,
          backgroundStatusColor,
        ),
      );
    }
    if (listWidget.isEmpty) {
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
    } else {
      return listWidget.reversed.toList();
    }
  }

  quotaTag(String title, String value, bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF545454),
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            : Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
      ],
    );
  }

  Widget quotaWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 27),
      decoration: ShapeDecoration(
        color: const Color(0xFF8BBF5A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        image: const DecorationImage(
          image: AssetImage('assets/images/vector.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green[100],
              ),
              child: Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Leave Type',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Entitlement',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Balance',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  const Spacer(),
                  CommonWidget.textPrimaryWidget(
                    'Taken',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  if (controller.tableLeaveBalance.value == null ||
                      controller.isLoading.value) ...[
                    const SizedBox(height: 4),
                    ...List.generate(3, (index) => _mockLoadWidget()),
                  ],
                  if (controller.tableLeaveBalance.value != null &&
                      !controller.isLoading.value)
                    ...[
                      controller.tableLeaveBalance.value![0],
                      controller.tableLeaveBalance.value![1],
                      controller.tableLeaveBalance.value![2]
                    ].map(
                      (e) => Column(
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
                                    "${e.name}",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: ColorConstant.grey90,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: CommonWidget.textPrimaryWidget(
                                      "${e.leaveEntitle}",
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
                                      "${e.leaveBalance}",
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
                                      "${e.leaveTaken}",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: ColorConstant.grey90,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, thickness: 1),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.isLoading.value == false)
                      InkWell(
                        onTap: () {
                          showModal(
                            data: controller.tableLeaveBalance.value!,
                            value: controller.tableLeaveBalance.value,
                            caption: (e) => "",
                            onSelect: (e) {},
                            title: 'Select Account',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: CommonWidget.textPrimaryWidget(
                            'View More',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorConstant.primary,
                          ),
                        ),
                      ),
                    if (controller.isLoading.value)
                      const SizedBox(
                        height: 10,
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _mockLoadWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: CommonWidget.textLoadingWidget(
          height: 28, color: ColorConstant.grey40, width: double.infinity),
    );
  }

  recentRequestMonthWidget(
    String? month,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.textPrimaryWidget(
          month ?? '',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ColorConstant.grey90,
        ),
      ],
    );
  }

  recentRequestWidget(
    int id,
    String? days,
    String? daysRange,
    String? type,
    Color? leaveTypeColor,
    String? status,
    MaterialColor? statusColor,
    Color? backgroundStatusColor,
  ) {
    return InkWell(
        onTap: () {
          controller.toLeaveDetails(id);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: CommonWidget.defBoxDecoration(),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: SizeUtil.f(12)),
                                CommonWidget.textPrimaryWidget(
                                  days ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                SizedBox(height: SizeUtil.f(8)),
                                CommonWidget.textPrimaryWidget(
                                  daysRange ?? '',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                SizedBox(height: SizeUtil.f(8)),
                                CommonWidget.textPrimaryWidget(
                                  type ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: leaveTypeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: backgroundStatusColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: CommonWidget.textPrimaryWidget(
                        status ?? '',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: statusColor,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: ColorConstant.grey90,
                      size: SizeUtil.f(24),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showModal<T, E>({
    required List<T> data,
    required T? value,
    required E Function(T t) caption,
    required Function(T t) onSelect,
    String title = '',
  }) {
    var paddingHz = 24.0;
    var el = Get.width / Get.height;
    if (el > 1.3) {
      paddingHz = Get.width * .3;
    }

    showDialog(
      context: Get.context!,
      builder: (ctx) {
        return Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: paddingHz, vertical: 24),
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
                        "Leave Balance",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ColorConstant.grey90,
                      ),
                      const Spacer(),
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
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green[100],
                  ),
                  child: Row(
                    children: [
                      CommonWidget.textPrimaryWidget(
                        'Leave Type',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorConstant.grey90,
                      ),
                      const Spacer(),
                      CommonWidget.textPrimaryWidget(
                        'Entitlement',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorConstant.grey90,
                      ),
                      const Spacer(),
                      CommonWidget.textPrimaryWidget(
                        'Balance',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorConstant.grey90,
                      ),
                      const Spacer(),
                      CommonWidget.textPrimaryWidget(
                        'Taken',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorConstant.grey90,
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
                              if (controller.tableLeaveBalance.value == null ||
                                  controller.isLoading.value) ...[
                                const SizedBox(height: 4),
                                ...List.generate(
                                    3, (index) => _mockLoadWidget()),
                                SizedBox(height: Get.height * .6),
                              ],
                              if (controller.tableLeaveBalance.value != null &&
                                  !controller.isLoading.value)
                                ...controller.tableLeaveBalance.value!.map(
                                  (e) => Column(
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
                                              child: CommonWidget
                                                  .textPrimaryWidget(
                                                "${e.name}",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: ColorConstant.grey90,
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: CommonWidget
                                                    .textPrimaryWidget(
                                                  "${e.leaveEntitle}",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: ColorConstant.grey90,
                                                  align: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: CommonWidget
                                                    .textPrimaryWidget(
                                                  "${e.leaveBalance}",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: ColorConstant.grey90,
                                                  align: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: CommonWidget
                                                    .textPrimaryWidget(
                                                  "${e.leaveTaken}",
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
                                      const Divider(height: 1, thickness: 1),
                                    ],
                                  ),
                                ),
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
}
