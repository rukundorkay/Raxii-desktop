import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/constants/api_constants.dart';
import 'package:raxii_desktop/app/data/models/partner.dart';
import 'package:raxii_desktop/app/data/models/plan.dart';
import 'package:raxii_desktop/app/data/models/service.dart';
import 'package:raxii_desktop/app/shared/enum.dart';

class PlanProvider extends GetConnect {
  static PlanProvider get to => Get.find();
  Future<Either<String, List<Plan>>> getPlans({
    SubscriptionDuration? duration,
    List<Service>? services,
    Partner? partner,
    required String accessToken,
  }) async {
    final queryParams = {
      if (duration != null) 'duration': duration.name.toUpperCase(),
      if (partner != null) 'partnerContractId': partner.id,
      if (services!.isNotEmpty)
        'serviceIds': services.map((s) => s.id).toList(),
    };

    final response = await get(
      "/plan",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      query: queryParams,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Right((response.body["items"] as List)
          .map((dynamic v) => Plan.fromJson(v as Map<String, dynamic>))
          .toList());
    } else {
      return Left(response.body["message"]);
    }
  }

  // Future<Either<String, Subscription>> confirmSubscription({
  //   required PaymentMethods paymentMode,
  //   required Member member,
  //   required List<Plan> plan,
  // }) async {
  //   final response = await post(
  //     "/subscription",
  //     {
  //       "planIds": plan.map((plan) => plan.id).toList(),
  //       "memberId": member.id,
  //       "paymentMethod": paymentMode.name,
  //     },
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${AuthService.to.user.value!.accessToken}',
  //     },
  //   );

  //   if (response.statusCode == 201) {
  //     return Right(Subscription.fromJson(response.body));
  //   } else {
  //     return Left(response.body["message"]);
  //   }
  // }

  @override
  onInit() {
    baseUrl = BASE_URL;
    timeout = const Duration(minutes: 2);
    super.onInit();
  }
}
