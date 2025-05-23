import 'package:ezyhr_mobile_apps/module/leave_request/list_leave_request/list_leave_request_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LeaveBalancePage extends GetView<LeaveRequestController> {
  const LeaveBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Leave Balance',
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
                      if (controller.tableLeaveBalance.value == null ||
                          controller.isLoading.value) ...[
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
                      if (controller.tableLeaveBalance.value != null &&
                          !controller.isLoading.value) ...[
                        ...controller.tableLeaveBalance.value!.map(
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
                ),
              ],
            ),
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
}
