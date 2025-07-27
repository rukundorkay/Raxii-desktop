import 'package:raxii/app/data/models/service.dart';

class Plan {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? name;
  String? description;
  String? status;
  double? price;
  String? duration;
  String? companyName;
  List<Service>? coverdServices;

  Plan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.description,
    this.status,
    this.price,
    this.duration,
    this.companyName,
    this.coverdServices,
  }) {
    id;
    createdAt ??= DateTime.now();
    updatedAt ??= DateTime.now();
  }

  // Factory constructor to create a Plan from JSON
  factory Plan.fromJson(Map<String, dynamic> json) {
    final coveredServices = (json['coveredServices'] as List?)
            ?.map((dynamic v) => Service.fromJson(v as Map<String, dynamic>))
            .toList() ??
        [];

    return Plan(
        id: json['id'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        name: json['name'],
        description: json['description'],
        status: json['status'],
        price: json['price'] != null ? (json['price'] as num).toDouble() : null,
        duration: json['duration'],
        companyName: json['companyName'],
        coverdServices: coveredServices);
  }

  // Convert a Plan instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'name': name,
      'description': description,
      'status': status,
      'price': price,
      'duration': duration,
      'companyName': companyName,
    };
  }
}
