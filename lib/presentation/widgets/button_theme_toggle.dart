import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/presentation/viewmodels/app_controller.dart';

Widget buttonThemeToggle() {
  final appController = Get.find<AppController>();
  return Obx(
    () => FloatingActionButton(
      onPressed: () {
        appController.toggleTheme();
      },
      child: Icon(
        appController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
      ),
    ),
  );
}
