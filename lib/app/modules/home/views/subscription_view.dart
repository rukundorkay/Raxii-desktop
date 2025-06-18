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
      () => Stepper(
        margin: EdgeInsets.zero,
        elevation: 0,
        type: StepperType.horizontal,
        currentStep: controller.currentStep.value,
        onStepContinue: () => controller.onStepContinue(context),
        onStepCancel: controller.onStepCancel,
        steps: [
          Step(
            title: const Text('Member Information'),
            content: _buildMemberInfoStep(context),
            isActive: controller.currentStep.value == 0,
          ),
          Step(
            title: const Text('Subscription'),
            content: _buildSubscriptionStep(),
            isActive: controller.currentStep.value == 1,
          ),
          Step(
            title: const Text('Plans'),
            content: _buildPlansStep(),
            isActive: controller.currentStep.value == 2,
          ),
          Step(
            title: const Text('Summary & Payment'),
            content: _buildSummaryStep(),
            isActive: controller.currentStep.value == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildMemberInfoStep(BuildContext context) {
    return Container(
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
