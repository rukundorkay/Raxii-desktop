import 'package:raxii/app/data/models/card.dart';

class Member {
  final String? id;
  final int? memberNumber;
  final String? firstName;
  final String? lastName;
  final String? memberType;
  final String? parentPhoneNumber;
  final String? phoneNumber;
  final String? registrationCode;
  final String? gender;
  final String? status;
  final DateTime? dateOfBirth;
  final String? picture;
  final bool? isPhoneNumberVerified;
  final CheckinCard? card;

  Member({
    this.id,
    required this.memberNumber,
    required this.firstName,
    required this.lastName,
    this.memberType,
    this.parentPhoneNumber,
    this.phoneNumber,
    this.registrationCode,
    this.gender,
    this.status,
    this.dateOfBirth,
    this.picture,
    this.isPhoneNumberVerified,
    this.card,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['id'],
        memberNumber: json['memberNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        memberType: json['memberType'],
        parentPhoneNumber: json['parentPhoneNumber'],
        phoneNumber: json['phoneNumber'],
        registrationCode: json['registrationCode'],
        gender: json['gender'],
        status: json['status'],
        dateOfBirth: json['dateOfBirth'],
        picture: json['picture'],
        isPhoneNumberVerified: json['isPhoneNumberVerified'],
        card: json['card'] != null ? CheckinCard.fromJson(json['card']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberNumber': memberNumber,
      'firstName': firstName,
      'lastName': lastName,
      'memberType': memberType,
      'parentPhoneNumber': parentPhoneNumber,
      'phoneNumber': phoneNumber,
      'registrationCode': registrationCode,
      'gender': gender,
      'status': status,
      'dateOfBirth': dateOfBirth,
      'picture': picture,
      'isPhoneNumberVerified': isPhoneNumberVerified,
      'card': card,
    };
  }
}
