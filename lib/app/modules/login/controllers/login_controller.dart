import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/routes/app_pages.dart';
import 'package:raxii_desktop/app/shared/toaster.dart';
import 'package:toastification/toastification.dart';

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

  Future<void> login(BuildContext context) async {
    if (phoneNumber.value.isEmpty || password.value.isEmpty) {
      toaster(
        // ignore: use_build_context_synchronously
        context: context,
        title: "Error",
        description: "Please enter both phone number and password",
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
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
        toaster(
          // ignore: use_build_context_synchronously
          context: context,
          title: "Error",
          description: res.left,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
        );
      }
    } catch (e) {
      toaster(
        
        // ignore: use_build_context_synchronously
        context: context,
        title: "Error",
        description:
            "Network error occurred. Please check your internet connection and try again.",
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        
      );
    } finally {
      isLoading.value = false;
    }
  }
}
