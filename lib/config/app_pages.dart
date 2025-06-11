import 'package:get/get.dart';

import 'app_routes.dart';
import 'bindings/home_binding.dart';
import 'bindings/login_binding.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';

class AppPages {
  static const initial = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
