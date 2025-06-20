import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/presentation/widgets/app_text.dart';
import 'package:base_template/core/config/app_colors.dart';

class AppDialog {
  static Future<void> show({
    IconData? icon,
    Color? iconColor,
    String? title,
    required Widget content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return Get.dialog(
      AppDialogContent(
        icon: icon,
        iconColor: iconColor,
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDestructive:
            isDestructive, // es una bandera semántica que indica que la acción del botón tiene consecuencias potencialmente negativas o irreversibles, como:
// Eliminar una cuenta o dato, Cerrar sesión sin guardar, Revertir cambios, Borrar un archivo, Cancelar una operación crítica
      ),
      barrierDismissible: false,
    );
  }
}

class AppDialogContent extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;
  final String? title;
  final Widget content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const AppDialogContent({
    super.key,
    this.icon,
    this.iconColor,
    this.titleColor,
    this.title,
    required this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null
        ? CircleAvatar(
            radius: 28,
            backgroundColor: iconColor?.withOpacity(0.1) ??
                AppColors.primary(Theme.of(context).brightness)
                    .withOpacity(0.1),
            child: Icon(icon,
                size: 30,
                color: iconColor ??
                    AppColors.primary(Theme.of(context).brightness)),
          )
        : null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconWidget != null) iconWidget,
            if (title != null) ...[
              const SizedBox(height: 16),
              AppTextTitle(title!,
                  color: titleColor ??
                      AppColors.primary(Theme.of(context).brightness),
                  align: TextAlign.center),
            ],
            const SizedBox(height: 12),
            content,
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cancelText != null)
                  TextButton(
                    onPressed: () {
                      Get.back();
                      onCancel?.call();
                    },
                    child: Text(cancelText!),
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDestructive
                        ? Colors.red
                        : AppColors.success(Theme.of(context).brightness),
                  ),
                  onPressed: () {
                    Get.back();
                    onConfirm?.call();
                  },
                  child: Text(
                    confirmText ?? 'global.global'.tr,
                    style: TextStyle(
                      color: AppColors.darkBlackLightWhite(
                          Theme.of(context).brightness),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class AppDialogContent extends StatelessWidget {
//   final String title;
//   final String message;
//   final String? confirmText;
//   final String? cancelText;
//   final VoidCallback? onConfirm;
//   final VoidCallback? onCancel;
//   final bool isDestructive;

//   const AppDialogContent({
//     super.key,
//     required this.title,
//     required this.message,
//     this.confirmText,
//     this.cancelText,
//     this.onConfirm,
//     this.onCancel,
//     this.isDestructive = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return AlertDialog(
//       title: Text(title, style: theme.textTheme.titleLarge),
//       content: Text(message, style: theme.textTheme.bodyMedium),
//       actions: [
//         if (cancelText != null)
//           TextButton(
//             onPressed: () {
//               Get.back();
//               onCancel?.call();
//             },
//             child: Text(cancelText!),
//           ),
//         TextButton(
//           onPressed: () {
//             Get.back();
//             onConfirm?.call();
//           },
//           child: Text(
//             confirmText ?? 'global.global'.tr,
//             style: TextStyle(
//               color: isDestructive ? Colors.red : theme.colorScheme.primary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
