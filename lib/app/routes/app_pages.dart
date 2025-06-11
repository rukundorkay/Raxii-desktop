import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/checkin/bindings/checkin_binding.dart';
import 'package:raxii_desktop/app/modules/checkin/views/checkin_view.dart';
import 'package:raxii_desktop/app/modules/login/bindings/login_binding.dart';
import 'package:raxii_desktop/app/modules/login/views/login_view.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.CHECKIN,
      page: () => const CheckinView(),
      binding: CheckinBinding(),
    ),
  ];
}
