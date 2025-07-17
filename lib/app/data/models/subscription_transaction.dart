

import 'package:raxii_desktop/app/data/models/service.dart';

class SubscriptionTransaction {
  final String id;
  final DateTime? createdAt;
  final DateTime? endDate;
  final String status;
  final double amount;
  final String paymentMethod;
  final String memberNames;
  final String memberRegistrationCode;
  final String planName;
  final String planDuration;
  final String memberPhoneNumber;
  final List<Service> coveredServices;

  SubscriptionTransaction({
    required this.id,
    required this.createdAt,
    required this.endDate,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.memberNames,
    required this.memberRegistrationCode,
    required this.planName,
    required this.planDuration,
    required this.coveredServices,
    required this.memberPhoneNumber,
  });

  factory SubscriptionTransaction.fromJson(Map<String, dynamic> json) {
    return SubscriptionTransaction(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      memberNames: json['memberNames'],
      memberRegistrationCode: json['memberRegistrationCode'],
      planName: json['planName'],
      planDuration: json['planDuration'],
      memberPhoneNumber: json['memberPhoneNumber'],
      coveredServices: (json['coveredServices'] as List<dynamic>)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }
}
