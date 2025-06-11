import 'package:dartz/dartz.dart';

import 'package:base_template/core/errors/failure.dart';
import '../entities/login_entity.dart';
import 'package:base_template/data/dtos/login_request_dto.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginEntity>> signIn(LoginRequestDTO dto) {
    return repository.login(dto);
  }
}
