import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/constants/api_constants.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/subscription_insight.dart';
import 'package:raxii_desktop/app/data/models/subscription_transaction.dart';

class SubscriptionProvider extends GetConnect {
  static SubscriptionProvider get to => Get.find();
  Future<Either<String, List<SubscriptionTransaction>>> getSubscriptions(
      {required String date}) async {
    final response = await get(
      "/subscription?startDate=$date&endDate=$date",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.to.user.value!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right((response.body["items"] as List)
          .map((dynamic v) =>
              SubscriptionTransaction.fromJson(v as Map<String, dynamic>))
          .toList());
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, SubscriptionInsight>> getSubscriptionsInsight(
      {required String date}) async {
    final response = await get(
      "/subscription/grouped-by-payment-method?startDate=$date&endDate=$date",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.to.user.value!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right(
          SubscriptionInsight.fromJson(response.body as Map<String, dynamic>));
    } else {
      return Left(response.body["message"]);
    }
  }

  @override
  onInit() {
    baseUrl = BASE_URL;
    timeout = const Duration(minutes: 2);
    super.onInit();
  }
}
