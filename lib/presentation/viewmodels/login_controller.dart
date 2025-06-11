import 'package:get/get.dart';

import 'package:base_template/data/dtos/login_request_dto.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../core/utils/preferences_helper.dart';
import '../widgets/full_screen_error.dart';
import '../../../config/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final user = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  Future<void> signIn() async {
    isLoading.value = true;
    final result = await loginUseCase.signIn(
      LoginRequestDTO(username: user.value, password: password.value),
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
        await PreferencesHelper.setToken(data.token);
        Get.offAllNamed(Routes.HOME);
      },
    );
    isLoading.value = false;
  }
}
