import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
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
    if (phoneNumber.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both phone number and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final res = await AuthService.to.login(
        phone: phoneNumber.value,
        password: password.value,
      );
      
      if (res.isRight) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'Login Failed',
          res.left,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
    
      Get.snackbar(
        'Error',
        'Network error occurred. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
