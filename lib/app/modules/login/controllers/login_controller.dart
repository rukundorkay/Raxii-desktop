import 'package:get/get.dart';
import 'package:raxii_desktop/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final phoneNumber = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
