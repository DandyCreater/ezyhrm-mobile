import 'package:ezyhr_mobile_apps/module/attendance/create_attendance/attendance_controller.dart';
import 'package:ezyhr_mobile_apps/module/otp/response/otp_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/web_view.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/response/app_asset_res.dart';
import 'package:ezyhr_mobile_apps/shared/theme/theme.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
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
                  Obx(() => attendanceCard()),
                  companyLinks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameWidget(),
                SizedBox(height: SizeUtil.f(16)),
                titleCard(controller.profileHrms.value?.email, "",
                    controller.isLoading.value),
                centerWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  nameWidget() {
    return InkWell(
      onTap: () {
        if (controller.sessionService.getInstances().length > 1) {
          CommonUtil.unFocus(context: controller.context);
          FieldModalWidget.showModal<Instance, String>(
            data: controller.sessionService.getInstances(),
            caption: (e) =>
                "${e.instanceCode} - ${controller.getInstanceByCode(e.instanceCode)}",
            onSelect: (e) {
              controller.sessionService.saveSelectedInstance(e);
              controller.getData();
            },
            value: controller.sessionService.getSelectedInstance(),
            title: 'Select Instance',
          );
        }
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.isLoading.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: ShapeDecoration(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 42,
                        height: 42,
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
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.isLoading.value
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 120,
                                height: 18,
                                decoration: ShapeDecoration(
                                  color: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            )
                          : CommonWidget.textPrimaryWidget(
                              controller.profileHrms.value == null
                                  ? ""
                                  : controller
                                          .profileHrms.value!.employeeName ??
                                      "",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              align: TextAlign.left,
                            ),
                      const SizedBox(height: 2),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 100,
                              ),
                              child: Container(
                                child: controller.isLoading.value
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 63,
                                          height: 18,
                                          decoration: ShapeDecoration(
                                            color: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        controller
                                                .nhcFormDetails
                                                .value
                                                ?.result
                                                ?.employeeDetailsModel
                                                ?.jobTitle ??
                                            "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeUtil.f(14),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: Color(0xFF1C2612),
                                shape: OvalBorder(),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.profileHrms.value == null
                                  ? ""
                                  : controller.profileHrms.value?.employeeId ??
                                      "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonWidget.textPrimaryWidget(
                "Instance",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    "${controller.getInstanceByCode(controller.sessionService.getSelectedInstance()?.instanceCode ?? "")}",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: 4,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: Color(0xFFAFAFAF),
                      shape: OvalBorder(),
                    ),
                  ),
                  CommonWidget.textPrimaryWidget(
                    "${controller.sessionService.getSelectedInstance()?.instanceCode}",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  controller.sessionService.getInstances().length > 1
                      ? Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )
                      : Container(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  titleCard(String? email, String? reportingManager, bool isLoading) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: Container(
                          width: 125,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignInside,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('hh:mm:ss').format(DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: SizeUtil.f(8)),
                  StreamBuilder(
                      stream:
                          Stream.periodic(const Duration(milliseconds: 100)),
                      builder: (context, snapshot) {
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: DateTime.now().second % 2 == 0 ? 1.0 : 0.0,
                          child: Container(
                            width: 30,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.isUserCheckIn()
                                  ? redColor
                                  : greenColor,
                            ),
                          ),
                        );
                      }),
                  SizedBox(width: SizeUtil.f(8)),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: ((context, snapshot) {
                        return Expanded(
                          child: CustomFilledButton(
                            title: controller.isUserCheckIn()
                                ? 'Clock Out'
                                : 'Clock In',
                            onPressed: () {
                              RouteUtil.to(AttendanceC.route);
                            },
                            color: controller.isUserCheckIn()
                                ? redColor
                                : greenColor,
                            isLoading: controller.isLoading.value,
                            width: SizeUtil.f(120),
                          ),
                        );
                      })),
                ],
              ),
            ],
          ),
        ));
  }

  Widget centerWidget() {
    return Container(
      height: SizeUtil.f(200),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        childAspectRatio: 1.5,
        children: [
          HomeMenu(
              path: "/leave",
              title: "Leave Request",
              icon: 'assets/v2/home_screen/leave_request.svg'),
          HomeMenu(
              path: "/list-attendance",
              title: "Attendance",
              icon: "assets/v2/home_screen/attendance.svg"),
          HomeMenu(
              path: "/payslip",
              title: "Payslip",
              icon: "assets/v2/home_screen/payslip.svg"),
          HomeMenu(
              path: "/reimbursement",
              title: "Reimbursement",
              icon: "assets/v2/home_screen/reimbursement.svg"),
          HomeMenu(
              path: "/timesheetList",
              title: "Timesheet",
              icon: "assets/v2/home_screen/timesheet.svg"),
          Obx(() {
            if (controller.supervisoredEmployee.value != null &&
                controller.supervisoredEmployee.value!.isNotEmpty) {
              return HomeMenu(
                  path: "/manager-dashboard",
                  title: "Manager Dashboard",
                  icon: "assets/v2/home_screen/dashboard.svg");
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  attendanceCard() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFEAECFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Attendance',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        RouteUtil.to('/list-attendance');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (controller.attendance.value != null) ...[
              if (controller.attendance.value?.data?.isNotEmpty ?? false)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFEDFAFF),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 8,
                                top: 8,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF0689FF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.attendance.value?.data?.first
                                          .checkinDate !=
                                      null
                                  ? DateFormat('d MMMM y').format(controller
                                          .attendance
                                          .value
                                          ?.data
                                          ?.first
                                          .checkinDate ??
                                      DateTime.now())
                                  : "-",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formatDuration((controller.attendance.value?.data
                                          ?.first.checkoutDate ??
                                      DateTime.now())
                                  .difference(controller.attendance.value?.data
                                          ?.first.checkinDate ??
                                      DateTime.now())),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${DateFormat('hh:mm:ss a').format(
                                controller.attendance.value?.data?.first
                                        .checkinDate ??
                                    DateTime.now(),
                              )} - ${DateFormat('hh:mm:ss a').format(
                                controller.attendance.value?.data?.first
                                        .checkoutDate ??
                                    DateTime.now(),
                              )}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: ShapeDecoration(
                        color: controller.getStatusColor(
                            controller.attendance.value?.data?.first.status ??
                                0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                        controller.getStatus(
                            controller.attendance.value?.data?.first.status ??
                                0),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.getBackgroundStatusColor(
                              controller.attendance.value?.data?.first.status ??
                                  0),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'No attendance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your attendance list will show here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF545454),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
            ]
          ],
        ),
      ),
    );
  }

  companyLinks() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Company Links',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                      children: [],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: Get.height * 0.9,
                          child: WebViewApp(
                            initialUrl: "https://ats.rmagroup.com.sg/",
                            title: 'ATS',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'ATS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: Get.height * 0.9,
                          child: WebViewApp(
                            initialUrl: "https://rmagroup.com.sg/",
                            title: 'RMA',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'RMA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: Get.height * 0.9,
                          child: WebViewApp(
                            initialUrl:
                                "https://www.linkedin.com/company/rmagroupsg/",
                            title: 'RMA Linkedin',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'LinkedIn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${hours} Hours ${minutes} Minutes';
  }

  todayTask() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFEAECFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today Task',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Wednesday, March 7',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 137),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
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
                              Text(
                                'View All',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF784DFF),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  width: 331,
                                  height: 10,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    width: 50.39,
                                    height: 10,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF784DFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '20%',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: FlutterLogo(),
                          ),
                          const SizedBox(width: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '5',
                                  style: TextStyle(
                                    color: Color(0xFF784DFF),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '/10 Task need to be done.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  timesheetCard() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color.fromARGB(255, 234, 247, 255),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Timesheet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                        Text(
                          'View All',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF784DFF),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No timesheet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your timesheet will show here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF545454),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeMenu extends StatelessWidget {
  final String path;
  final String title;
  final String icon;

  const HomeMenu(
      {Key? key, required this.path, required this.title, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(path);
      },
      child: Column(
        children: [
          CommonWidget.imageWidget(
            path: icon,
            imgPathType: ImgPathType.asset,
            width: 30,
            height: 30,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
