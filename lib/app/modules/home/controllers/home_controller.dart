import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';

class HomeController extends GetxController {
  final RxBool isBarcodeSearch = false.obs;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final RxInt selectedTabIndex = 0.obs;
  final lockerRoomupdating = false.obs;
  final lockerRoom = TextEditingController();
  final selectedMenuSettings = SettingsMenu.account.obs;
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
          service: 'e48f5a68-8555-487f-8a60-20ebee236e80',
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

enum SettingsMenu { account, service, printer }
