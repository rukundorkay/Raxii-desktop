class BusinessFacility {
  final String id;
  final String name;
  final int? registrationNumber;
  final String? tin;
  final String? category;
  final String? ownershipType;
  final String? status;
  final String address;
  final String branchType;
  final String? branchCode;

  BusinessFacility({
    required this.id,
    required this.name,
    this.registrationNumber,
    this.tin,
    this.category,
    this.ownershipType,
    this.status,
    required this.address,
    required this.branchType,
    this.branchCode,
  });

  factory BusinessFacility.fromJson(Map<String, dynamic> json) {
    return BusinessFacility(
      id: json['id'],
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      tin: json['tin'],
      category: json['category'],
      ownershipType: json['ownershipType'],
      status: json['status'],
      address: json['address'] ?? "N/A",
      branchType: json['branchType'] ?? "N/A",
      branchCode: json['branchCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registrationNumber': registrationNumber,
      'tin': tin,
      'category': category,
      'ownershipType': ownershipType,
      'status': status,
      'address': address,
      'branchType': branchType,
      'branchCode': branchCode,
    };
  }

  BusinessFacility copyWith({
    String? id,
    String? name,
    int? registrationNumber,
    String? tin,
    String? category,
    String? ownershipType,
    String? status,
    String? address,
    String? branchType,
    String? branchCode,
  }) {
    return BusinessFacility(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      tin: tin ?? this.tin,
      category: category ?? this.category,
      ownershipType: ownershipType ?? this.ownershipType,
      status: status ?? this.status,
      address: address ?? this.address,
      branchType: branchType ?? this.branchType,
      branchCode: branchCode ?? this.branchCode,
    );
  }
} 