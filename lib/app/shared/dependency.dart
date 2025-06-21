import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/core/services/member_service.dart';
import 'package:raxii_desktop/app/core/services/partner_service.dart';
import 'package:raxii_desktop/app/data/providers/attendance_providers%20.dart';
import 'package:raxii_desktop/app/data/providers/auth_providers.dart';
import 'package:raxii_desktop/app/data/providers/facility_services_provider.dart';
import 'package:raxii_desktop/app/data/providers/member_provider.dart';
import 'package:raxii_desktop/app/data/providers/partner_provider.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => AuthProvider(), fenix: true);
    Get.lazyPut(() => AttendanceService(), fenix: true);
    Get.lazyPut(() => AttendanceProvider(), fenix: true);
    Get.lazyPut(() => FacilityService(), fenix: true);
    Get.lazyPut(() => FacilityServicesProvider(), fenix: true);
    Get.lazyPut(() => MemberService(), fenix: true);
    Get.lazyPut(() => MemberProvider(), fenix: true);
    Get.lazyPut(() => PartnerService(), fenix: true);
    Get.lazyPut(() => PartnerProvider(), fenix: true);
  }
}
