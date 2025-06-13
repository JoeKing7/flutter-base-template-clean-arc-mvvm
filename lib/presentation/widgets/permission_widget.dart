import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/presentation/viewmodels/app_controller.dart';
import 'package:base_template/domain/entities/login_entity.dart';

class PermissionWidget extends StatelessWidget {
  final Widget child;
  final String subject;
  final String action;
  final Widget? fallback;

  const PermissionWidget({
    super.key,
    required this.child,
    required this.subject,
    required this.action,
    this.fallback,
  });

  bool _hasPermission(List<LoginUserRuleEntity> rules) {
    // Verificar si tiene permiso de administrador (manage all)
    final hasAdminPermission = rules.any(
      (rule) => rule.action == 'manage' && rule.subject == 'all',
    );

    if (hasAdminPermission) return true;

    // Verificar permisos específicos
    return rules.any((rule) =>
        // Verifica si tiene el permiso exacto
        (rule.subject == subject && rule.action == action) ||
        // O si tiene permiso de manage sobre el subject
        (rule.subject == subject && rule.action == 'manage'));
  }

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Obx(() {
      final hasPermission = _hasPermission(appController.userRules);

      if (hasPermission) {
        return child;
      }

      // Si no tiene permiso y hay un widget fallback, mostrar ese
      if (fallback != null) {
        return fallback!;
      }

      // Si no tiene permiso y no hay fallback, no mostrar nada
      return const SizedBox.shrink();
    });
  }
}
