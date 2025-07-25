import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/subscription_service.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/shared/widget/detail_tile.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class InsightDetail extends StatelessWidget {
  const InsightDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(AppSpaceSize.defaultS),
        color: AppColors.white,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                SubscriptionService.to.selectedSubscriptions.value = null;
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColors.black,
                  ),
                  SizedBox(
                    width: AppSpaceSize.tiny,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                      fontSize: AppFontSize.medium,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSpaceSize.large,
            ),
            DetailTile(
                label: "Names",
                value: SubscriptionService
                    .to.selectedSubscriptions.value!.memberNames),
            DetailTile(
              label: "Phone Number",
              value: SubscriptionService
                  .to.selectedSubscriptions.value!.memberPhoneNumber,
            ),
            DetailTile(
                label: "Registration Code",
                value: SubscriptionService
                    .to.selectedSubscriptions.value!.memberRegistrationCode),
            DetailTile(
              label: "Plan",
              value:
                  SubscriptionService.to.selectedSubscriptions.value!.planName,
            ),
            DetailTile(
                label: "Duration",
                value: SubscriptionService
                    .to.selectedSubscriptions.value!.planDuration),
            DetailTile(
              label: "Amount",
              value: SubscriptionService.to.selectedSubscriptions.value!.amount
                  .toString()
                  .formatAmount(),
            ),
            DetailTile(
                label: "Payment Mode",
                value: SubscriptionService
                    .to.selectedSubscriptions.value!.paymentMethod),
            SizedBox(
              height: AppSpaceSize.large,
            ),
            // InkWell(
            //   onTap: () {
            //     SubscriptionService.to.selectedSubscriptionsReceipt.value =
            //         !SubscriptionService.to.selectedSubscriptionsReceipt.value;
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: AppColors.primary,
            //       borderRadius: const BorderRadius.all(Radius.circular(10)),
            //     ),
            //     padding: EdgeInsets.symmetric(
            //       vertical: AppSpaceSize.tiny,
            //       horizontal: AppSpaceSize.defaultS,
            //     ),
            //     margin: EdgeInsets.only(bottom: AppSpaceSize.large),
            //     width: 400,
            //     child: Center(
            //         child: Text(
            //       "Receipt",
            //       style: TextStyle(
            //         color: AppColors.black,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
