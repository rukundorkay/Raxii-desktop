import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/subscription_service.dart';
import 'package:raxii/app/modules/home/views/payment_breakdown_widget.dart';
import 'package:raxii/app/shared/extension/string.dart';
import 'package:raxii/app/shared/size.dart';
import 'package:raxii/app/theme/app_colors.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: AppColors.deepForestGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Today`s Total Subscription",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontSize.defaultS,
                        ),
                      ),
                      SizedBox(
                        height: AppSpaceSize.small,
                      ),
                      SubscriptionService.to.subscriptionInsightLoading.value
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            )
                          : SubscriptionService.to.subscriptionInsinght.value !=
                                  null
                              ? Text(
                                  SubscriptionService.to.subscriptionInsinght
                                      .value!.totalSubscriptionsAmount
                                      .toString()
                                      .formatAmount(),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppFontSize.medium,
                                  ),
                                )
                              : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSpaceSize.huge,
                ),
                if (SubscriptionService.to.subscriptionInsinght.value != null)
                  Row(
                    children: [
                      for (var paymentMethod in SubscriptionService
                          .to
                          .subscriptionInsinght
                          .value!
                          .subscriptionsByPaymentMethod) ...[
                        PaymentBreakDown(
                          paymentMode: paymentMethod.paymentMethod,
                          value: paymentMethod.amount,
                        ),
                        SizedBox(
                          width: AppSpaceSize.defaultS,
                        )
                      ],
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
