import 'package:get/get.dart';
import 'package:raxii/app/data/models/subscription_insight.dart';
import 'package:raxii/app/data/models/subscription_transaction.dart';
import 'package:raxii/app/data/providers/subscription_provider.dart';
import 'package:raxii/app/shared/extension/dateTime.dart';

class SubscriptionService extends GetxService {
  static SubscriptionService get to => Get.find();

  final isSubscriptionsLoading = false.obs;
  final allSubscriptions = <SubscriptionTransaction>[].obs;
  final searchedSubscriptions = <SubscriptionTransaction>[].obs;
  final subscriptionInsinght = Rx<SubscriptionInsight?>(null);
  final subscriptionInsightLoading = false.obs;
  final selectedSubscriptions = Rx<SubscriptionTransaction?>(null);
  final selectedSubscriptionsReceipt = false.obs;
  void selectSubscription(SubscriptionTransaction sub) {
    if (selectedSubscriptions.value != null &&
        sub.id == selectedSubscriptions.value!.id) {
      selectedSubscriptions.value = null;
    } else {
      selectedSubscriptions.value = sub;
    }
  }

  void searchSubscriptions(
    String query,
  ) {
    query = query.toLowerCase();
    searchedSubscriptions.value = allSubscriptions.where((subscription) {
      return subscription.memberRegistrationCode
              .toLowerCase()
              .contains(query) ||
          subscription.memberNames.toLowerCase().contains(query);
    }).toList();
  }

  getAllSubscriptions() async {
    isSubscriptionsLoading.value = true;
    final res = await SubscriptionProvider.to
        .getSubscriptions(date: DateTime.now().formatAttendanceDate());
    isSubscriptionsLoading.value = false;
    if (res.isRight) {
      allSubscriptions.value = res.right;
    }
    getSubscriptionsInsight();
  }

  getSubscriptionsInsight() async {
    subscriptionInsightLoading.value = true;
    final res = await SubscriptionProvider.to
        .getSubscriptionsInsight(date: DateTime.now().formatAttendanceDate());
    subscriptionInsightLoading.value = false;
    if (res.isRight) {
      subscriptionInsinght.value = res.right;
    }
  }
}
