import 'package:get/get.dart';

import 'package:base_template/config/bindings/login_binding.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    LoginBinding().dependencies();
    // Otros servicios compartidos también pueden ir aquí
  }
}
