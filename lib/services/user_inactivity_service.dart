import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_routes.dart';
import 'package:base_template/config/app_pages.dart';
import 'package:base_template/presentation/widgets/app_dialog.dart';
import 'session_service.dart';

class UserInactivityService with WidgetsBindingObserver {
  static const Duration warningDelay =
      Duration(seconds: 10); // después de esto muestra diálogo
  static const Duration dialogTimeout =
      Duration(seconds: 5); // tiempo para responder

  Timer? _inactivityTimer;
  Timer? _dialogTimer;

  void start() {
    WidgetsBinding.instance.addObserver(this);
    _resetTimer();
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _dialogTimer?.cancel();
    _inactivityTimer = Timer(warningDelay, _showWarningDialog);
  }

  void onUserInteraction() {
    _resetTimer();
  }

  void stop() {
    _inactivityTimer?.cancel();
    _dialogTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _showWarningDialog() async {
    if (Get.isDialogOpen == true) return;

    // No mostrar si estamos en rutas públicas
    if (AppPages.publicRoutes.contains(Get.currentRoute)) return;
    await AppDialog.show(
      icon: Icons.warning,
      iconColor: Colors.orange,
      title: '¿Sigues ahí?',
      content: const Text('Tu sesión está por expirar por inactividad.'),
      confirmText: 'Sí, seguir aquí',
      isDestructive: false,
      onConfirm: () {
        _resetTimer(); // usuario activo
        Get.back();
      },
    );

    _dialogTimer = Timer(dialogTimeout, () {
      if (Get.isDialogOpen == true) Get.back(); // cerrar diálogo
      _handleInactivity(); // cerrar sesión
    });
  }

  Future<void> _handleInactivity() async {
    await SessionService.clearSession();
    if (Get.currentRoute != Routes.LOGIN) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetTimer();
    }
  }
}
