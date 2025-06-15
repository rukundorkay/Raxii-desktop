import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/bindings/home_binding.dart';
import 'package:raxii_desktop/app/modules/home/views/home_view.dart';
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
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
