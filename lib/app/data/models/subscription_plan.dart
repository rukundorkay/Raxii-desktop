

import 'package:raxii_desktop/app/data/models/service.dart';

class SubscriptionPlan {
  final String subscriptionId;
  final String planName;
  final DateTime endDate;
  final String price;

  SubscriptionPlan({
    required this.subscriptionId,
    required this.planName,
    required this.endDate,
    required this.price,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      subscriptionId: json['subscriptionId'],
      planName: json['planName'],
      endDate: DateTime.parse(json['endDate']),
      price: json['price'],
    );
  }
}

class SubscriptionMember {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String? parentPhoneNumber;
  final String phoneNumber;
  final String registrationCode;
  final String gender;
  final String status;
  final DateTime? dateOfBirth;
  final bool hasActiveSubscription;
  final List<Service> allowedServices;

  SubscriptionMember({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.parentPhoneNumber,
    required this.phoneNumber,
    required this.registrationCode,
    required this.gender,
    required this.status,
    required this.dateOfBirth,
    required this.hasActiveSubscription,
    required this.allowedServices,
  });

  factory SubscriptionMember.fromJson(Map<String, dynamic> json) {
    return SubscriptionMember(
      id: json['id'],
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      parentPhoneNumber: json['parentPhoneNumber'],
      phoneNumber: json['phoneNumber'],
      registrationCode: json['registrationCode'],
      gender: json['gender'],
      status: json['status'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      hasActiveSubscription: json['hasActiveSubscription'],
      allowedServices: (json['allowedServices'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }
}
