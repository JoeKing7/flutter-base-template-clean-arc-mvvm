import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/services/session_service.dart';
import 'package:base_template/core/config/app_config.dart';

class AppController extends GetxController {
  final Rx<Locale> _currentLocale = AppConfig.supportedLocales[0].obs;
  Locale get currentLocale => _currentLocale.value;

  @override
  void onInit() {
    super.onInit();
    initializeLocale();
  }

  Future<void> initializeLocale() async {
    final lang = await SessionService.getAppLang();
    if (lang > -1) {
      _currentLocale.value = AppConfig.supportedLocales[lang];
      return;
    }

    if (Get.deviceLocale.toString().split('_').contains('es')) {
      await SessionService.setAppLang(1);
      _currentLocale.value = AppConfig.supportedLocales[1];
      return;
    }

    await SessionService.setAppLang(0);
    _currentLocale.value = AppConfig.supportedLocales[0];
  }
}
