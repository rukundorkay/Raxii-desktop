import 'package:either_dart/either.dart';

import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/member.dart';
import 'package:raxii_desktop/app/data/providers/member_provider.dart';

class MemberService extends GetxService {
  static MemberService get to => Get.find();
  final currentMember = Rx<Member?>(null);

  Future<Either<String, Member>> searchMember({
    required String identifier,
  }) async {
    final response = await MemberProvider.to.searchMember(
        indentifier: identifier,
        accessToken: AuthService.to.user.value!.accessToken!);
    if (response.isRight) {
      currentMember.value = response.right;
    } else {
      currentMember.value = null;
    }
    return response;
  }

  Future<Either<String, Member>> createMember({
    required String phone,
    required String firstName,
    required String lastName,
    required String otp,
    required String cardIdentifier,
  }) async {
    final response = await MemberProvider.to.createMember(
        otp: otp,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        cardIdentifier: cardIdentifier,
        accessToken: AuthService.to.user.value!.accessToken!);
    if (response.isRight) {
      currentMember.value = response.right;
    } else {
      currentMember.value = null;
    }
    return response;
  }
}
