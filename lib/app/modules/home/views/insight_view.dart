import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/subscription_service.dart';
import 'package:raxii/app/modules/home/views/insight_card.dart';
import 'package:raxii/app/modules/home/views/insight_details.dart';
import 'package:raxii/app/modules/home/views/receipt.dart';
import 'package:raxii/app/shared/extension/dateTime.dart';
import 'package:raxii/app/shared/extension/string.dart';
import 'package:raxii/app/shared/size.dart';

import 'package:raxii/app/theme/app_colors.dart';
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
                                onChanged: (value) => SubscriptionService.to
                                    .searchSubscriptions(value),
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
                                                  SubscriptionService
                                                          .to
                                                          .searchedSubscriptions
                                                          .isNotEmpty
                                                      ? SubscriptionService.to
                                                              .searchedSubscriptions[
                                                          index]
                                                      : SubscriptionService.to
                                                              .allSubscriptions[
                                                          index];
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
                                                    .to
                                                    .searchedSubscriptions
                                                    .isNotEmpty
                                                ? SubscriptionService
                                                    .to
                                                    .searchedSubscriptions
                                                    .length
                                                : SubscriptionService.to
                                                    .allSubscriptions.length),
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
