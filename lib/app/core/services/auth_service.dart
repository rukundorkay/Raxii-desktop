import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/attandance_service.dart';
import 'package:raxii/app/core/services/facility_service.dart';
import 'package:raxii/app/core/services/partner_service.dart';
import 'package:raxii/app/data/models/user.dart';
import 'package:raxii/app/data/providers/auth_providers.dart';
import 'package:raxii/app/routes/app_pages.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final user = Rx<User?>(null);
  Future<Either<String, User>> login({
    required String phone,
    required String password,
  }) async {
    final response =
        await AuthProvider.to.login(phone: phone, password: password);
    if (response.isRight) {
      user.value = response.right;
      await FacilityService.to.getService();
      await AttendanceService.to.attendanceAnalytics();
      await PartnerService.to.getPartner();
    }
    return response;
  }

  void logout() {
    user.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}
