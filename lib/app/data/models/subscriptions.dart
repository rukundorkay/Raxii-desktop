import 'package:raxii/app/data/models/plan.dart';

class Subscription {
  DateTime? subscriptionEndDate;
  String? paymentMethod;
  String? memberNames;
  String? memberRegistrationCode;
  String? memberPhoneNumber;
  String? memberParentPhoneNumber;
  List<Plan> plans;

  Subscription({
    this.subscriptionEndDate,
    this.paymentMethod,
    this.memberNames,
    this.memberRegistrationCode,
    this.memberPhoneNumber,
    this.memberParentPhoneNumber,
    required this.plans,
  });

  // Factory constructor to create a Subscription from JSON
  factory Subscription.fromJson(Map<String, dynamic> json) {
    final List<Plan> plans = (json['plans'] as List<dynamic>?)?.map((v) {
          return Plan.fromJson(v as Map<String, dynamic>);
        }).toList() ??
        [];

    return Subscription(
        subscriptionEndDate: json['subscriptionEndDate'] != null
            ? DateTime.parse(json['subscriptionEndDate'])
            : null,
        paymentMethod: json['paymentMethod'],
        memberNames: json['memberNames'],
        memberRegistrationCode: json['memberRegistrationCode'],
        memberPhoneNumber: json['memberPhoneNumber'],
        memberParentPhoneNumber: json['memberParentPhoneNumber'],
        plans: plans);
    //plans: json['plans'],
  }

  // Convert a Subscription instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'subscriptionEndDate': subscriptionEndDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'memberNames': memberNames,
      'memberRegistrationCode': memberRegistrationCode,
      'memberPhoneNumber': memberPhoneNumber,
      'memberParentPhoneNumber': memberParentPhoneNumber,
    };
  }
}
