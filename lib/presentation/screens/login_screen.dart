import 'package:base_template/core/config/app_colors.dart';
import 'package:base_template/presentation/widgets/app_text.dart';
import 'package:base_template/presentation/widgets/buttons.dart';
import 'package:base_template/presentation/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/presentation/widgets/button_theme_toggle.dart';
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
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: buttonThemeToggle(),
      ),
    );
  }
}
