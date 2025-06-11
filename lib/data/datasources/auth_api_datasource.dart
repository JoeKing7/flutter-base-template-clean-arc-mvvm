import 'package:base_template/core/errors/error_handler.dart';
import 'package:base_template/data/mappers/login_api_mapper.dart';
import 'package:base_template/data/models/login_response_model.dart';
import 'package:base_template/domain/entities/login_entity.dart';
import 'package:base_template/core/network/constants/api_endpoints.dart';
import '../dtos/login_request_dto.dart';
import '../../core/network/client/api_provider.dart';

class AuthApiDataSource {
  final ApiProvider _apiProvider = ApiProvider();

  Future<LoginEntity> signIn(LoginRequestDTO dto) async {
    return await safeApiCall(() async {
      final response = await _apiProvider.post(
        endpoint: ApiEndpoints.auth(AuthEndpoint.LOGIN),
        data: dto.toJson(),
        // options: Options(
        //   validateStatus: (status) {
        //     return status != null && status >= 200 && status < 405;
        //   },
        // ),
      );
      final responseModel = LoginResponseModel.fromJson(response.data);
      // Guardamos los mensajes en cache global
// errorMessageService.load(responseModel.errorMessages);
      return responseModel.toEntity();
    });
  }
}
