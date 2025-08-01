import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:raxii/app/modules/login/widgets/background_painter.dart';
import 'package:raxii/app/theme/app_colors.dart';
import 'package:raxii/app/shared/app_path.dart';
import 'package:raxii/app/shared/size.dart';
import '../widgets/app_form_field.dart';

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
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpaceSize.medium),
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
                        SizedBox(height: AppSpaceSize.tiny),
                        Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            color: AppColors.steelGray,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: AppSpaceSize.huge),
                        // Phone Number Field
                        AppTextField(
                          label: "Phone Number",
                          hintText: "Enter Phone Number",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          onChanged: controller.setPhoneNumber,
                        ),
                        SizedBox(height: AppSpaceSize.huge),
                        // Password Field
                        AppTextField(
                          label: "Password",
                          hintText: "Enter Password",
                          obscureText: true,
                          onChanged: controller.setPassword,
                        ),
                        SizedBox(height: AppSpaceSize.enormous * 2),
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => controller.isLoading.value
                                  ? null
                                  : controller.login(context),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSpaceSize.defaultS),
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSpaceSize.tiny),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.black,
                                      ),
                                    )
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
