import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/core/config/app_colors.dart';
import 'package:base_template/presentation/widgets/app_dialog.dart';
import 'package:base_template/presentation/widgets/app_text.dart';
import 'package:base_template/presentation/widgets/app_buttons.dart';
import 'package:base_template/presentation/widgets/app_text_form_field.dart';
import 'package:base_template/presentation/widgets/app_button_theme_toggle.dart';
import 'package:base_template/presentation/widgets/overlay_loading.dart';
import '../viewmodels/login_controller.dart';
import '../../../core/utils/form_validators.dart';

class LoginScreen extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AppTextTitle('Iniciar Sesión'),
              AppTextSubtitle(
                'Ingresa tus credenciales para acceder a tu cuenta',
                maxLines: 2,
                align: TextAlign.center,
                color: AppColors.darkSuccess,
              ),
              AppTextBodyLarge('Body'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      labelText: 'Usuario',
                      hintText: 'tu@email.com',
                      prefixIcon: Icon(Icons.person),
                      textEditingController: controller.userController,
                    ),
                    AppTextFormField(
                      labelText: 'Contraseña',
                      hintText: '*********',
                      prefixIcon: Icon(Icons.lock),
                      obscureText: true,
                      textEditingController: controller.passwordController,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => AppFilledButton(
                        text: 'Iniciar sesión',
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            overlayLoading(asyncFunction: () async {
                              await controller.signIn();
                            });
                          }
                        },
                      ),
                    ),
                    AppFilledButton(
                        color: AppColors.darkSuccess,
                        text: 'Test Dialog',
                        onTap: () async {
                          await AppDialog.show(
                            icon: Icons.warning,
                            iconColor: Colors.orange,
                            title: 'Prueba title',
                            content:
                                const Text('esto es una prueba de diálogo'),
                            cancelText: 'Cancelar',
                            confirmText: 'Sí, salir',
                            isDestructive: false,
                            onConfirm: () {
                              print('Confirmado!');
                            },
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: appButtonThemeToggle(),
      ),
    );
  }
}
