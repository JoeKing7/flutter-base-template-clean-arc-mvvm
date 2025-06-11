import 'package:get/get.dart';

import 'package:base_template/domain/usecases/login_usecase.dart';
import 'package:base_template/data/datasources/auth_api_datasource.dart';
import 'package:base_template/data/repositories_impl/auth_repository_impl.dart';
import '../../presentation/viewmodels/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Crea manualmente las dependencias desde infraestructura → dominio → controlador
    final datasource = AuthApiDataSource();
    final repository = AuthRepositoryImpl(datasource);
    final usecase = LoginUseCase(repository);

    Get.lazyPut(() => LoginController(usecase));
  }
}
