import 'package:base_template/core/config/app_colors.dart';
import 'package:base_template/presentation/widgets/app_text.dart';
import 'package:base_template/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenError extends StatelessWidget {
  /// A widget that displays a full-screen error message.
  final String? title;
  final String message;
  final String? code;
  final String? goToRoute;

  const FullScreenError(
      {super.key,
      this.title = 'Error',
      required this.message,
      this.code,
      this.goToRoute});

  @override
  Widget build(BuildContext context) {
    final displayMessage = code != null ? '$message\n(Código: $code)' : message;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AppTextTitle(title!,
                color: AppColors.errorColor(Theme.of(context).brightness)),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AppTextBodyLarge(
                displayMessage,
                align: TextAlign.center,
                maxLines: 10,
                color: AppColors.errorColor(Theme.of(context).brightness),
              ),
            ),
            const SizedBox(height: 24.0),
            AppFilledButton(
              onTap: () {
                if (goToRoute == null) {
                  Get.back();
                  return;
                }
                Get.toNamed(goToRoute!);
              },
              text: 'Aceptar',
            ),
          ]),
        ),
      ),
    );
  }
}
