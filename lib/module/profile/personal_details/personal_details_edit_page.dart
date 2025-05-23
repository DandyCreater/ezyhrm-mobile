import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_controller.dart';
import 'package:ezyhr_mobile_apps/module/widget/button.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/module/widget/field_modal_widget.dart';
import 'package:ezyhr_mobile_apps/shared/constant/color_constant.dart';
import 'package:ezyhr_mobile_apps/shared/utils/common_util.dart';
import 'package:ezyhr_mobile_apps/shared/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PersonalDetailsEditPage extends GetView<PersonalDetailsController> {
  const PersonalDetailsEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar(
        'Edit Personal Details',
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
                headerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          decoration: CommonWidget.defBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.textPrimaryWidget(
                'Employee Name',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.employeeNameCtl,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Employee Name',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'First Name',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.firstNameCtl,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'First Name',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Last Name',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.lastNameCtl,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Last Name',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Date of Birth',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => {
                  showDialog(
                    context: Get.context!,
                    builder: (ctx) {
                      var paddingHz = 36.0;
                      var el = Get.width / Get.height;
                      if (el > 1.3) {
                        paddingHz = Get.width * .3;
                      }
                      return Dialog(
                        insetPadding: EdgeInsets.symmetric(
                            horizontal: paddingHz, vertical: 48),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: CommonWidget.textPrimaryWidget(
                                      'Select Date',
                                      color: ColorConstant.grey90,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    )),
                                    InkWell(
                                        onTap: Get.back,
                                        child: Icon(Icons.close,
                                            size: SizeUtil.f(20))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SfDateRangePicker(
                                  onSelectionChanged: controller.onDobChange,
                                  selectionColor: Colors.green,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  view: DateRangePickerView.month,
                                  showActionButtons: true,
                                  onSubmit: (dynamic value) {
                                    controller.onDobConfirm(value);

                                    Get.back();
                                  },
                                  rangeSelectionColor:
                                      Color(0xFF8BBF5A).withOpacity(0.3),
                                  todayHighlightColor: Color(0xFF8BBF5A),
                                  endRangeSelectionColor: Color(0xFF8BBF5A),
                                  startRangeSelectionColor: Color(0xFF8BBF5A),
                                  confirmText: "Confirm",
                                  cancelText: "Cancel",
                                  onCancel: () {
                                    Get.back();
                                  },
                                  initialSelectedDate: controller
                                      .personalDetails.value?.dateOfBirth,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                },
                child: Obx(
                  () => Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: controller.personalDetails.value == null
                          ? Color(0xFFF5F5F5)
                          : Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorConstant.grey40,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.personalDetails.value?.dateOfBirth ==
                                    null
                                ? 'Select Date'
                                : DateFormat.yMMMEd().format(
                                    controller
                                        .personalDetails.value!.dateOfBirth!,
                                  ),
                            style: CommonWidget.textStyleRoboto(
                              fontWeight: FontWeight.w400,
                              fontSize: SizeUtil.f(16),
                              color: ColorConstant.grey90,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color(0xFFAFAFAF),
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Place of Birth',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.placeOfBirth}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: listOfCounteries,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.placeOfBirth = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.placeOfBirth,
                      title: 'Place of Birth',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Nationality',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.nationality}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: listOfCounteries,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.nationality = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.nationality,
                      title: 'Nationality',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'NRIC FIN NO',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.nricFinNoCtl,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'NRIC FIN No',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Passport No',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.passportNoCtl,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Passport No',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Gender',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.gender}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: [
                        "Male",
                        "Female",
                      ],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.gender = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.gender,
                      title: 'Gender',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Race',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.race}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: [
                        "Chinese",
                        "Eurasian",
                        "Indian",
                        "Malay",
                        "Other",
                      ],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.race = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.race,
                      title: 'Race',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Religion',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.religion}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: [
                        "Buddhist",
                        "Christian",
                        "Free Thinker",
                        "Hindu",
                        "Muslim",
                        "Sikh",
                        "Taoist",
                        "Others",
                      ],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.religion = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.religion,
                      title: 'Religion',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Marital Status',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.maritalStatus ?? ''}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : null,
                  actions: [
                    Icon(Icons.keyboard_arrow_down,
                        size: SizeUtil.f(20), color: ColorConstant.grey90),
                  ],
                  onTap: () {
                    CommonUtil.unFocus(context: controller.context);
                    FieldModalWidget.showModal<String, String>(
                      data: [
                        "Married",
                        "Single",
                        "Divorced",
                        "Widowed",
                      ],
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.maritalStatus = e;
                        controller.personalDetails.refresh();
                      },
                      value: controller.personalDetails.value?.maritalStatus,
                      title: 'Marital Status',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Mobile Number',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.mobileNoCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Mobile Number',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Home Number',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.homeNoCtl,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Home Number',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Email',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value ||
                        controller.personalDetails.value == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : CommonWidget.textFieldWidget(
                        controller: controller.emailCtl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.words,
                        placeholder: 'Email',
                      ),
              ),
              const SizedBox(height: 24),
              CommonWidget.textPrimaryWidget(
                'Highest Qualification',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Obx(
                () => FieldModalWidget.fieldWidget(
                  placeholder: 'Select',
                  value: controller.personalDetails.value != null
                      ? CommonWidget.textPrimaryWidget(
                          '${controller.personalDetails.value?.highestQualification ?? ""}',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.grey90,
                        )
                      : CommonWidget.textPrimaryWidget(
                          ' ',
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
                      data: qualifications,
                      caption: (e) => e,
                      onSelect: (e) {
                        controller.personalDetails.value?.highestQualification =
                            e;
                        controller.personalDetails.refresh();
                      },
                      value: controller
                              .personalDetails.value?.highestQualification ??
                          " ",
                      title: 'Highest Qualification',
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomFilledButton(
                  width: double.infinity,
                  title: 'Submit',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.onSubmit();
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        )
      ],
    );
  }
}

final listOfCounteries = [
  "United States",
  "Canada",
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and/or Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegovina",
  "Botswana",
  "Bouvet Island",
  "Brazil",
  "British Indian Ocean Territory",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Cape Verde",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos (Keeling) Islands",
  "Colombia",
  "Comoros",
  "Congo",
  "Cook Islands",
  "Costa Rica",
  "Croatia (Hrvatska)",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "East Timor",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Ethiopia",
  "Falkland Islands (Malvinas)",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "France, Metropolitan",
  "French Guiana",
  "French Polynesia",
  "French Southern Territories",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Heard and Mc Donald Islands",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran (Islamic Republic of)",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Ivory Coast",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, Democratic People's Republic of",
  "Korea, Republic of",
  "Kuwait",
  "Kyrgyzstan",
  "Lao People's Democratic Republic",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libyan Arab Jamahiriya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macau",
  "Macedonia",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia, Federated States of",
  "Moldova, Republic of",
  "Monaco",
  "Mongolia",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "Netherlands Antilles",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Niue",
  "Norfolk Island",
  "Northern Mariana Islands",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Reunion",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia South Sandwich Islands",
  "Spain",
  "Sri Lanka",
  "St. Helena",
  "St. Pierre and Miquelon",
  "Sudan",
  "Suriname",
  "Svalbard and Jan Mayen Islands",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syrian Arab Republic",
  "Taiwan",
  "Tajikistan",
  "Tanzania, United Republic of",
  "Thailand",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks and Caicos Islands",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States minor outlying islands",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Vatican City State",
  "Venezuela",
  "Vietnam",
  "Virgin Islands (British)",
  "Virgin Islands (U.S.)",
  "Wallis and Futuna Islands",
  "Western Sahara",
  "Yemen",
  "Yugoslavia",
  "Zaire",
  "Zambia",
  "Zimbabwe"
];
final qualifications = [
  "Primary",
  "Lower Secondary",
  "Secondary",
  "Post Secondary (Non-Teriary): General & Vocational",
  "Polytechnic Diploma",
  "Professional Qualification and Other Diploma",
  "Bachelor's or Equivalent",
  "Postgrad. DiplomaCertificate [Excluding masters and doctorate]",
  "Master's and Doctorate"
];
