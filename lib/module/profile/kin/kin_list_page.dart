import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KinListPage extends GetView<PersonalDetailsController> {
  const KinListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CommonWidget.appBar(
        'Next of Kin',
        isBack: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: () => controller.getData(),
      child: Obx(
        () => CommonWidget.expandedScrollWidget(
            physics: const AlwaysScrollableScrollPhysics(),
            overscroll: false,
            top: [
              ...headerWidget(),
            ],
            bottom: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: CommonWidget.primaryButtonWidget(
                  caption: 'Add Next of Kin',
                  prefixIcon: Icons.add,
                  onTap: () => controller.addKin(),
                ),
              ),
            ]),
      ),
    );
  }

  headerWidget() {
    if (controller.isLoading.value ||
        controller.personalDetails.value == null) {
      return List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: CommonWidget.defBoxDecoration(),
          child: Row(
            children: [
              Container(
                height: SizeUtil.f(50),
                width: SizeUtil.f(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.grey40,
                ),
              ),
              const SizedBox(width: 24),
              CommonWidget.textLoadingWidget(color: ColorConstant.grey40),
            ],
          ),
        ),
      );
    } else if (controller.personalDetails.value?.nextOfKinContact?.isEmpty ??
        true) {
      return [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: CommonWidget.textPrimaryWidget(
            'No Data Found',
            color: Colors.black,
          ),
        )
      ];
    } else {
      return controller.personalDetails.value?.nextOfKinContact
          ?.asMap()
          .map(
            (i, e) => MapEntry(
              i,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: InkWell(
                  onTap: () {
                    controller.setCurrKinIndex(i);
                    RouteUtil.to(PersonalDetailsC.kinPageRoute);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    decoration: CommonWidget.defBoxDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF0689FF),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidget.textPrimaryWidget(
                                      e.name ?? '-',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 8),
                                    CommonWidget.textPrimaryWidget(
                                      'Relation',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 4),
                                    CommonWidget.textPrimaryWidget(
                                      e.relationshipToEmployee ?? '-',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xFF784DFF),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ]),
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList();
    }
  }
}
