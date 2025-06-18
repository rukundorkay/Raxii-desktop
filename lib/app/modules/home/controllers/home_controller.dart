import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/core/services/member_service.dart';
import 'package:raxii_desktop/app/data/providers/auth_providers.dart';
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
  final isExistingMember = false.obs;
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
      cardController.text = res.right.card ?? "";
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
  List<String> services = []; // Populate from API
  List<String> selectedServices = [];
  String? selectedDuration;
  List<String> durations = ['Day', 'Week', 'Month', 'Six Month', 'Year'];
  List<String> partners = []; // Populate from API
  String? selectedPartner;

  // Step 3: Plans
  List<String> plans = []; // Populate based on previous selections
  String? selectedPlan;

  // Step 4: Payment
  String? paymentMethod;

  void onStepContinue(BuildContext context) {
    if (currentStep.value < 3) {
      currentStep.value += 1;
      switch (currentStep.value) {
        case 0:
          if (MemberService.to.currentMember.value == null) {
            createMember(context);
          }
          break;
        default:
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
}

enum SettingsMenu { account, station, printer }
