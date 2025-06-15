import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/constants/api_constants.dart';
import 'package:raxii_desktop/app/shared/models/user.dart';

class AuthProvider extends GetConnect {
  static AuthProvider get to => Get.find();

  Future<Either<String, User>> login({
    required String phone,
    required String password,
  }) async {
    final response = await post(
      "/auth/login",
      {
        "phoneNumber": phone,
        "password": password,
      },
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        User.fromJson(
          response.body['user'],
          response.body['accessToken'],
        ),
      );
    } else {
      return Left(response.body["message"]);
    }
  }

  @override
  onInit() {
    baseUrl = BASE_URL;
    timeout = const Duration(minutes: 2);
    super.onInit();
  }
}
