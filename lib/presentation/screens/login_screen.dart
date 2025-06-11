import 'package:base_template/presentation/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/login_controller.dart';
import '../../../core/utils/form_validators.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<LoginController>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => Stack(
              children: [
                Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Usuario'),
                        onChanged: (val) => controller.user.value = val,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Contraseña'),
                        onChanged: (val) => controller.password.value = val,
                        obscureText: true,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.signIn();
                          }
                        },
                        child: const Text('Iniciar sesión'),
                      ),
                    ],
                  ),
                ),
                if (controller.isLoading.value) const FullScreenLoader()
              ],
            )),
      ),
    );
  }
}
