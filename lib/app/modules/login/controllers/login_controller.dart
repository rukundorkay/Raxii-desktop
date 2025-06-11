import 'package:get/get.dart';

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
      // TODO: Implement login logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      
      // Example navigation after successful login
      // Get.offAllNamed('/home');
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