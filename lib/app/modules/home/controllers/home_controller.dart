import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/core/services/member_service.dart';
import 'package:raxii_desktop/app/core/services/partner_service.dart';
import 'package:raxii_desktop/app/core/services/plan_service.dart';
import 'package:raxii_desktop/app/data/models/partner.dart';
import 'package:raxii_desktop/app/data/models/plan.dart';
import 'package:raxii_desktop/app/data/models/service.dart';
import 'package:raxii_desktop/app/data/providers/auth_providers.dart';
import 'package:raxii_desktop/app/shared/enum.dart';
import 'package:raxii_desktop/app/shared/toaster.dart';
import 'package:toastification/toastification.dart';

class HomeController extends GetxController {
  final currentStep = Rx<int>(0);
  // Step 1: Member info
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final isExistingMember = Rx<bool?>(null);
  final isSearchingMemebr = false.obs;
  final isCreatingMember = false.obs;
  void createMember(BuildContext context) async {
    isCreatingMember.value = true;
    final res = await MemberService.to.createMember(
      phone: phoneController.text,
      lastName: lnameController.text,
      firstName: fnameController.text,
      otp: otpController.text,
      cardIdentifier: cardController.text,
    );
    isCreatingMember.value = false;
    if (res.isRight) {
      currentStep.value += 1;
      toaster(
        // ignore: use_build_context_synchronously
        context: context,
        title: "Success",
        description: "Member reegistered Successfully",
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
      );
    } else {
      toaster(
        // ignore: use_build_context_synchronously
        context: context,
        title: "Error",
        description: res.left,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );
    }
  }

  void searchMember(BuildContext context) async {
    isSearchingMemebr.value = true;
    final res =
        await MemberService.to.searchMember(identifier: phoneController.text);
    if (res.isRight) {
      fnameController.text = res.right.firstName ?? "N/A";
      lnameController.text = res.right.lastName ?? "N/A";
      cardController.text =
          res.right.card != null ? res.right.card!.identifier : '';
      isExistingMember.value = true;
    } else {
      fnameController.clear();
      lnameController.clear();
      isExistingMember.value = false;
      if (phoneController.text.length == 10) {
        final res = await AuthProvider.to.sendOtp(
          phone: phoneController.text,
          accessToken: AuthService.to.user.value!.accessToken!,
        );
        if (res.isRight) {
          toaster(
            // ignore: use_build_context_synchronously
            context: context,
            title: "Success",
            description: "Otp sent to ${phoneController.text}",
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
          );
        } else {
          toaster(
            // ignore: use_build_context_synchronously
            context: context,
            title: "Error",
            description: res.left,
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
          );
        }
      } else {
        toaster(
          // ignore: use_build_context_synchronously
          context: context,
          title: "Error",
          description: res.left,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
        );
      }
    }
    isSearchingMemebr.value = false;
  }

  // Step 2: Subscription selection
  final services = <Service>[].obs;
  final selectedServices = <Service>[].obs;
  void toggleServiceSelection(Service service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
  }

  final selectedDuration = Rx<SubscriptionDuration?>(null);
  List<SubscriptionDuration> durations = [
    SubscriptionDuration.DAY,
    SubscriptionDuration.WEEK,
    SubscriptionDuration.MONTH,
    SubscriptionDuration.THREE_MONTHS,
    SubscriptionDuration.SIX_MONTHS,
    SubscriptionDuration.YEAR,
  ];
  void toggleDurationSelection(SubscriptionDuration duration) {
    if (selectedDuration.value == duration) {
      selectedDuration.value = null;
    } else {
      selectedDuration.value = duration;
    }
  }

  final partners = <Partner>[].obs;
  final selectedPartner = Rx<Partner?>(null);
  void togglePartner(Partner partner) {
    if (selectedPartner.value == partner) {
      selectedPartner.value = null;
    } else {
      selectedPartner.value = partner;
    }
  }

  final plans = <Plan>[].obs;
  final isGettingPlans = false.obs;
  void getFilteredPlans() async {
    isGettingPlans.value = true;
    final res = await PlanService.to.getPlans(
        duration: selectedDuration.value,
        partner: selectedPartner.value,
        service: selectedServices);
    isGettingPlans.value = false;
    if (res.isRight) {
      plans.value = res.right;
      currentStep.value += 1;
    }
  }

  void onStepContinue(BuildContext context) {
    if (currentStep.value < 3) {
      switch (currentStep.value) {
        case 0:
          if (MemberService.to.currentMember.value == null) {
            createMember(context);
          } else {
            currentStep.value += 1;
          }
          break;
        case 1:
          getFilteredPlans();
          break;
        default:
          currentStep.value += 1;
      }
    } else {
      // Submit form
    }
  }

  void onStepCancel() {
    if (currentStep.value > 0) {
      currentStep.value -= 1;
    }
  }

  final RxBool isBarcodeSearch = false.obs;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final RxInt selectedTabIndex = 0.obs;
  final lockerRoomupdating = false.obs;
  final lockerRoom = TextEditingController();
  final selectedMenuSettings = SettingsMenu.account.obs;

  void changeSetting(SettingsMenu menuSetting) {
    selectedMenuSettings.value = menuSetting;
  }

  void toggleSearchType() {
    isBarcodeSearch.value = !isBarcodeSearch.value;
    searchQuery.value = '';
  }

  // Handle search
  void handleSearch(String query) {
    if (isBarcodeSearch.value) {
    } else if (!isBarcodeSearch.value) {
      if (query.length == 10) {
        AttendanceService.to.checkIn(
          identifier: query,
          service: FacilityService.to.selectedService.value!.id,
        );
      } else {
        AttendanceService.to.currentAttendance.value = null;
      }
    }
  }

  //update Locker Room
  void updateLockerRoom(String checkinId, String lockerRoomValue) async {
    lockerRoomupdating.value = true;
    final res = await AttendanceService.to.updateLockerRoom(
      checkinId: checkinId,
      lockerRoom: lockerRoomValue,
    );
    lockerRoomupdating.value = false;
    if (res.isRight) {
      AttendanceService.to.currentAttendance.value = null;
      lockerRoom.clear();
      searchController.clear();
    }
  }

  // Handle tab change
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    services.value = FacilityService.to.facilityServices;
    partners.value = PartnerService.to.partners;
  }
}
