import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/views/susbcription_duration_criteria.dart';
import 'package:raxii_desktop/app/modules/home/views/susbcription_partner_criteria.dart';
import 'package:raxii_desktop/app/modules/home/views/susbcription_service_criteria.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class SubscriptionFilter extends GetView {
  const SubscriptionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: AppSpaceSize.defaultS),
        child: Column(
          children: [
            Text(
              "Filter Membership Plans",
              style: TextStyle(
                fontSize: AppFontSize.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: AppSpaceSize.defaultS,
            ),
            const SubscriptionServiceCriteria(),
            Divider(
              height: AppSpaceSize.enormous,
              color: AppColors.softGray,
            ),
            const SubscriptionDurationCriteria(),
            Divider(
              height: AppSpaceSize.enormous,
              color: AppColors.softGray,
            ),
            const SubscriptionPartnerCriteria(),
          ],
        ),
      ),
    );
  }
}
