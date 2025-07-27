import 'package:either_dart/either.dart';

import 'package:get/get.dart';
import 'package:raxii/app/core/services/auth_service.dart';
import 'package:raxii/app/data/models/member.dart';
import 'package:raxii/app/data/models/partner.dart';
import 'package:raxii/app/data/models/plan.dart';
import 'package:raxii/app/data/models/service.dart';
import 'package:raxii/app/data/models/subscriptions.dart';
import 'package:raxii/app/data/providers/plan_provider.dart';

import 'package:raxii/app/shared/enum.dart';

class PlanService extends GetxService {
  static PlanService get to => Get.find();

  Future<Either<String, List<Plan>>> getPlans(
      {required SubscriptionDuration? duration,
      required Partner? partner,
      required List<Service>? service}) async {
    final response = await PlanProvider.to.getPlans(
        duration: duration,
        partner: partner,
        services: service,
        accessToken: AuthService.to.user.value!.accessToken!);

    return response;
  }

  Future<Either<String, Subscription>> confirmSubscriptions(
      {required List<Plan> plan,
      required Member member,
      required PaymentMethods paymentMode}) async {
    final response = await PlanProvider.to.confirmSubscription(
      plan: plan,
      member: member,
      paymentMode: paymentMode,
      accessToken: AuthService.to.user.value!.accessToken!,
    );
    return response;
  }
}
