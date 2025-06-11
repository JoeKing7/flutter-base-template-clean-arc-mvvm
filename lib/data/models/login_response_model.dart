import 'package:base_template/core/errors/app_exception.dart';

class LoginResponseModel {
  final String token;
  final LoginUserModel user;
  // final List<ErrorMessageModel> errorMessages;

  LoginResponseModel({
    required this.token,
    required this.user,
    // required this.errorMessages,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return LoginResponseModel(
        token: json['token'],
        user: LoginUserModel.fromJson(json['user']),
        // errorMessages: (json['errorMessages'] as List<dynamic>?)
        // ?.map((e) => ErrorMessageModel.fromJson(e))
        // .toList() ?? [],
      );
    } catch (e) {
      // Propaga como excepción controlada
      throw ParsingException(
          message: 'Lo sentimos, ocurrió un error intentado iniciar sesión');
    }
  }
}

class LoginUserModel {
  final int id;
  final String name;
  final String email;
  final String rol;

  LoginUserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.rol});

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      rol: json['rol'],
    );
  }
}

class ErrorMessageModel {
  final String code;
  final String title;
  final String message;

  ErrorMessageModel(
      {required this.code, required this.title, required this.message});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      code: json['code'],
      title: json['title'],
      message: json['message'],
    );
  }

  // AppError toAppError() => AppError(code: code, title: title, message: message);
}
