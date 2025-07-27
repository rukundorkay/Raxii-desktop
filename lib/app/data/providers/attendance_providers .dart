import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/constants/api_constants.dart';
import 'package:raxii/app/data/models/attendance.dart';
import 'package:raxii/app/data/models/subscription_plan.dart';
import 'package:raxii/app/shared/enum.dart';
import 'package:raxii/app/shared/extension/dateTime.dart';
import 'package:raxii/app/shared/extension/string.dart';

class AttendanceProvider extends GetConnect {
  static AttendanceProvider get to => Get.find();

  Future<Either<String, String>> updateLockerRoom({
    required String lockerRoom,
    required String checkinId,
    required String accessToken,
  }) async {
    final response = await patch(
      "/attendances/$checkinId/update-locker-room",
      {"lockerRoom": lockerRoom},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return const Right("done successfully");
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, Attendance>> checkin({
    required String identifier,
    required String selectedService,
    required CheckinMethod method,
    required String accessToken,
    String? lockerRoom,
  }) async {
    final response = await post(
      "/attendance",
      {
        "memberIdentification": method == CheckinMethod.BUSINESS_USER_CHECKS_IN
            ? identifier.identifierFormatter
            : identifier,
        "selectedServiceId": selectedService,
        "method": method.name,
        "lockerRoom": lockerRoom ?? "",
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 201) {
      return Right(Attendance.fromJson(response.body));
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, SubscriptionMember>> checkInWithoutService({
    required String? phoneNumber,
    required String? registrationCode,
    required String accessToken,
  }) async {
    final response = await get(
      phoneNumber != null
          ? "/member?phoneNumber=$phoneNumber"
          : "/member?registrationCode=$registrationCode",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final sub = SubscriptionMember.fromJson(response.body);
      return Right(sub);
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, int>> attendanceAnalytics(
      {required String accessToken}) async {
    final response = await get(
      "/attendances/checkins",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return Right(response.body["totalCheckIns"]);
    } else {
      return Left(response.body["message"]);
    }
  }

  Future<Either<String, List<Attendance>>> getAttendance(
      {required DateTime endDate,
      required String token,
      required String userId}) async {
    final response = await get(
      "/attendances?endDate=${endDate.formatAttendanceDate()}&&startDate=${endDate.formatAttendanceDate()}",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      List attendances = response.body['items'];
      return Right(attendances.map((e) => Attendance.fromJson(e)).toList());
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
