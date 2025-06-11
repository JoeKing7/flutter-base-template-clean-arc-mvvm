import '../../domain/entities/login_entity.dart';
import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/data/models/login_response_model.dart';

extension LoginResponseMapper on LoginResponseModel {
  LoginEntity toEntity() => LoginEntity(
        token: token,
        user: user.toEntity(),
        // no suele venir del backend
      );
}

extension LoginResponseUserMapper on LoginUserModel {
  LoginUserEntity toEntity() => LoginUserEntity(
        id: id,
        name: name,
        email: email,
        rol: rol,
      );
}

extension ErrorMessageMapper on ErrorMessageModel {
  AppError toAppError() => AppError(
        code: code,
        title: title,
        message: message,
      );
}
