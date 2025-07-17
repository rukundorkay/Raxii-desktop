class SubscriptionInsight {
  final int totalSubscriptionsAmount;
  final List<PaymentBreakdown> subscriptionsByPaymentMethod;

  SubscriptionInsight({
    required this.totalSubscriptionsAmount,
    required this.subscriptionsByPaymentMethod,
  });

  factory SubscriptionInsight.fromJson(Map<String, dynamic> json) {
    return SubscriptionInsight(
      totalSubscriptionsAmount: json['totalSubscriptionsAmount'],
      subscriptionsByPaymentMethod:
          (json['subscriptionsByPaymentMethod'] as List)
              .map((item) => PaymentBreakdown.fromJson(item))
              .toList(),
    );
  }
}

class PaymentBreakdown {
  final String paymentMethod;
  final int amount;

  PaymentBreakdown({
    required this.paymentMethod,
    required this.amount,
  });

  factory PaymentBreakdown.fromJson(Map<String, dynamic> json) {
    return PaymentBreakdown(
      paymentMethod: json['paymentMethod'],
      amount: json['amount'],
    );
  }
}
