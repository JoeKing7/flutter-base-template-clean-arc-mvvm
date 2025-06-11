import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/data/mappers/login_api_mapper.dart';
import 'package:base_template/data/models/login_response_model.dart';

class ErrorMessageService {
  final Map<String, AppError> _errors = {};

  void load(List<ErrorMessageModel> errors) {
    for (final e in errors) {
      _errors[e.code] = e.toAppError();
    }
  }

  AppError get(String code) {
    return _errors[code] ??
        AppError(
          code: code,
          title: 'Error desconocido',
          message: 'Este error no está definido en el catálogo.',
        );
  }

  void clear() => _errors.clear();
}

// Y en un lugar global:
// final errorMessageService = ErrorMessageService();


// Ahora, para mostrar un error:
// En vez de usar AppErrorCatalog, haces:


// final error = errorMessageService.get('USR_001');
// Get.dialog(FullScreenError(
//   title: error.title,
//   message: '${error.message} (${error.code})',
// ));