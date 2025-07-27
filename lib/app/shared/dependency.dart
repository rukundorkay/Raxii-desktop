import 'package:get/get.dart';
import 'package:raxii/app/core/services/attandance_service.dart';
import 'package:raxii/app/core/services/auth_service.dart';
import 'package:raxii/app/core/services/facility_service.dart';
import 'package:raxii/app/core/services/member_service.dart';
import 'package:raxii/app/core/services/partner_service.dart';
import 'package:raxii/app/core/services/plan_service.dart';
import 'package:raxii/app/core/services/setting_service.dart';
import 'package:raxii/app/core/services/subscription_service.dart';
import 'package:raxii/app/data/providers/attendance_providers%20.dart';
import 'package:raxii/app/data/providers/auth_providers.dart';
import 'package:raxii/app/data/providers/facility_services_provider.dart';
import 'package:raxii/app/data/providers/member_provider.dart';
import 'package:raxii/app/data/providers/partner_provider.dart';
import 'package:raxii/app/data/providers/plan_provider.dart';
import 'package:raxii/app/data/providers/subscription_provider.dart';

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
    Get.lazyPut(() => PlanService(), fenix: true);
    Get.lazyPut(() => PlanProvider(), fenix: true);
    Get.lazyPut(() => SettingService(), fenix: true);
    Get.lazyPut(() => SubscriptionProvider(), fenix: true);
    Get.lazyPut(() => SubscriptionService(), fenix: true);
    Get.lazyPut(() => SettingService(), fenix: true);
  }
}
