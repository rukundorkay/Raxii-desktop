class Partner {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? paymentCoverPercentage;
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final String? status;
  final String? terminationReason;
  final DateTime? terminatedAt;
  final String? companyName;

  Partner({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.paymentCoverPercentage,
    this.contractStartDate,
    this.contractEndDate,
    this.status,
    this.terminationReason,
    this.terminatedAt,
    this.companyName,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      paymentCoverPercentage: json['paymentCoverPercentage'],
      contractStartDate: json['contractStartDate'] != null ? DateTime.parse(json['contractStartDate']) : null,
      contractEndDate: json['contractEndDate'] != null ? DateTime.parse(json['contractEndDate']) : null,
      status: json['status'],
      terminationReason: json['terminationReason'],
      terminatedAt: json['terminatedAt'] != null ? DateTime.parse(json['terminatedAt']) : null,
      companyName: json['companyName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'paymentCoverPercentage': paymentCoverPercentage,
      'contractStartDate': contractStartDate?.toIso8601String(),
      'contractEndDate': contractEndDate?.toIso8601String(),
      'status': status,
      'terminationReason': terminationReason,
      'terminatedAt': terminatedAt?.toIso8601String(),
      'companyName': companyName,
    };
  }
}