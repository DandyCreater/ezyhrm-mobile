import 'dart:developer';

import 'package:ezyhr_mobile_apps/module/profile/address/address_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/address/address_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/bank_account/bank_account_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/bank_account/bank_account_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/children/children_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/children/children_list_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/children/children_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/contribution/contribution_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/contribution/contribution_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/kin/kin_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/kin/kin_list_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/kin/kin_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/bank_account_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_edit_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_page.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_response.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_details/personal_details_service.dart';
import 'package:ezyhr_mobile_apps/module/profile/personal_particular_response.dart';
import 'package:ezyhr_mobile_apps/module/widget/common_widget.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';
import 'package:ezyhr_mobile_apps/shared/utils/route_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PersonalDetailsC extends Bindings {
  static const personalDetailsPageRoute = '/personalDetailsPage';
  static final personalDetailsPage = GetPage(
    name: personalDetailsPageRoute,
    page: () => const PersonalDetailsPage(),
    binding: PersonalDetailsC(),
  );

  static const personalDetailsEditPageRoute = '/personalDetailsEditPage';
  static final personalDetailsEditPage = GetPage(
    name: personalDetailsEditPageRoute,
    page: () => const PersonalDetailsEditPage(),
    binding: PersonalDetailsC(),
  );

  static const addressPageRoute = '/addressPage';
  static final addressPage = GetPage(
    name: addressPageRoute,
    page: () => const AddressPage(),
    binding: PersonalDetailsC(),
  );

  static const addressEditPageRoute = '/addressEditPage';
  static final addressEditPage = GetPage(
    name: addressEditPageRoute,
    page: () => const AddressEditPage(),
    binding: PersonalDetailsC(),
  );

  static const contributionPageRoute = '/contributionPage';
  static final contributionPage = GetPage(
    name: contributionPageRoute,
    page: () => const ContributionPage(),
    binding: PersonalDetailsC(),
  );

  static const contributionEditPageRoute = '/contributionEditPage';
  static final contributionEditPage = GetPage(
    name: contributionEditPageRoute,
    page: () => const ContributionEditPage(),
    binding: PersonalDetailsC(),
  );

  static const kinListPageRoute = '/kinListPage';
  static final kinListPage = GetPage(
    name: kinListPageRoute,
    page: () => const KinListPage(),
    binding: PersonalDetailsC(),
  );

  static const kinPageRoute = '/kinPage';
  static final kinPage = GetPage(
    name: kinPageRoute,
    page: () => const KinPage(),
    binding: PersonalDetailsC(),
  );

  static const kinEditPageRoute = '/kinEditPage';
  static final kinEditPage = GetPage(
    name: kinEditPageRoute,
    page: () => const KinEditPage(),
    binding: PersonalDetailsC(),
  );

  static const childrenListPageRoute = '/childrenListPage';
  static final childrenListPage = GetPage(
    name: childrenListPageRoute,
    page: () => const ChildrenListPage(),
    binding: PersonalDetailsC(),
  );

  static const childrenPageRoute = '/childrenPage';
  static final childrenPage = GetPage(
    name: childrenPageRoute,
    page: () => const ChildrenPage(),
    binding: PersonalDetailsC(),
  );

  static const childrenEditPageRoute = '/childrenEditPage';
  static final childrenEditPage = GetPage(
    name: childrenEditPageRoute,
    page: () => const ChildrenEditPage(),
    binding: PersonalDetailsC(),
  );

  static const bankAccountPageRoute = '/bankAccountPage';
  static final bankAccountPage = GetPage(
    name: bankAccountPageRoute,
    page: () => const BankAccountPage(),
    binding: PersonalDetailsC(),
  );

  static const bankAccountEditPageRoute = '/bankAccountEditPage';
  static final bankAccountEditPage = GetPage(
    name: bankAccountEditPageRoute,
    page: () => const BankAccountEditPage(),
    binding: PersonalDetailsC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<PersonalDetailsController>(() => PersonalDetailsController());
  }
}

class PersonalDetailsController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    await getBankCode();
    await getData();
  }

  final storageService = SessionService.instance;
  final personalDetailsService = PersonalDetailsService.instance;

  final isLoading = false.obs;
  final personalDetails = Rxn<PersonalDetailsResponse>();
  final formCtl = GlobalKey<FormState>();
  final currKinIndex = 0.obs;
  final currChildrenIndex = 0.obs;
  final isAddKin = false.obs;
  final isAddChildren = false.obs;

  final personalParticular = Rxn<PersonalParticularResponse>();
  final bankCodeList = Rxn<List<BankCodeResponse>>();
  final bankNameList = Rxn<List<BankCodeResponse>>();
  final isBankAccount = false.obs;
  final currBankAccount = Rxn<BankCodeResponse>();
  final nonEditedBankAccount = Rxn<BankCodeResponse>();

  BuildContext? context;

  final employeeNameCtl = TextEditingController();
  final firstNameCtl = TextEditingController();
  final lastNameCtl = TextEditingController();
  final dateOfBirthCtl = TextEditingController();
  final placeOfBirthCtl = TextEditingController();
  final nationalityCtl = TextEditingController();
  final nricFinNoCtl = TextEditingController();
  final passportNoCtl = TextEditingController();
  final genderCtl = TextEditingController();
  final religionCtl = TextEditingController();
  final maritalStatusCtl = TextEditingController();

  final mobileNoCtl = TextEditingController();
  final homeNoCtl = TextEditingController();
  final emailCtl = TextEditingController();

  final postalCodeCtl = TextEditingController();
  final blockCtl = TextEditingController();
  final streetCtl = TextEditingController();
  final unitCtl = TextEditingController();
  final buildingCtl = TextEditingController();
  final stateCtl = TextEditingController();

  final kinNameCtl = TextEditingController();
  final kinRelationshipCtl = TextEditingController();
  final kinEmailCtl = TextEditingController();
  final kinMobileNoCtl = TextEditingController();
  final kinHomeNoCtl = TextEditingController();

  final childrenNricCtl = TextEditingController();
  final childrenBirthCertNumberCtl = TextEditingController();
  final chidlrenBirthCertNameCtl = TextEditingController();
  final currentAddChildren = ChildrenDetail().obs;
  final currentAddChildrenGender = 'Male'.obs;
  final currentAddChildrenDob = DateTime.now().obs;

  final shareAmountCtl = TextEditingController();

  final swiftCodeCtl = TextEditingController();
  final bankAccountNumberCtl = TextEditingController();
  final bankAccountNameCtl = TextEditingController();

  Future<void> getData() async {
    await getPersonalDetails();

    log("personalDetails.value ${personalDetails.value}");
  }

  Future<void> getPersonalDetails() async {
    try {
      isLoading.value = true;
      final response = await personalDetailsService
          .getPersonalDetails(storageService.getEmployeeId());
      personalDetails.value = response;
      employeeNameCtl.text = personalDetails.value!.employeeName ?? '';
      firstNameCtl.text = personalDetails.value!.firstName ?? '';
      lastNameCtl.text = personalDetails.value!.lastName ?? '';

      nricFinNoCtl.text = personalDetails.value!.nricFinNo ?? '';
      passportNoCtl.text = personalDetails.value!.passportNo ?? '';

      mobileNoCtl.text = personalDetails.value!.mobileNo ?? '';
      homeNoCtl.text = personalDetails.value!.homeNo ?? '';

      postalCodeCtl.text = personalDetails.value!.address?.postalCode ?? '';
      blockCtl.text = personalDetails.value!.address?.block ?? '';
      streetCtl.text = personalDetails.value!.address?.street ?? '';
      unitCtl.text = personalDetails.value!.address?.unit ?? '';
      buildingCtl.text = personalDetails.value!.address?.building ?? '';
      stateCtl.text = personalDetails.value!.address?.state ?? '';

      shareAmountCtl.text =
          personalDetails.value!.contributionAndDonation!.shareAmount == null
              ? '0'
              : personalDetails.value!.contributionAndDonation!.shareAmount
                  .toString();
    } catch (e) {
      print("e @ getPersonalDetails $e");
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      getPersonalParticular();
    }
  }

  void onSubmit() async {
    isLoading.value = true;
    personalDetails.value!.employeeName = employeeNameCtl.text;
    personalDetails.value!.firstName = firstNameCtl.text;
    personalDetails.value!.lastName = lastNameCtl.text;

    personalDetails.value!.nricFinNo = nricFinNoCtl.text;
    personalDetails.value!.passportNo = passportNoCtl.text;

    personalDetails.value!.mobileNo = mobileNoCtl.text;
    personalDetails.value!.homeNo = homeNoCtl.text;
    personalDetails.value!.email = emailCtl.text;

    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void onAddressSubmit() async {
    isLoading.value = true;

    personalDetails.value!.address!.postalCode = postalCodeCtl.text;
    personalDetails.value!.address!.block = blockCtl.text;
    personalDetails.value!.address!.street = streetCtl.text;
    personalDetails.value!.address!.unit = unitCtl.text;
    personalDetails.value!.address!.building = buildingCtl.text;
    personalDetails.value!.address!.state = stateCtl.text;

    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void onContributionSubmit() async {
    isLoading.value = true;
    personalDetails.value!.contributionAndDonation!.shareAmount =
        shareAmountCtl.text;

    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  Future<void> doUpdatePersonalDetails() async {
    try {
      isLoading.value = true;
      final response = await personalDetailsService
          .updatePersonalDetails(personalDetails.value!);

      CommonWidget.showNotif('Success', color: Colors.green);
    } catch (e) {
      print("e @ doUpdatePersonalDetails $e");
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      getData();
      isLoading.value = false;
    }
  }

  void onDobChange(DateRangePickerSelectionChangedArgs args) {
    print('onDateSelectionChanged ${args.value}}');
    personalDetails.value?.dateOfBirth = args.value;
    personalDetails.refresh();
  }

  void onDobConfirm(DateTime args) {
    print('onConfirm ${args}}');
    personalDetails.value?.dateOfBirth = args;
    personalDetails.refresh();
  }

  void setCurrKinIndex(int index) {
    currKinIndex.value = index;
    kinNameCtl.text =
        personalDetails.value!.nextOfKinContact![index].name ?? '';
    kinRelationshipCtl.text = personalDetails
            .value!.nextOfKinContact![index].relationshipToEmployee ??
        '';
    kinEmailCtl.text =
        personalDetails.value!.nextOfKinContact![index].email ?? '';
    kinMobileNoCtl.text =
        personalDetails.value!.nextOfKinContact![index].mobileNo ?? '';
    kinHomeNoCtl.text =
        personalDetails.value!.nextOfKinContact![index].homeNo ?? '';
    currKinIndex.refresh();
  }

  void deleteKin() async {
    try {
      isLoading.value = true;
      personalDetails.value!.nextOfKinContact!.removeAt(currKinIndex.value);
      doUpdatePersonalDetails();

      RouteUtil.back();
      RouteUtil.back();
      CommonWidget.showNotif('Success', color: Colors.green);
    } catch (e) {
      print("e @ deleteKin $e");
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void kinEditSubmit() {
    if (kinEmailCtl.text.isEmpty &&
        kinRelationshipCtl.text.isEmpty &&
        kinNameCtl.text.isEmpty &&
        kinMobileNoCtl.text.isEmpty &&
        kinHomeNoCtl.text.isEmpty) {
      CommonWidget.showErrorNotif('Please fill out atleast one of the field');
      return;
    }
    if (isAddKin.value) {
      onAddKinSubmit();
    } else {
      onKinSubmit();
    }
  }

  void editKin() {
    isAddKin.value = false;
    RouteUtil.to(PersonalDetailsC.kinEditPageRoute);
  }

  void onKinSubmit() async {
    isLoading.value = true;
    personalDetails.value!.nextOfKinContact![currKinIndex.value].name =
        kinNameCtl.text ?? '';
    personalDetails.value!.nextOfKinContact![currKinIndex.value]
        .relationshipToEmployee = kinRelationshipCtl.text ?? '';
    personalDetails.value!.nextOfKinContact![currKinIndex.value].email =
        kinEmailCtl.text ?? '';
    personalDetails.value!.nextOfKinContact![currKinIndex.value].mobileNo =
        kinMobileNoCtl.text ?? '';
    personalDetails.value!.nextOfKinContact![currKinIndex.value].homeNo =
        kinHomeNoCtl.text ?? '';

    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void addKin() {
    isAddKin.value = true;
    resetKinController();
    RouteUtil.to(PersonalDetailsC.kinEditPageRoute);
  }

  void onAddKinSubmit() async {
    isLoading.value = true;
    personalDetails.value!.nextOfKinContact!.add(
      NextOfKinContact(
        name: kinNameCtl.text ?? '',
        relationshipToEmployee: kinRelationshipCtl.text ?? '',
        email: kinEmailCtl.text ?? '',
        mobileNo: kinMobileNoCtl.text ?? '',
        homeNo: kinHomeNoCtl.text ?? '',
      ),
    );
    log(' personalDetails.value${personalDetails.value?.nextOfKinContact!}');
    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void resetKinController() {
    kinNameCtl.text = '';
    kinRelationshipCtl.text = '';
    kinEmailCtl.text = '';
    kinMobileNoCtl.text = '';
    kinHomeNoCtl.text = '';
  }

  void setCurrChildrenIndex(int index) {
    currChildrenIndex.value = index;
    childrenNricCtl.text =
        personalDetails.value!.childrenDetails?[index].nric ?? '';
    currentAddChildrenGender.value =
        personalDetails.value!.childrenDetails?[index].gender ?? "";
    currentAddChildrenDob.value =
        personalDetails.value!.childrenDetails?[index].dateOfBirth ??
            DateTime.now();
    childrenBirthCertNumberCtl.text =
        personalDetails.value!.childrenDetails?[index].birthCertNumber ?? '';
    chidlrenBirthCertNameCtl.text =
        personalDetails.value!.childrenDetails?[index].birthCertName ?? '';
    currKinIndex.refresh();
  }

  void deleteChildren() async {
    try {
      isLoading.value = true;
      personalDetails.value!.childrenDetails!.removeAt(currChildrenIndex.value);
      doUpdatePersonalDetails();

      RouteUtil.back();
      RouteUtil.back();
      CommonWidget.showNotif('Success', color: Colors.green);
    } catch (e) {
      print("e @ deleteChildren $e");
      CommonWidget.showErrorNotif(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void childrenEditSubmit() {
    if (childrenNricCtl.text.isEmpty &&
        childrenBirthCertNumberCtl.text.isEmpty &&
        chidlrenBirthCertNameCtl.text.isEmpty) {
      CommonWidget.showErrorNotif('Please fill out atleast one of the field');
      return;
    }
    if (isAddChildren.value) {
      onAddChildrenSubmit();
    } else {
      onChildrenSubmit();
    }
  }

  void editChildren() {
    isAddChildren.value = false;
    RouteUtil.to(PersonalDetailsC.childrenEditPageRoute);
  }

  void onChildrenSubmit() async {
    isLoading.value = true;

    personalDetails.value!.childrenDetails![currChildrenIndex.value].nric =
        childrenNricCtl.text ?? '';
    personalDetails.value!.childrenDetails![currChildrenIndex.value].gender =
        currentAddChildrenGender.value;
    personalDetails.value!.childrenDetails![currChildrenIndex.value]
        .birthCertNumber = childrenBirthCertNumberCtl.text ?? '';
    personalDetails.value!.childrenDetails![currChildrenIndex.value]
        .dateOfBirth = currentAddChildrenDob.value;

    personalDetails.value!.childrenDetails![currChildrenIndex.value]
        .birthCertName = chidlrenBirthCertNameCtl.text ?? '';

    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void addChildren() {
    isAddChildren.value = true;
    resetChildrenController();
    RouteUtil.to(PersonalDetailsC.childrenEditPageRoute);
  }

  void onChildrenDobChange(DateRangePickerSelectionChangedArgs args) {
    if (isAddChildren.value) {
      currentAddChildrenDob.value = args.value;
    } else {
      personalDetails.value!.childrenDetails![currChildrenIndex.value]
          .dateOfBirth = args.value;

      personalDetails.refresh();
    }
  }

  void onChildrenDobConfirm(DateTime args) {
    if (isAddChildren.value) {
      currentAddChildrenDob.value = args;
    } else {
      personalDetails
          .value!.childrenDetails![currChildrenIndex.value].dateOfBirth = args;
      personalDetails.refresh();
    }
  }

  void onAddChildrenSubmit() async {
    isLoading.value = true;
    personalDetails.value!.childrenDetails!.add(
      ChildrenDetail(
        nric: childrenNricCtl.text ?? '',
        gender: currentAddChildrenGender.value,
        dateOfBirth: currentAddChildrenDob.value,
        birthCertNumber: childrenBirthCertNumberCtl.text ?? '',
        birthCertName: chidlrenBirthCertNameCtl.text ?? '',
      ),
    );
    doUpdatePersonalDetails();

    RouteUtil.back();
  }

  void resetChildrenController() {
    childrenNricCtl.text = '';
    childrenBirthCertNumberCtl.text = '';
    chidlrenBirthCertNameCtl.text = '';
  }

  ChildrenDetail getChildrenDetail() {
    if (isAddChildren.value) {
      return currentAddChildren.value;
    } else {
      return personalDetails.value!.childrenDetails![currChildrenIndex.value];
    }
  }

  Future<void> getBankCode() async {
    try {
      isLoading.value = true;
      final response = await personalDetailsService.getBankCode();
      bankCodeList.value = response;

      var seen = Set<String>();

      final res = bankCodeList.value!.where((e) {
        if (e.bankName != null) {
          return seen.add(e.bankName!);
        } else {
          return false;
        }
      }).toList();
      bankNameList.value = res;
    } catch (e) {
      print("e @ getBankCode $e");
    } finally {
      getPersonalParticular();
    }
  }

  void getPersonalParticular() async {
    try {
      final response = await personalDetailsService
          .getPersonalParticular(storageService.getEmployeeId());
      if (response.bankAccount == null) {
        personalParticular.value = PersonalParticularResponse(
          employeeId: storageService.getEmployeeId().toString(),
          bankAccount: BankAccount(
            bankId: "",
            bankCodeId: 1055,
            bankAccountNumber: "",
            bankAccountName: "",
            bankStatementName: "",
          ),
        );
        isBankAccount.value = false;
      } else {
        isBankAccount.value = true;
        final BankCodeResponse bankCodeResponse = bankCodeList.value
                ?.firstWhere((element) =>
                    element.id == response.bankAccount!.bankCodeId) ??
            BankCodeResponse(
              id: 0,
              bankName: "",
              bankCode: "",
              branchName: "",
              branchCode: "",
              swiftCode: "",
            );

        currBankAccount.value = bankCodeResponse;
        nonEditedBankAccount.value = bankCodeResponse;

        swiftCodeCtl.text = bankCodeResponse.swiftCode ?? '';
        bankAccountNumberCtl.text =
            response.bankAccount!.bankAccountNumber ?? '';
        bankAccountNameCtl.text = response.bankAccount!.bankAccountName ?? '';
        personalParticular.value = response;
      }
      if (personalParticular.value!.drivingLicense == null) {
        personalParticular.value?.drivingLicense = [];
      }
      if (personalParticular.value!.educationFileNames == null) {
        personalParticular.value!.educationFileNames = [];
      }
    } catch (e) {
      print("e @ getPersonalParticular $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<BankCodeResponse> getBankNameList(String type) {
    switch (type) {
      case 'bankName':
        var res = bankNameList.value!;
        res.sort((a, b) => a.bankName!.compareTo(b.bankName!));
        return res;
      case 'bankCode':
        var res = bankCodeList.value!
            .where((element) =>
                element.bankName == currBankAccount.value?.bankName)
            .toList();
        res = res.distinctBy((e) => e.bankCode!).toList();
        res.sort((a, b) => a.bankCode!.compareTo(b.bankCode!));
        return res;

      case 'branchName':
        var res = bankCodeList.value!
            .where((element) =>
                element.bankName == currBankAccount.value?.bankName &&
                element.bankCode == currBankAccount.value?.bankCode)
            .toList();
        res = res.distinctBy((e) => e.branchName!).toList();
        res.sort((a, b) => a.branchName!.compareTo(b.branchName!));

        return res;

      case 'branchCode':
        var res = bankCodeList.value!
            .where((element) =>
                element.bankName == currBankAccount.value?.bankName &&
                element.bankCode == currBankAccount.value?.bankCode &&
                element.branchName == currBankAccount.value?.branchName)
            .toList();
        res = res.distinctBy((e) => e.branchCode!).toList();
        res.sort((a, b) => a.branchCode!.compareTo(b.branchCode!));
        return res;

      default:
        return [];
    }
  }

  void setCurrBankAccount(String name, String type) {
    switch (type) {
      case 'bankName':
        currBankAccount.value = bankCodeList.value!
            .firstWhere((element) => element.bankName == name);
        currBankAccount.refresh();

        break;
      case 'bankCode':
        currBankAccount.value = bankCodeList.value!.firstWhere(
          (element) =>
              element.bankName == currBankAccount.value?.bankName &&
              element.bankCode == name,
        );
        currBankAccount.refresh();

        break;
      case 'branchName':
        currBankAccount.value = bankCodeList.value!.firstWhere(
          (element) =>
              element.bankName == currBankAccount.value?.bankName &&
              element.bankCode == currBankAccount.value?.bankCode &&
              element.branchName == name,
        );
        currBankAccount.refresh();
        break;
      case 'branchCode':
        currBankAccount.value = bankCodeList.value!.firstWhere(
          (element) =>
              element.bankName == currBankAccount.value?.bankName &&
              element.bankCode == currBankAccount.value?.bankCode &&
              element.branchName == currBankAccount.value?.branchName &&
              element.branchCode == name,
        );
        currBankAccount.refresh();

        break;
      default:
    }
  }

  void doUpdatePersonalParticular() async {
    try {
      isLoading.value = true;
      PersonalParticularResponse response = PersonalParticularResponse();

      if (isBankAccount.value) {
        print('k');
        response = await personalDetailsService
            .updatePersonalParticular(personalParticular.value!);
      } else {
        print('k');

        response = await personalDetailsService
            .createPersonalparticular(personalParticular.value!);
        isBankAccount.value = true;
      }
      personalParticular.value = response;
      isBankAccount.value = true;

      getData();

      CommonWidget.showNotif('Success', color: Colors.green);
    } catch (e) {
      print("e @ doUpdatePersonalParticular $e");
      CommonWidget.showErrorNotif("Failed to update bank account");
    } finally {
      isLoading.value = false;
    }
  }

  void onBankAccountSubmit() async {
    isLoading.value = true;
    personalParticular.value!.bankAccount!.bankCodeId = bankCodeList.value!
        .firstWhere((element) =>
            element.bankName == currBankAccount.value?.bankName &&
            element.bankCode == currBankAccount.value?.bankCode &&
            element.branchName == currBankAccount.value?.branchName &&
            element.branchCode == currBankAccount.value?.branchCode)
        .id;
    personalParticular.value!.bankAccount!.bankAccountNumber =
        bankAccountNumberCtl.text ?? '';
    personalParticular.value!.bankAccount!.bankAccountName =
        bankAccountNameCtl.text ?? '';
    personalParticular.value!.createdDate = DateTime.now();
    personalParticular.value!.creatorEmployeeId =
        storageService.getEmployeeId().toString();
    personalParticular.value!.dateModified = DateTime.now();
    personalParticular.value!.lastModifiedEmployeeId =
        storageService.getEmployeeId().toString();

    doUpdatePersonalParticular();
    RouteUtil.back();
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
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object getCompareValue(T e)) {
    var result = <T>[];
    this.forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element)))
        result.add(element);
    });

    return result;
  }
}
