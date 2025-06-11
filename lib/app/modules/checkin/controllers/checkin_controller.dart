import 'package:get/get.dart';

class CheckinController extends GetxController {
  // Observable variables
  final RxBool isBarcodeSearch = true.obs;
  final RxString searchQuery = ''.obs;
  final RxInt selectedTabIndex = 0.obs;

  // Toggle search type between barcode and phone number
  void toggleSearchType() {
    isBarcodeSearch.value = !isBarcodeSearch.value;
    searchQuery.value = ''; // Clear search when switching types
  }

  // Handle search
  void handleSearch(String query) {
    searchQuery.value = query;
    // TODO: Implement actual search logic
  }

  // Handle tab change
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
} 