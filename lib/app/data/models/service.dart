
import 'package:raxii_desktop/app/data/models/business_facility.dart';
class Service {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String name;
  final String? description;
  final String? status;
  final BusinessFacility? businessFacility;

  Service({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    this.description,
    this.status,
    this.businessFacility,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      createdAt:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      businessFacility: json['businessFacility'] != null
          ? BusinessFacility.fromJson(json['businessFacility'])
          : null,
    );
  }
}
