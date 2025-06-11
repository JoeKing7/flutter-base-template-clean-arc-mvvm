import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/data/mappers/login_api_mapper.dart';
import 'package:base_template/data/models/login_response_model.dart';

class ErrorMessageService {
  final Map<String, Map<String, AppError>> _errors = {};

  void load(ErrorMessageGroupModel groupModel) {
    _errors.clear();
    groupModel.sections.forEach((screen, messages) {
      _errors[screen] = {
        for (final e in messages) e.code: e.toAppError()
      };
    });
  }

  AppError get(String screen, String code) {
    final screenErrors = _errors[screen];
    if (screenErrors != null && screenErrors.containsKey(code)) {
      return screenErrors[code]!;
    }
    return AppError(
      code: code,
      title: 'Error desconocido',
      message: 'Este error no está definido para $screen.',
    );
  }

  void clear() => _errors.clear();
}

// Y en un lugar global:
// final errorMessageService = ErrorMessageService();


// Ahora, para mostrar un error:
// En vez de usar AppErrorCatalog, haces:


// final error = errorMessageService.get('home', 'USR_001');
// Get.dialog(FullScreenError(
//   title: error.title,
//   message: '${error.message} (${error.code})',
// ));