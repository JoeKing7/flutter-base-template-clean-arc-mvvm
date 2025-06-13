import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/domain/entities/login_entity.dart';
import 'package:base_template/services/session_service.dart';

class AppController extends GetxController {
  final supportedLocales = [Locale('en', 'US'), Locale('es', 'CO')];
  late Map<String, Map<String, String>> translations;
  late final Rx<Locale> _currentLocale;
  final _themeMode = ThemeMode.system.obs;

  final userRules = RxList<LoginUserRuleEntity>([]);

  Locale get currentLocale => _currentLocale.value;
  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _currentLocale = supportedLocales[0].obs;
    initializeLocale();
  }

  Future<void> initializeLocale() async {
    final lang = await SessionService.getAppLang();
    if (lang > -1) {
      _currentLocale.value = supportedLocales[lang];
      return;
    }

    if (Get.deviceLocale.toString().split('_').contains('es')) {
      await SessionService.setAppLang(1);
      _currentLocale.value = supportedLocales[1];
      return;
    }

    await SessionService.setAppLang(0);
    _currentLocale.value = supportedLocales[0];
  }

  void toggleTheme() {
    _themeMode.value =
        _themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
  }

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
}
