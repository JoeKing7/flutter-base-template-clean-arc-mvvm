import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/core/errors/error_codes.dart';

class AppErrorCatalog {
  // Login
  static final loginFailed = AppError(
    code: ErrorCodes.forbidden,
    title: 'Error de autenticación',
    message: 'No se pudo iniciar sesión. Verifica tus credenciales.',
  );

  // Registro
  static final registerFailed = AppError(
    code: ErrorCodes.registerFailed,
    title: 'Error al registrar',
    message: 'Ocurrió un problema al crear la cuenta.',
  );

  // Recuperación de contraseña
  static final recoverPasswordFailed = AppError(
    code: ErrorCodes.recoverPasswordFailed,
    title: 'Error al recuperar contraseña',
    message: 'No se pudo recuperar la contraseña. Intenta más tarde.',
  );

  // No conexión a internet
  static final noInternetConnection = AppError(
    code: ErrorCodes.noInternetConnection,
    title: 'Sin conexión a internet',
    message: 'Por favor, verifica tu conexión a internet.',
  );

  // No autorizado
  static final unauthorized = AppError(
    code: ErrorCodes.unauthorized,
    title: 'No autorizado',
    message: 'Tu sesión ha expirado o no tienes permisos para acceder.',
  );

  // Acceso denegado
  static final forbidden = AppError(
    code: ErrorCodes.forbidden,
    title: 'Acceso denegado',
    message: 'No tienes permiso para realizar esta acción.',
  );

  // Error del servidor
  static final serverError = AppError(
    code: ErrorCodes.serverError,
    title: 'Error del servidor',
    message: 'Ocurrió un error interno en el servidor. Intenta más tarde.',
  );

  // Tiempo de espera agotado
  static final timeout = AppError(
    code: ErrorCodes.timeout,
    title: 'Tiempo de espera agotado',
    message: 'La solicitud tardó demasiado tiempo. Intenta nuevamente.',
  );

  // Error de formato en la respuesta
  static final parsingError = AppError(
    code: ErrorCodes.parsingException,
    title: 'Error de formato',
    message: 'La respuesta del servidor no tiene el formato esperado.',
  );

  // Error genérico
  static AppError unknown({StackTrace? stackTrace}) => AppError(
        code: ErrorCodes.unknownException,
        title: 'Error desconocido',
        message: 'Algo inesperado ocurrió.',
        stackTrace: stackTrace,
      );
}
