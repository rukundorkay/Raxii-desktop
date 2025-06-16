import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';

class HomeController extends GetxController {
  // Observable variables
  final RxBool isBarcodeSearch = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt selectedTabIndex = 0.obs;

  // Toggle search type between barcode and phone number
  void toggleSearchType() {
    isBarcodeSearch.value = !isBarcodeSearch.value;
    searchQuery.value = ''; // Clear search when switching types
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

  // Handle tab change
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
