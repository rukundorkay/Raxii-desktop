import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/printer/printer_service.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Receipt extends GetView<HomeController> {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 480,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${AuthService.to.user.value?.businessFacility.name}',
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.defaultS,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: AppSpaceSize.tiny),
                          Text(
                            'ADDRESS ${AuthService.to.user.value?.businessFacility.address}',
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.defaultS,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: AppSpaceSize.tiny),
                          Text(
                            'TIN ${AuthService.to.user.value?.businessFacility.tin}',
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.defaultS,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: AppSpaceSize.defaultS),
                        ],
                      ),
                      Divider(
                        color: AppColors.softGray,
                      ),
                      Column(
                        children: [
                          _buildReceiptItem(
                            "Member Names",
                            controller.subscriptionDetails.value!.memberNames!,
                          ),
                          _buildReceiptItem(
                            "Member Phone",
                            controller
                                .subscriptionDetails.value!.memberPhoneNumber!,
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.softGray,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Plans"),
                          for (var plan in controller
                              .subscriptionDetails.value!.plans) ...[
                            _buildReceiptItem(
                              plan.name!,
                              plan.price.toString().formatAmount(),
                              isLast: true,
                            ),
                          ]
                        ],
                      ),
                      Divider(
                        color: AppColors.softGray,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImageView(
                                data: controller.subscriptionDetails.value!
                                    .memberRegistrationCode!,
                                version: QrVersions.auto,
                                size: 150.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.softGray,
                      ),
                      Column(
                        children: [
                          _buildSummaryRow(
                              'Payment Method',
                              controller
                                  .subscriptionDetails.value!.paymentMethod!,
                              true),
                          _buildSummaryRow(
                              'Total',
                              controller.subscriptionDetails.value!.plans
                                  .fold(
                                      0.0,
                                      (total, plan) =>
                                          total +
                                          double.parse(plan.price.toString()))
                                  .toString()
                                  .formatAmount(),
                              true),
                        ],
                      ),
                      Divider(
                        color: AppColors.softGray,
                      ),
                      _buildReceiptItem(
                        "Served By",
                        AuthService.to.user.value!.firstName,
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                //Action Buttons
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB), // bg-gray-50
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildShareButton(context, () {
                        PrinterService().printReceipt(
                          
                          context: context,
                          data: controller.subscriptionDetails.value!,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build a receipt item row
  Widget _buildReceiptItem(String title, String price, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.steelGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: AppColors.deepForestGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build a summary row
  Widget _buildSummaryRow(String label, String value, bool isTotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppColors.deepForestGreen : AppColors.steelGray,
              fontSize: isTotal ? AppSpaceSize.defaultS : AppSpaceSize.small,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.deepForestGreen : AppColors.steelGray,
              fontSize: isTotal ? AppSpaceSize.defaultS : AppSpaceSize.small,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the Share button
  Widget _buildShareButton(BuildContext context, void Function()? onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaceSize.defaultS,
          vertical: AppSpaceSize.defaultS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        animationDuration: const Duration(milliseconds: 200),
      ),
      icon: const Icon(Icons.print, size: 20),
      label: const Text(
        'Print Receipt ',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
