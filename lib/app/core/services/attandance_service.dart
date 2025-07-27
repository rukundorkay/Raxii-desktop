import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/auth_service.dart';
import 'package:raxii/app/data/models/attendance.dart';
import 'package:raxii/app/data/models/subscription_plan.dart';
import 'package:raxii/app/shared/enum.dart';
import '../../data/providers/attendance_providers .dart';

class AttendanceService extends GetxService {
  final selectedDate = Rx<DateTime?>(DateTime.now());
  static AttendanceService get to => Get.find();
  final isCheckinsLoading = false.obs;
  final currentAttendance = Rx<Attendance?>(null);
  final currentErrorMessage = Rx<String?>(null);
  final currentsubScriptionMember = Rx<SubscriptionMember?>(null);
  final allAttendance = <Attendance>[].obs;
  final todaysCheckin = Rx<int?>(null);
  final isTodaysChekinLoading = false.obs;
  final isGetAttendanceLoading = false.obs;
  final selectedAttendance = Rx<Attendance?>(null);
  final isSearchingAttendance = false.obs;
  final searchedAttendances = <Attendance>[].obs;

  void searchAttendance(
    String query,
  ) {
    query = query.toLowerCase();
    searchedAttendances.value = allAttendance.where((attendance) {
      return attendance.memberPhoneNumber.toLowerCase().contains(query) ||
          attendance.memberNames.toLowerCase().contains(query);
    }).toList();
  }

  void selectAttendance(Attendance attendance) {
    if (selectedAttendance.value != null &&
        attendance.attendanceId == selectedAttendance.value!.attendanceId) {
      selectedAttendance.value = null;
    } else {
      selectedAttendance.value = attendance;
    }
  }

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
    required CheckinMethod checkinMethod,
  }) async {
    isCheckinsLoading.value = true;
    final res = await AttendanceProvider.to.checkin(
      identifier: identifier,
      selectedService: service,
      method: checkinMethod,
      accessToken: AuthService.to.user.value!.accessToken!,
    );
    isCheckinsLoading.value = false;

    if (res.isRight) {
      currentAttendance.value = res.right;
      currentErrorMessage.value = null;
      attendanceAnalytics();
    } else {
      currentErrorMessage.value = res.left;
      currentAttendance.value = null;
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

  Future<Either<String, List<Attendance>>> getAttendance(
      {required DateTime endDate}) async {
    selectedDate.value = endDate;
    isGetAttendanceLoading.value = true;

    final res = await AttendanceProvider.to.getAttendance(
      endDate: endDate,
      token: AuthService.to.user.value!.accessToken!,
      userId: AuthService.to.user.value!.id,
    );

    isGetAttendanceLoading.value = false;

    if (res.isRight) {
      allAttendance.value = res.right;
    }
    return res;
  }
}
