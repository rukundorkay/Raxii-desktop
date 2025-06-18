import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/attendance.dart';
import 'package:raxii_desktop/app/data/models/subscription_plan.dart';
import 'package:raxii_desktop/app/shared/enum.dart';
import '../../data/providers/attendance_providers .dart';

class AttendanceService extends GetxService {
  static AttendanceService get to => Get.find();
  final isCheckinsLoading = false.obs;
  final currentAttendance = Rx<Attendance?>(null);
  final currentsubScriptionMember = Rx<SubscriptionMember?>(null);
  final checkinMethod =
      Rx<CheckinMethod>(CheckinMethod.BUSINESS_USER_CHECKS_IN);
  final todaysCheckin = Rx<int?>(null);
  final isTodaysChekinLoading = false.obs;

  Future<void> attendanceAnalytics() async {
    isTodaysChekinLoading.value = true;

    final res = await AttendanceProvider.to.attendanceAnalytics(
        accessToken: AuthService.to.user.value!.accessToken!);
    isTodaysChekinLoading.value = false;
    if (res.isRight) {
      todaysCheckin.value = res.right;
    }
  }

  Future<Either<String, Attendance>> checkIn({
    required String identifier,
    required String service,
    int? lockerRoom,
  }) async {
    isCheckinsLoading.value = true;
    final res = await AttendanceProvider.to.checkin(
      identifier: identifier,
      selectedService: service,
      method: checkinMethod.value,
      accessToken: AuthService.to.user.value!.accessToken!,
    );
    isCheckinsLoading.value = false;
    if (res.isRight) {
      currentAttendance.value = res.right;
      attendanceAnalytics();
    }
    return res;
  }

  Future<Either<String, String>> updateLockerRoom(
      {required String lockerRoom, required String checkinId}) async {
    final res = await AttendanceProvider.to.updateLockerRoom(
      lockerRoom: lockerRoom,
      checkinId: checkinId,
      accessToken: AuthService.to.user.value!.accessToken!,
    );
    if (res.isRight) {
      currentAttendance.value = null;
    }
    return res;
  }
}
