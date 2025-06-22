import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/modules/home/views/member_information.dart';
import 'package:raxii_desktop/app/modules/home/views/payment_summary.dart';
import 'package:raxii_desktop/app/modules/home/views/plan_selection.dart';
import 'package:raxii_desktop/app/modules/home/views/receipt.dart';
import 'package:raxii_desktop/app/modules/home/views/subscription_filter.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class SubscriptionView extends GetView<HomeController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.currentStep.value == 4
          ? const Receipt()
          : Container(
              padding: EdgeInsets.only(top: AppSpaceSize.defaultS),
              color: AppColors.white,
              child: Column(
                children: [
                  // Custom Stepper Header
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpaceSize.huge),
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
                          child: controller.isCreatingMember.value ||
                                  controller.isGettingPlans.value ||
                                  controller.isSubmittingSubscription.value
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
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
        return const MemberInformation();
      case 1:
        return const SubscriptionFilter();
      case 2:
        return const PlanSelection();
      case 3:
        return const PaymentSummary();
      default:
        return const MemberInformation();
    }
  }
}
