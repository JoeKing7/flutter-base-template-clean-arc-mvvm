import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/services/session_service.dart';
import 'package:base_template/data/dtos/login_request_dto.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../widgets/full_screen_error.dart';
import '../../../config/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> signIn() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    final result = await loginUseCase.signIn(
      LoginRequestDTO(
          username: userController.text, password: passwordController.text),
    );
    result.fold(
      (failure) => Get.dialog(
        FullScreenError(
          title: 'Error',
          message: failure.message,
          code: failure.code,
        ),
      ),
      (data) async {
        await SessionService.setToken(data.token);
        Get.offAllNamed(Routes.HOME);
      },
    );
    isLoading.value = false;
  }
}
