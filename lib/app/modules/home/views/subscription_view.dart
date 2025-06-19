import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/modules/login/widgets/app_form_field.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class SubscriptionView extends GetView<HomeController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(top: AppSpaceSize.defaultS),
        color: AppColors.white,
        child: Column(
          children: [
            // Custom Stepper Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.huge),
              child: Row(
                children: [
                  _buildStepIndicator(0, 'Member Information'),
                  _buildStepConnector(),
                  _buildStepIndicator(1, 'Subscription'),
                  _buildStepConnector(),
                  _buildStepIndicator(2, 'Plans'),
                  _buildStepConnector(),
                  _buildStepIndicator(3, 'Summary & Payment'),
                ],
              ),
            ),

            // Step Content
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppSpaceSize.huge,
                  vertical: AppSpaceSize.defaultS,
                ),
                child: _buildStepContent(context),
              ),
            ),

            // Custom Navigation Buttons
            Container(
              padding: EdgeInsets.all(AppSpaceSize.huge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  if (controller.currentStep.value > 0)
                    ElevatedButton(
                      onPressed: controller.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpaceSize.large,
                          vertical: AppSpaceSize.defaultS,
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(color: AppColors.white),
                      ),
                    )
                  else
                    const SizedBox.shrink(),

                  // Continue/Cancel Button
                  ElevatedButton(
                    onPressed: () => controller.onStepContinue(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepForestGreen,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpaceSize.large,
                        vertical: AppSpaceSize.defaultS,
                      ),
                    ),
                    child: controller.isCreatingMember.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            controller.currentStep.value == 3
                                ? 'Submit'
                                : 'Next',
                            style: TextStyle(color: AppColors.white),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int stepIndex, String title) {
    final isActive = controller.currentStep.value == stepIndex;
    final isCompleted = controller.currentStep.value > stepIndex;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? AppColors.primary
                  : isActive
                      ? AppColors.primary
                      : AppColors.deepForestGreen,
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check, color: AppColors.white, size: 20)
                  : Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppSpaceSize.tiny),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppFontSize.tiny,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppColors.primary : AppColors.deepForestGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector() {
    return Container(
      height: 2,
      width: 100,
      color: AppColors.black,
    );
  }

  Widget _buildStepContent(BuildContext context) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildMemberInfoStep(context);
      case 1:
        return _buildSubscriptionStep();
      case 2:
        return _buildPlansStep();
      case 3:
        return _buildSummaryStep();
      default:
        return _buildMemberInfoStep(context);
    }
  }

  Widget _buildMemberInfoStep(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpaceSize.huge,
          vertical: AppSpaceSize.defaultS,
        ),
        padding: EdgeInsets.all(AppSpaceSize.defaultS),
        color: AppColors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 7,
                  child: AppTextField(
                    controller: controller.phoneController,
                    label: "Phone Number",
                    hintText: "Search Member Phone number",
                  ),
                ),
                SizedBox(width: AppSpaceSize.defaultS),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () => controller.searchMember(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpaceSize.defaultS + 6,
                      ),
                    ),
                    child: controller.isSearchingMemebr.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : const Text("Verify"),
                  ),
                ),
              ],
            ),
            if (controller.isExistingMember.value)
              Container(
                margin: EdgeInsets.only(top: AppSpaceSize.enormous),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSpaceSize.defaultS,
                    ),
                    Text(
                      "Member Information",
                      style: TextStyle(
                        fontSize: AppFontSize.medium,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppTextField(
                      readOnly: true,
                      controller: controller.fnameController,
                      label: "First Name",
                      hintText: "Enter your first name",
                    ),
                    SizedBox(
                      height: AppSpaceSize.defaultS,
                    ),
                    AppTextField(
                      readOnly: true,
                      controller: controller.lnameController,
                      label: "LastName",
                      hintText: "Enter your last name",
                    ),
                    SizedBox(
                      height: AppSpaceSize.defaultS,
                    ),
                    AppTextField(
                      controller: controller.cardController,
                      label: "Card",
                      hintText: "enter card number",
                    ),
                  ],
                ),
              )
            else
              Column(
                children: [
                  SizedBox(
                    height: AppSpaceSize.defaultS,
                  ),
                  Text(
                    "Member Information",
                    style: TextStyle(
                      fontSize: AppFontSize.medium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppTextField(
                    controller: controller.fnameController,
                    label: "First Name",
                    hintText: "Enter your first name",
                  ),
                  SizedBox(
                    height: AppSpaceSize.defaultS,
                  ),
                  AppTextField(
                    controller: controller.lnameController,
                    label: "LastName",
                    hintText: "Enter your last name",
                  ),
                  SizedBox(
                    height: AppSpaceSize.defaultS,
                  ),
                  AppTextField(
                    controller: controller.cardController,
                    label: "Card",
                    hintText: "enter card number",
                  ),
                  AppTextField(
                    controller: controller.otpController,
                    label: "otp",
                    hintText:
                        "enter otp sent on ${controller.phoneController.text}",
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionStep() {
    // TODO: Implement service, duration, partner selection
    return Column(
      children: [
        // Multi-select for services
        // Single-select for duration
        // Single-select for partner
      ],
    );
  }

  Widget _buildPlansStep() {
    // TODO: List plans, allow selection
    return Column(
      children: [
        // ListView of plans
      ],
    );
  }

  Widget _buildSummaryStep() {
    // TODO: Show summary and payment method selection
    return Column(
      children: [
        // Summary of selections
        // Payment method dropdown/radio
      ],
    );
  }
}
