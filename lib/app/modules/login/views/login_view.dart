import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:raxii_desktop/app/modules/login/widgets/background_painter.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:raxii_desktop/app/shared/app_path.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Background
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                const BackgroundPainter(),
                Center(
                  child: Image.asset(
                    color: AppColors.white,
                    AppPath.logo,
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // Right side - Login Form
          Expanded(
            flex: 5,
            child: Container(
              color: AppColors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Raxii',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            color: AppColors.steelGray,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 48),
                        TextField(
                          style: TextStyle(color: AppColors.secondary),
                          onChanged: controller.setPhoneNumber,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                color: AppColors.steelGray.withOpacity(0.7)),
                            filled: true,
                            fillColor: AppColors.softGray,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          style: TextStyle(color: AppColors.secondary),
                          onChanged: controller.setPassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: AppColors.steelGray.withOpacity(0.7)),
                            filled: true,
                            fillColor: AppColors.softGray,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.login,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: AppColors.black)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
