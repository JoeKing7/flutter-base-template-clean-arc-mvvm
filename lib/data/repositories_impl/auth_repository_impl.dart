import 'package:dartz/dartz.dart';


import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/core/errors/failure.dart';
import 'package:base_template/data/dtos/login_request_dto.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginRequestDTO dto) async {
    try {
      final loginEntity = await datasource.signIn(dto);
      return Right(loginEntity);
    } on AppError catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
