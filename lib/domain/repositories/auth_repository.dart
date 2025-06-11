import 'package:dartz/dartz.dart';

import 'package:base_template/core/errors/failure.dart';
import 'package:base_template/data/dtos/login_request_dto.dart';
import 'package:base_template/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginRequestDTO dto);
}
