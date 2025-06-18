import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/constants/api_constants.dart';
import 'package:raxii_desktop/app/data/models/user.dart';

class AuthProvider extends GetConnect {
  static AuthProvider get to => Get.find();

  Future<Either<String, User>> login({
    required String phone,
    required String password,
  }) async {
    try {
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
    } catch (e, sk) {
      print(sk);
      return const Left("oops, something went wrong");
    }
  }

  Future<Either<String, String>> sendOtp({
    required String phone,
    required String accessToken,
  }) async {
    final response = await post(
      "/auth/send-register-otp",
      {
        "phoneNumber": phone,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Right(response.body["message"]);
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
