import 'package:either_dart/either.dart';

import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/partner.dart';
import 'package:raxii_desktop/app/data/models/plan.dart';
import 'package:raxii_desktop/app/data/models/service.dart';
import 'package:raxii_desktop/app/data/providers/plan_provider.dart';

import 'package:raxii_desktop/app/shared/enum.dart';

class PlanService extends GetxService {
  static PlanService get to => Get.find();

  final plans = <Plan>[].obs;
  final isLoading = false.obs;
  final isLoadingSubscriptions = false.obs;
  final selectedPlans = <bool>[].obs;
  final selectedPaymentMethods = Rx<PaymentMethods>(PaymentMethods.MOBILE);
  // final subscriptionsResult = Rx<Subscription?>(null);
  selectPayementMethods(PaymentMethods paymentMode) {
    if (paymentMode == selectedPaymentMethods.value) {
      //selectedPaymentMethods.value = null;
    } else {
      selectedPaymentMethods.value = paymentMode;
    }
  }

  Future<Either<String, List<Plan>>> getPlans(
      {required SubscriptionDuration? duration,
      required Partner? partner,
      required List<Service>? service}) async {
    final response = await PlanProvider.to.getPlans(
        duration: duration,
        partner: partner,
        services: service,
        accessToken: AuthService.to.user.value!.accessToken!);
    isLoading.value = false;

    if (response.isRight) {
      plans.value = response.right;
    }
    return response;
  }

  // Future<Either<String, Subscription>> confirmSubscriptions() async {
  //   isLoadingSubscriptions.value = true;
  //   final newselectedPlans = <Plan>[];
  //   for (int count = 0; count < plans.length; count++) {
  //     if (selectedPlans[count]) {
  //       newselectedPlans.add(plans[count]);
  //     }
  //   }
  //   final response = await PlanProvider.to.confirmSubscription(
  //     plan: newselectedPlans,
  //     member: MemberService.to.member.value!,
  //     paymentMode: selectedPaymentMethods.value,
  //   );
  //   isLoadingSubscriptions.value = false;
  //   if (response.isRight) {
  //     subscriptionsResult.value = response.right;
  //   }

  //   return response;
  // }
}
