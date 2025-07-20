import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/subscription_service.dart';
import 'package:raxii_desktop/app/modules/home/views/payment_breakdown_widget.dart';
import 'package:raxii_desktop/app/modules/home/views/receipt.dart';
import 'package:raxii_desktop/app/shared/extension/dateTime.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/shared/widget/detail_tile.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InsinghtView extends StatelessWidget {
  const InsinghtView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppSpaceSize.defaultS,
            vertical: AppSpaceSize.enormous,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        color: AppColors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: AppSpaceSize.defaultS,
                                bottom: AppSpaceSize.medium,
                              ),
                              child: Text(
                                "Daily Subscriptions",
                                style: TextStyle(
                                  fontSize: AppFontSize.medium + 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSpaceSize.defaultS,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColors.softGray,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.search, size: 16),
                                  hintText: "Search  by Name or phone number",
                                  hintStyle: TextStyle(
                                      color: AppColors.deepForestGreen,
                                      fontSize: AppFontSize.defaultS),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppSpaceSize.defaultS,
                            ),
                            SubscriptionService.to.isSubscriptionsLoading.value
                                ? const Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : SubscriptionService
                                        .to.allSubscriptions.isEmpty
                                    ? Expanded(
                                        child: Center(
                                          child: Text(
                                            "No Subscriptions found",
                                            style: TextStyle(
                                              fontSize: AppFontSize.defaultS,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              final subscriptions =
                                                  SubscriptionService.to
                                                      .allSubscriptions[index];
                                              return Obx(
                                                () => Container(
                                                  color: SubscriptionService
                                                                  .to
                                                                  .selectedSubscriptions
                                                                  .value !=
                                                              null &&
                                                          subscriptions.id ==
                                                              SubscriptionService
                                                                  .to
                                                                  .selectedSubscriptions
                                                                  .value!
                                                                  .id
                                                      ? AppColors.teaGreen
                                                          .withOpacity(0.5)
                                                      : null,
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal:
                                                          AppSpaceSize.defaultS,
                                                    ),
                                                    onTap: () =>
                                                        SubscriptionService
                                                            .to
                                                            .selectSubscription(
                                                                subscriptions),
                                                    leading: CircleAvatar(
                                                      backgroundColor:
                                                          AppColors.teaGreen,
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .arrowTrendUp,
                                                        size: 14,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      subscriptions.planName,
                                                      style: TextStyle(
                                                        color: AppColors.black,
                                                        fontSize:
                                                            AppFontSize.tiny,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      subscriptions.memberNames,
                                                      style: TextStyle(
                                                        color: AppColors.black,
                                                        fontSize:
                                                            AppFontSize.tiny,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    trailing: Wrap(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              subscriptions
                                                                  .amount
                                                                  .toString()
                                                                  .formatAmount(),
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    AppFontSize
                                                                        .tiny,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              subscriptions
                                                                  .createdAt!
                                                                  .toFormattedTime(),
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    AppFontSize
                                                                        .tiny,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => Divider(
                                                      color: AppColors.softGray,
                                                      height: 0,
                                                    ),
                                            itemCount: SubscriptionService
                                                .to.allSubscriptions.length),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.softGray,
              ),
              if (SubscriptionService.to.selectedSubscriptions.value !=
                  null) ...[
                const Flexible(
                  flex: 4,
                  child: InsightDetail(),
                ),
                if (SubscriptionService
                    .to.selectedSubscriptionsReceipt.value) ...[
                  const Flexible(
                    flex: 4,
                    child: Receipt(),
                  ),
                ]
              ] else ...[
                const Flexible(
                  flex: 4,
                  child: InsightCard(),
                )
              ]
            ],
          )),
    );
  }
}

class InsightDetail extends StatelessWidget {
  const InsightDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            value: SubscriptionService.to.selectedSubscriptions.value!.planName,
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
    );
  }
}

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
