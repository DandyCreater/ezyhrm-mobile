import 'package:ezyhr_mobile_apps/module/home/home_screen.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/attendance_approval/attendance_approval_dto.dart';
import 'package:ezyhr_mobile_apps/module/manager_dashboard/manager_dashboard_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/theme/theme.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';

class ManagerDashboardScreen extends GetView<ManagerDashboardController> {
  const ManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar('Dashboard',
          isBack: false, bgColor: ColorConstant.greenBackground),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorConstant.primary,
          onRefresh: () => controller.getData(),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: true, scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    headerWidget(),
                    bodyWidget(),
                    Container(
                      height: 100,
                    )
                  ],
                ),
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
            height: SizeUtil.f(50),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ColorConstant.greenBackground,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(
            height: SizeUtil.f(120),
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
              childAspectRatio: 1.7,
              children: const [
                HomeMenu(
                  path: "/leave-approval",
                  title: "Approve Leave",
                  icon: 'assets/v2/home_screen/leave_request.svg',
                ),
                HomeMenu(
                  path: "/timesheet-approval",
                  title: "Approve Timesheet",
                  icon: "assets/v2/home_screen/timesheet.svg",
                ),
                HomeMenu(
                  path: "/reimbursement-approval",
                  title: "Approve Reimbursement",
                  icon: "assets/v2/home_screen/reimbursement.svg",
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget bodyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        statWidget(),
        mapWidget(),
        attendanceList(),
      ]),
    );
  }

  Widget statWidget() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.textPrimaryWidget(
            DateFormat('EEEE,dd MMM yyyy').format(DateTime.now()),
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 4),
          CommonWidget.textPrimaryWidget(
            "Content refresh every 15s by default",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF545454),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return CommonWidget.textPrimaryWidget(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  );
                },
              ),
              Spacer(),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(milliseconds: 100)),
                  builder: (context, snapshot) {
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: DateTime.now().second % 2 == 0 ? 1.0 : 0.0,
                      child: Container(
                        width: 30,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greenColor,
                        ),
                      ),
                    );
                  }),
              CommonWidget.textPrimaryWidget(
                "Current Time",
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => CommonWidget.primaryButtonWidget(
              caption: "Refresh",
              captionColor: Color(0xFF8BBF5A),
              bgColor: Color(0xFFE8F2DE),
              isLoading: controller.isLoading.value,
              onTap: () {
                controller.getData();
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.textPrimaryWidget("Total Work Hours:"),
                  SizedBox(
                    height: 10,
                  ),
                  CommonWidget.textPrimaryWidget("Total OT Hours:"),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE2E2E2)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: CommonWidget.textPrimaryWidget(
                        (controller.totalWorkHour.value ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE2E2E2)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: CommonWidget.textPrimaryWidget(
                        (controller.totalOtHour.value ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.textPrimaryWidget("hour(s) today"),
                  SizedBox(
                    height: 10,
                  ),
                  CommonWidget.textPrimaryWidget("hour(s) today"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget mapWidget() {
    final defaultCenter = LatLng(1.3521, 103.8198);
    final defaultZoom = 3.2;
    final initialZoom = 3.2;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          CommonWidget.textPrimaryWidget(
            "Maps",
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 16),
          Obx(
            () => controller.isLoading.value
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300] ?? Colors.grey,
                    highlightColor: Colors.grey[100] ?? Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 300,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: defaultCenter,
                        initialZoom: initialZoom,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            if (controller
                                        .attendanceApprovalDto.value !=
                                    null &&
                                (controller.attendanceApprovalDto.value
                                        ?.isNotEmpty ??
                                    false) &&
                                controller.isLoading.value == false)
                              ...controller.attendanceApprovalDto.value!
                                  .where((e) =>
                                      e
                                              .attendanceResponse?.latInTime !=
                                          null &&
                                      e
                                              .attendanceResponse?.latInTime !=
                                          "null" &&
                                      e.attendanceResponse?.latOutTime !=
                                          null &&
                                      e.attendanceResponse?.latOutTime !=
                                          "null")
                                  .map((e) => Marker(
                                        point: LatLng(
                                          double.parse(
                                              e.attendanceResponse?.latInTime ??
                                                  "0.0"),
                                          double.parse(e.attendanceResponse
                                                  ?.longInTime ??
                                              "0.0"),
                                        ),
                                        child: Container(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  e.profilePicture ??
                                                      controller
                                                          .profilePicture.value,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                          ],
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget attendanceList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              CommonWidget.textPrimaryWidget(
                "Today Attendance",
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              controller.attendanceApprovalDto.value == null ||
                      (controller.attendanceApprovalDto.value?.isEmpty ?? true)
                  ? Container()
                  : InkWell(
                      child: CommonWidget.textPrimaryWidget(
                        "View All",
                        color: Color(0xFF784DFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        Get.toNamed("/attendance-approval");
                      },
                    ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          controller.attendanceApprovalDto.value == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.greenBackground,
                  ),
                )
              : (controller.attendanceApprovalDto.value?.isEmpty ?? true)
                  ? Container(
                      height: 100,
                      child: Center(
                        child: CommonWidget.textPrimaryWidget(
                          "No attendance request",
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.attendanceApprovalDto.value
                          ?.take(3)
                          .length,
                      itemBuilder: (context, index) {
                        return attendanceCard(
                            controller.attendanceApprovalDto.value![index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget attendanceCard(AttendanceApprovalDto data) {
    return InkWell(
        onTap: () {
          controller.setCurrentAttendanceApproval(data);
          Get.toNamed("/attendance-approval-detail", arguments: {
            "attendanceApprovalDto": data,
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.textPrimaryWidget(
                      data.employeeList?.employeename ?? "-",
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "In Time",
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      data.attendanceResponse?.checkinDate == null
                          ? "-"
                          : DateFormat('hh:mm a').format(
                              data.attendanceResponse?.checkinDate ??
                                  DateTime.now()),
                      color: Color(0xFF784DFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Color(0xFF545454),
                          size: 16,
                        ),
                        CommonWidget.textPrimaryWidget(
                          "${(data.attendanceResponse?.locationinTime ?? "-").substring(0, 20)}...",
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: controller.getBackgroundStatusColor(
                            data.attendanceResponse?.status ?? 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.getStatus(
                                data.attendanceResponse?.status ?? 0),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: controller.getStatusColor(
                                  data.attendanceResponse?.status ?? 0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommonWidget.textPrimaryWidget(
                      "Out Time",
                      color: Color(0xFF545454),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonWidget.textPrimaryWidget(
                      data.attendanceResponse?.checkoutDate == null
                          ? "-"
                          : DateFormat('hh:mm a').format(
                              data.attendanceResponse?.checkoutDate ??
                                  DateTime.now()),
                      color: Color(0xFFFF2C20),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF545454),
                          size: 16,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ));
  }
}
