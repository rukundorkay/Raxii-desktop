import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/shared/dependency.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Allow HTTP connections
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    GetMaterialApp(
      title: "Raxii",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
    ),
  );
}
