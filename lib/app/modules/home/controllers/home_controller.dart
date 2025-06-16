import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable variables
  final RxBool isBarcodeSearch = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt selectedTabIndex = 0.obs;
  final isSearching = false.obs;

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
        isSearching.value = true;
      } else {
        isSearching.value = false;
      }
      // searchQuery.value = query;
    }

  }

  // Handle tab change
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
  
}
