import 'package:raxii/app/data/models/business_facility.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final UserRole role;
  final String status;
  final String? profilePicture;
  final bool isPhoneNumberVerified;
  final String? passwordResetToken;
  final String? passwordResetAt;
  final String? passwordResetExpires;
  final BusinessFacility businessFacility;
  final String? accessToken;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.status,
    this.profilePicture,
    required this.isPhoneNumberVerified,
    this.passwordResetToken,
    this.passwordResetAt,
    this.passwordResetExpires,
    required this.businessFacility,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json, String accessToken) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      role: roleFromString(json['role']),
      status: json['status'],
      profilePicture: json['profilePicture'],
      isPhoneNumberVerified: json['isPhoneNumberVerified'],
      passwordResetToken: json['passwordResetToken'],
      passwordResetAt: json['passwordResetAt'],
      passwordResetExpires: json['passwordResetExpires'],
      businessFacility: BusinessFacility.fromJson(json['businessFacility']),
      accessToken: accessToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
      'status': status,
      'profilePicture': profilePicture,
      'isPhoneNumberVerified': isPhoneNumberVerified,
      'passwordResetToken': passwordResetToken,
      'passwordResetAt': passwordResetAt,
      'passwordResetExpires': passwordResetExpires,
      'businessFacility': businessFacility.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    UserRole? role,
    String? status,
    String? profilePicture,
    bool? isPhoneNumberVerified,
    String? passwordResetToken,
    String? passwordResetAt,
    String? passwordResetExpires,
    BusinessFacility? businessFacility,
    String? accessToken,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      profilePicture: profilePicture ?? this.profilePicture,
      isPhoneNumberVerified:
          isPhoneNumberVerified ?? this.isPhoneNumberVerified,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      passwordResetAt: passwordResetAt ?? this.passwordResetAt,
      passwordResetExpires: passwordResetExpires ?? this.passwordResetExpires,
      businessFacility: businessFacility ?? this.businessFacility,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

enum UserRole {
  FACILITY_MANAGER,
  CASHIER,
  RECEPTIONIST,
  BOTH_CASHIER_RECEPTIONIST
}

UserRole roleFromString(String roleString) {
  return UserRole.values.firstWhere(
    (role) => role.name == roleString,
  );
}
