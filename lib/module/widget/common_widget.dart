import 'dart:async';
import 'dart:io';

import 'package:ezyhr_mobile_apps/shared/services/asset_app_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart' as p;
import 'package:shimmer/shimmer.dart';

import '../../di.dart';
import '../../shared/constant/app_asset_constant.dart';
import '../../shared/constant/color_constant.dart';
import '../../shared/response/app_asset_res.dart';
import '../../shared/utils/common_util.dart';
import '../../shared/utils/route_util.dart';
import '../../shared/utils/size_util.dart';

class CommonWidget {
  static AppBar appBar(
    String title, {
    List<Widget> actions = const [],
    bool isBack = true,
    Color? bgColor,
    Color? color,
    Function()? onBack,
    bool centerTitle = false,
    Widget? rightWidget,
    Widget? bottomWidget,
  }) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 60,
      leading: isBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
              onPressed: onBack ?? () => Get.back(),
            )
          : null,
      centerTitle: true,
      flexibleSpace: CommonWidget.imageWidget(
        path: 'assets/images/vector.png',
        imgPathType: ImgPathType.asset,
        fit: BoxFit.fill,
        width: Get.width,
        isFlexible: true,
      ),
      title: Text(
        title,
        textAlign: centerTitle ? TextAlign.center : TextAlign.left,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      actions: actions,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: bottomWidget,
            )
          : null,
      backgroundColor: bgColor ?? Color(0xffF6F6F6),
    );
  }

  static Text textPrimaryWidget(
    String text, {
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    TextAlign align = TextAlign.left,
    FontStyle? fontStyle,
    int? maxLines,
    bool? softWrap,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
      softWrap: softWrap,
    );
  }

  static TextStyle textStyleNunito({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.roboto(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: SizeUtil.f(fontSize ?? 14),
      color: color ?? ColorConstant.grey90,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle textStyleRoboto({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.roboto(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: SizeUtil.f(fontSize ?? 14),
      color: color ?? ColorConstant.grey90,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle textStyleFiraSans({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.firaSans(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: SizeUtil.f(fontSize ?? 14),
      color: color ?? ColorConstant.grey90,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle textStyleMontserrat({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.montserrat(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: SizeUtil.f(fontSize ?? 14),
      color: color ?? ColorConstant.grey90,
      fontStyle: fontStyle,
    );
  }

  static Container textLoadingWidget(
      {double height = 24, double? width, Color? color, double radius = 12}) {
    return Container(
      height: SizeUtil.f(height),
      width: width ?? (Get.width * .35),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey0.withOpacity(.5),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  static Container circleLoadingWidget({double? size, Color? color}) {
    return Container(
      height: SizeUtil.f(size ?? 50),
      width: SizeUtil.f(size ?? 50),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey40,
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget noDataWidget({
    String caption = 'Belum Ada Data',
    double? height,
    double? width,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        imageWidget(
          path: 'assets/images/img_empty.png',
          imgPathType: ImgPathType.asset,
          height: height ?? SizeUtil.cfw(),
          width: width ?? SizeUtil.cfw(),
          isFlexible: false,
        ),
        const SizedBox(height: 12),
        if (caption.isNotEmpty)
          textPrimaryWidget(
            caption,
            color: ColorConstant.grey90,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  static Widget groupListWidget<T, E>({
    required List<T> elements,
    required E Function(T e) groupBy,
    required Widget Function(T data) header,
    required Widget Function(T data) content,
    int Function(T a, T b)? compare,
  }) {
    final dataHeader = elements.map(groupBy).toList();
    return ListView(
      children: [
        ...dataHeader.map((e) {
          return Column(
            children: [
              elements
                  .where((e1) => e == groupBy(e1))
                  .map((e) => header(e))
                  .first,
              ...elements
                  .where((e1) => e == groupBy(e1))
                  .map((e1) => content(e1))
                  .toList(),
            ],
          );
        }),
      ],
    );
  }

  static BoxDecoration defBoxDecoration(
      {double radius = 8,
      Color? bgColor,
      BoxShape? shape,
      double blurRadius = 8,
      String? image}) {
    return BoxDecoration(
      color: bgColor ?? Colors.white,
      borderRadius:
          shape == null ? BorderRadius.all(Radius.circular(radius)) : null,
      shape: shape ?? BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: blurRadius,
          spreadRadius: 0,
          offset: const Offset(0, 0),
        ),
      ],
      image: image == null
          ? null
          : DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
    );
  }

  static Widget bottomSummaryButtonWidget({
    Color? bgColor,
    String? title,
    String? actionTitle,
    String? btCaption,
    IconData? btSuffixIcon,
    Color? btCaptionColor,
    Color? btBgColor,
    Function()? onTap,
    bool isLoading = false,
    IconData? prefixIcon,
    double iconSize = 20,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: defBoxDecoration(radius: 0, bgColor: bgColor),
          child: Column(
            children: [
              if (title != null || actionTitle != null) ...[
                Row(
                  children: [
                    textPrimaryWidget(
                      title ?? '',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorConstant.grey90,
                    ),
                    const Spacer(),
                    textPrimaryWidget(
                      actionTitle ?? '',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ColorConstant.grey90,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 12),
              primaryButtonWidget(
                caption: btCaption,
                onTap: onTap,
                prefixIcon: prefixIcon,
                bgColor: btBgColor,
                captionColor: btCaptionColor,
                suffixIcon: btSuffixIcon,
                isLoading: isLoading,
                iconSize: iconSize,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  static textFieldWidget({
    TextStyle? textStyle,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    Function(String value)? onSubmit,
    String? placeholder,
    TextStyle? placeholderStyle,
    List<FieldValidator> validator = const [],
    TextEditingController? controller,
    Widget? prefix,
    int? maxLines = 1,
    int? minLines,
    Widget? suffix,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    bool? isDense,
    EdgeInsetsGeometry? padding,
    ValueChanged<String>? onChanged,
    int? maxLength,
    bool counterText = false,
    Color? bgColor,
    bool? useBgColor,
    bool useBorder = true,
    Function()? onEditingComplete,
    bool? enabled,
    TextAlign textAlign = TextAlign.start,
    String? initialValue,
    bool readOnly = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      textAlign: textAlign,
      onFieldSubmitted: onSubmit,
      onEditingComplete: onEditingComplete,
      enabled: enabled,
      maxLength: maxLength,
      onChanged: onChanged,
      obscureText: obscureText,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      controller: controller,
      style: textStyle ??
          textStyleRoboto(
            fontWeight: FontWeight.w400,
            fontSize: SizeUtil.f(16),
            color: ColorConstant.grey90,
          ),
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      decoration: inputDecoration(
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        prefix: prefix,
        suffix: suffix,
        isDense: isDense,
        padding: padding,
        counterText: counterText,
        bgColor: bgColor,
        useBgColor: useBgColor,
        useBorder: useBorder,
      ),
      validator: MultiValidator([...validator]),
      inputFormatters: inputFormatters,
    );
  }

  static InputDecoration inputDecoration({
    String? placeholder,
    TextStyle? placeholderStyle,
    Widget? prefix,
    Widget? suffix,
    bool? isDense,
    EdgeInsetsGeometry? padding,
    bool counterText = false,
    Color? bgColor,
    bool? useBgColor,
    bool useBorder = true,
  }) {
    return InputDecoration(
      fillColor: bgColor,
      filled: useBgColor,
      counterText: counterText ? null : '',
      isDense: isDense,
      contentPadding: padding,
      prefixIcon: prefix,
      hintText: placeholder,
      hintStyle: placeholderStyle ??
          textStyleRoboto(
            fontWeight: FontWeight.w400,
            fontSize: SizeUtil.f(16),
            color: ColorConstant.grey60,
          ),
      border: OutlineInputBorder(
        borderSide: useBorder
            ? BorderSide(color: ColorConstant.grey60, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: useBorder
            ? BorderSide(color: ColorConstant.grey1000, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: useBorder
            ? BorderSide(color: ColorConstant.grey1000, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: useBorder
            ? BorderSide(color: ColorConstant.grey1000, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIcon: suffix,
    );
  }

  static ElevatedButton primaryButtonWidget({
    Color? bgColor,
    String? caption,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? captionColor,
    Function()? onTap,
    double iconSize = 20,
    bool isLoading = false,
    double padV = 16,
    BorderSide? border,
  }) {
    return ElevatedButton(
      onPressed: !isLoading ? onTap : () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? ColorConstant.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          shadowColor: Colors.transparent,
          side: border),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: padV),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  height: SizeUtil.f(20),
                  width: SizeUtil.f(20),
                  child: CircularProgressIndicator.adaptive(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorConstant.grey0),
                    strokeWidth: 2,
                  ),
                ),
              if (!isLoading && prefixIcon != null) ...[
                Icon(prefixIcon,
                    color: captionColor ?? Colors.white,
                    size: SizeUtil.f(iconSize)),
                const SizedBox(width: 4),
              ],
              if (!isLoading)
                textPrimaryWidget(
                  caption ?? 'Next',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: captionColor ?? ColorConstant.grey0,
                ),
              if (!isLoading && suffixIcon != null) ...[
                const SizedBox(width: 4),
                Icon(suffixIcon,
                    color: captionColor ?? Colors.white,
                    size: SizeUtil.f(iconSize)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static TextButton textButtonWidget(
      {String? caption,
      Function()? onTap,
      Color? captionColor,
      Color? borderColor,
      bool isLoading = false}) {
    return TextButton(
        onPressed: !isLoading ? onTap : () {},
        child: Text(
          caption ?? 'Selanjutnya',
          style: TextStyle(
            color: captionColor ?? ColorConstant.grey80,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ));
  }

  static ElevatedButton secondaryButtonWidget({
    Color? borderColor,
    String? caption,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? captionColor,
    Function()? onTap,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: !isLoading ? onTap : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: BorderSide(color: borderColor ?? ColorConstant.primary, width: 1),
        shadowColor: Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  height: SizeUtil.f(20),
                  width: SizeUtil.f(20),
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ColorConstant.primaryDark),
                    strokeWidth: 2,
                  ),
                ),
              if (!isLoading && prefixIcon != null) ...[
                Icon(prefixIcon, color: captionColor ?? ColorConstant.primary),
                const SizedBox(width: 4),
              ],
              if (!isLoading)
                textPrimaryWidget(
                  caption ?? 'Selanjutnya',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: captionColor ?? ColorConstant.primary,
                ),
              if (!isLoading && suffixIcon != null) ...[
                const SizedBox(width: 4),
                Icon(suffixIcon, color: captionColor ?? ColorConstant.primary),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Widget expandedScrollWidget({
    List<Widget> top = const [],
    List<Widget> bottom = const [],
    CrossAxisAlignment crossAlign = CrossAxisAlignment.start,
    ScrollPhysics? physics,
    bool overscroll = true,
  }) {
    return CustomScrollView(
      scrollBehavior: overscroll
          ? null
          : const ScrollBehavior().copyWith(overscroll: false),
      physics: physics,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: crossAlign,
            children: [...top, const Spacer(), ...bottom],
          ),
        ),
      ],
    );
  }

  static void showNotif(String msg, {Color? color}) {
    showSimpleNotification(
      textPrimaryWidget(
        msg,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: ColorConstant.grey0,
      ),
      background: color ?? ColorConstant.green80,
      duration: const Duration(seconds: 3),
      slideDismissDirection: DismissDirection.vertical,
    );
  }

  static void showErrorNotif(String msg) {
    showSimpleNotification(
      textPrimaryWidget(
        msg,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: ColorConstant.grey0,
      ),
      background: Colors.red,
      duration: const Duration(seconds: 3),
      slideDismissDirection: DismissDirection.vertical,
    );
  }

  static final ImagePicker _imgPicker = ImagePicker();

  static void chooseImage(
      {Function(XFile? image)? Function,
      List<File>? file,
      onChoose,
      bool? showGallery,
      bool? showDelete}) async {
    Get.bottomSheet(
      Container(
        height: SizeUtil.f(Get.height * .43),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          color: ColorConstant.grey0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  CommonWidget.textPrimaryWidget(
                    'Choose Image',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorConstant.grey90,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  if (showGallery == null || showGallery)
                    InkWell(
                      onTap: () async {
                        final XFile? image = await _imgPicker.pickImage(
                            source: ImageSource.gallery, imageQuality: 40);
                        if (onChoose != null) {
                          onChoose(image);
                        }
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorConstant.primary),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.photo, color: ColorConstant.primary),
                            const SizedBox(width: 12),
                            textPrimaryWidget(
                              'Gallery',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: () async {
                      final XFile? photo = await _imgPicker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 40,
                        preferredCameraDevice: CameraDevice.front,
                      );
                      if (onChoose != null) {
                        onChoose(photo);
                      }
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConstant.primary),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.photo_camera,
                              color: ColorConstant.primary),
                          const SizedBox(width: 12),
                          textPrimaryWidget(
                            'Camera',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (showDelete == null || showDelete)
                    InkWell(
                      onTap: () async {
                        if (onChoose != null) {
                          onChoose(null);
                        }
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorConstant.primary),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: ColorConstant.primary),
                            const SizedBox(width: 12),
                            textPrimaryWidget(
                              'Delete',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final FilePicker _filePicker = FilePicker.platform;

  static void chooseFile(Function(List<File>? file, bool isCancel) onChoose,
      {bool withDelete = true}) async {
    Get.bottomSheet(
      Container(
        height: SizeUtil.f(Get.height * .33),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          color: ColorConstant.grey0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () async {
                      final XFile? photo = await _imgPicker.pickImage(
                          source: ImageSource.camera, imageQuality: 40);
                      if (photo != null) {
                        onChoose([File(photo.path)], false);
                      } else {
                        onChoose(null, true);
                      }
                      RouteUtil.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConstant.primary),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.photo_camera,
                              color: ColorConstant.primary),
                          const SizedBox(width: 12),
                          textPrimaryWidget(
                            'Camera',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final res = await _filePicker.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: [
                          'jpg',
                          'jpeg',
                          'png',
                          'pdf',
                          'JPG',
                          'JPEG',
                          'PNG',
                          'PDF'
                        ],
                      );
                      final files = res?.paths.map((e) => File(e!)).toList();

                      if (files != null) {
                        onChoose(files, false);
                      } else {
                        onChoose(null, true);
                      }
                      RouteUtil.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorConstant.primary),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.file_copy, color: ColorConstant.primary),
                          const SizedBox(width: 12),
                          textPrimaryWidget(
                            'Pilih Berkas',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.grey90,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (withDelete)
                    InkWell(
                      onTap: () async {
                        onChoose(null, false);
                        RouteUtil.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorConstant.primary),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: ColorConstant.primary),
                            const SizedBox(width: 12),
                            textPrimaryWidget(
                              'Delete',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorConstant.grey90,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void bottomModalWidget({
    Widget? widget,
    double? height,
    bool isDismissible = true,
    bool dragClose = true,
    bool isScrollControlled = false,
  }) {
    Get.bottomSheet(
      Container(
        height: !isScrollControlled
            ? SizeUtil.f(height ?? (Get.height * .33))
            : null,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          color: ColorConstant.grey0,
        ),
        child: widget ?? const SizedBox(),
      ),
      isDismissible: isDismissible,
      enableDrag: dragClose,
      isScrollControlled: true,
    );
  }

  static void modalWidget({
    List<Widget> widgets = const [],
    bool withClose = true,
    bool dismissible = true,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    var paddingHz = 24.0;
    final ar = Get.width / Get.height;
    if (ar > 1.3) {
      paddingHz = Get.width * .3;
    }

    Get.dialog(
        Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: paddingHz, vertical: 24),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (withClose)
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ...widgets,
              ],
            ),
          ),
        ),
        barrierDismissible: dismissible);
  }

  static Future<bool?> modalConfirmWidget({
    List<Widget> widgets = const [],
    bool result = false,
    double? width,
    bool dismissible = true,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) async {
    if (DependencyInjection.isLandscape.value) {
      width = SizeUtil.cfw();
    }
    await Get.defaultDialog(
      barrierDismissible: dismissible,
      title: '',
      radius: 12,
      content: SizedBox(
        width: width ?? Get.width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        ),
      ),
    );
    return result;
  }

  static Widget imageWidget({
    required String path,
    required ImgPathType imgPathType,
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    bool isFlexible = true,
    bool withBaseEndpoint = true,
    AppAssetEnum? assetType,
  }) {
    final ext = p.extension(path);
    final h =
        height != null ? (isFlexible ? SizeUtil.f(height) : height) : null;
    final w = width != null ? (isFlexible ? SizeUtil.f(width) : width) : null;

    if (imgPathType == ImgPathType.asset) {
      if (CommonUtil.isBlank(path) && CommonUtil.isBlank(assetType)) {
        debugPrint('imageWidget=invalid image asset');
        return const SizedBox();
      }

      if (CommonUtil.isBlank(path)) {
        final assetTemp = CommonUtil.firstWhereEqStr(
            AssetAppService.assetGlobal.value,
            (t) => t?.assetType.name,
            assetType?.name);
        path = assetTemp!.path;

        if (assetTemp.isInternal) {
          if (CommonUtil.containsIgnoreCase(ext, AppAssetRes.svgFormat)) {
            return SvgPicture.asset(
              path,
              fit: fit,
              height: h,
              width: w,
            );
          } else {
            return Image.asset(
              path,
              fit: fit,
              height: h,
              width: w,
            );
          }
        } else {
          if (CommonUtil.containsIgnoreCase(ext, AppAssetRes.svgFormat)) {
            return SvgPicture.file(
              File(path),
              fit: fit,
              height: h,
              width: w,
            );
          } else {
            return Image.file(
              File(path),
              fit: fit,
              height: h,
              width: w,
            );
          }
        }
      } else {
        if (CommonUtil.containsIgnoreCase(ext, AppAssetRes.svgFormat)) {
          return SvgPicture.asset(
            path,
            fit: fit,
            height: h,
            width: w,
          );
        } else {
          return Image.asset(
            path,
            fit: fit,
            height: h,
            width: w,
          );
        }
      }
    } else if (imgPathType == ImgPathType.file) {
      if (CommonUtil.containsIgnoreCase(ext, AppAssetRes.svgFormat)) {
        // return SvgPicture.file(
        //   File(path),
        //   fit: fit,
        //   height: h,
        //   width: w,
        // );
        return SizedBox();
      } else {
        return Image.file(
          File(path),
          fit: fit,
          height: h,
          width: w,
        );
      }
    } else if (imgPathType == ImgPathType.network) {
      if (CommonUtil.containsIgnoreCase(ext, AppAssetRes.svgFormat)) {
        return SvgPicture.network(
          path,
          fit: fit,
          height: h,
          width: w,
        );
      }
    }
    debugPrint('imageWidget=invalid image or image not found');
    return const SizedBox();
  }

  static Widget singaporeanCurrencyWidget(
      {required double value, TextStyle? textStyle}) {
    final formattedValue =
        NumberFormat.currency(locale: 'en_SG', symbol: '\$').format(value);
    return Text(
      formattedValue,
      style: textStyle ??
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
    );
  }

  static Widget fieldAndValue(
    String fieldName,
    String value,
    Widget? fieldValue,
    bool isLoading, {
    bool isDivider = true,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        CommonWidget.textPrimaryWidget(
          fieldName,
          color: Color(0xFF545454),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        const SizedBox(height: 4),
        isLoading
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
            : fieldValue ??
                CommonWidget.textPrimaryWidget(
                  value,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
        if (isDivider) const Divider(thickness: 1),
      ],
    );
  }

  static Widget titleAndValue(String title, String value,
      {bool? divider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.textPrimaryWidget(
          title,
          color: Color(0xFF545454),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 4,
        ),
        CommonWidget.textPrimaryWidget(
          value,
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        if (divider != null && divider)
          const Divider(
            thickness: 1,
          ),
      ],
    );
  }

  static Widget titleAndComponent(String title, Widget value,
      {bool? divider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.textPrimaryWidget(
          title,
          color: Color(0xFF545454),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 4,
        ),
        value,
        if (divider != null && divider)
          const Divider(
            thickness: 1,
          ),
      ],
    );
  }

  static Widget fieldName(String title, {bool isRequired = true}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          isRequired
              ? TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                )
              : TextSpan(),
        ],
      ),
    );
  }
}
