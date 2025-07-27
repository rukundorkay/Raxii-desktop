import 'package:either_dart/either.dart';

import 'package:get/get.dart';
import 'package:raxii/app/core/constants/api_constants.dart';
import 'package:raxii/app/data/models/member.dart';

class MemberProvider extends GetConnect {
  static MemberProvider get to => Get.find();
  Future<Either<String, Member>> searchMember(
      {required String indentifier, required String accessToken}) async {
    final response = await get(
      "/member?phoneNumber=$indentifier",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return Right(Member.fromJson(response.body));
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, Member>> createMember({
    required String phone,
    required String firstName,
    required String lastName,
    required String otp,
    required String cardIdentifier,
    required String accessToken,
    String cardType = "BAR_CODE_CARD",
  }) async {
    final response = await post(
      "/member",
      {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone,
        "otp": otp,
        "gender": "MALE",
        "cardIdentifier": cardIdentifier,
        "cardType": cardType,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 201) {
      return Right(Member.fromJson(response.body));
    } else {
      return Left(response.body["message"]);
    }
  }

  @override
  onInit() {
    baseUrl = BASE_URL;
    timeout = const Duration(minutes: 5);
    super.onInit();
  }
}
