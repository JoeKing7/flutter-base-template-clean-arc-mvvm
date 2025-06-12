import 'dart:convert';
import 'package:base_template/core/errors/error_codes.dart';
import 'package:base_template/core/errors/error_handler.dart';
import 'package:dio/dio.dart';

import 'package:base_template/core/errors/error_reporter_service.dart';
import 'package:base_template/data/models/response_api_model.dart';
import 'package:base_template/core/security/crypto_service.dart';
import 'package:base_template/services/session_service.dart';
import 'package:base_template/config/app_routes.dart';
import 'package:base_template/core/network/constants/api_endpoints.dart';
import 'package:base_template/core/network/client/api_provider.dart';
import 'package:base_template/presentation/widgets/full_screen_error.dart';

final reporter = ErrorReporterService();

class GlobalInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: ApiProvider.appBaseUrl));

  /// This method intercepts an out-going request before it reaches the
  /// destination.
  ///
  /// [options] contains http request information and configuration.
  /// [handler] is used to forward, resolve, or reject requests.
  ///
  /// This method is used to inject any token/API keys in the request.
  ///
  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted request. It has 3 possible options:
  ///
  /// - [handler.next]/[super.onRequest], if you want to forward the request.
  /// - [handler.resolve]/[super.onResponse], if you want to resolve the
  /// request with your custom [Response]. All ** request ** interceptors are ignored.
  /// - [handler.reject]/[super.onError], if you want to fail the request
  /// with your custom [DioException].
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    handleCatchError(
      function: () async {
        final appLang = await SessionService.getAppLang();
        final dataEnc =
            await CryptoService.encryptData(jsonEncode(options.data));
        options.data = jsonDecode('{"data": "$dataEnc"}');
        final exceptionsToken = [
          '/auth/app/check-user-account',
        ];
        if (exceptionsToken.contains(options.path)) {
          options.headers.addAll(
            <String, Object?>{
              'accept-language': appLang,
            },
          );
          return handler.next(options);
        }

        options.headers.addAll(
          <String, Object?>{
            'Authorization': 'Bearer ${await SessionService.getToken()}',
            'accept-language': appLang,
          },
        );
        // if (options.extra.containsKey('requiresAuthToken')) {
        //   if (options.extra['requiresAuthToken'] == true) {

        //   }

        //   options.extra.remove('requiresAuthToken');
        // }
        return handler.next(options);
      },
      code: ErrorCodes.onRequest,
      title: 'Error de solicitud',
      message: 'Error al realizar la solicitud',
      messageDev: 'Error al interceptar la solicitud: ${options.path}',
    );
    // try {

    // } catch (e) {
    //   FullScreenError(
    //     title: 'Error',
    //     message: 'Lo sentimos, ocurrió un error al realizar la solicitud.',
    //   );
    // }
  }

  /// This method intercepts an incoming response before it reaches Dio.
  ///
  /// [response] contains http [Response] info.
  /// [handler] is used to forward, resolve, or reject responses.
  ///
  /// This method is used to check the success of the response by verifying
  /// its headers.
  ///
  /// If response is successful, it is simply passed on. It may again be
  /// intercepted if there are any after it. If none, it is passed to [Dio].
  ///
  /// Else if response indicates failure, a [DioException] is thrown with the
  /// response and original request's options.
  ///
  /// ** The success criteria is dependant on the API and may not always be
  /// the same. It might need changing according to your own API. **
  ///
  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted response. It has 3 possible options:
  ///
  /// - [handler.next]/[super.onRequest], if you want to forward the [Response].
  /// - [handler.resolve]/[super.onResponse], if you want to resolve the
  /// [Response] with your custom data. All ** response ** interceptors are ignored.
  /// - [handler.reject]/[super.onError], if you want to fail the response
  /// with your custom [DioException].
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    handleCatchError(
      function: () async {
        if (response.data["data"] != null) {
          final ResponseApiModel enc = ResponseApiModel.fromJson(response.data);
          final decrypt = await CryptoService.decryptData(enc.data);
          response.data = jsonDecode(decrypt);
        }
        return handler.next(response);
      },
      code: ErrorCodes.onResponse,
      title: 'Error de respuesta',
      message: 'Error al procesar la respuesta',
      messageDev:
          'Error al interceptar la respuesta: ${response.requestOptions.path}',
    );

    // final success = response.data['headers']['error'] == 0;

    // if (success) return handler.next(response);

    // //Reject all error codes from server except 402 and 200 OK
    // return handler.reject(
    //   DioException(
    //     requestOptions: response.requestOptions,
    //     response: response,
    //   ),
    // );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized.
    if (err.response?.statusCode == 401) {
      FullScreenError(
        title: 'Sesión de usuario',
        message: 'Su sesión ha expirado, por favor inicie sesión nuevamente.',
        code: '401',
        goToRoute: Routes.LOGIN,
      );

      // Refresh the user's authentication token.
// await refreshToken();
      // Retry the request.
      // try {
      //   handler.resolve(await _retry(err.requestOptions));
      // } on DioException catch (e) {
      //   // If the request fails again, pass the error to the next interceptor in the chain.
      //   handler.next(e);
      // }
      // Return to prevent the next interceptor in the chain from being executed.
      return;
    }
    // Pass the error to the next interceptor in the chain.
    handler.next(err);
  }

// Future<Response<dynamic>> refreshToken() async {
//     try {
//       final refreshToken = Preferences.authRefreshToken;
//       final data = {'refreshToken': refreshToken};
//       final dataEnc = await CryptoService.encryptData(jsonEncode(data));
//       final dataToSend = jsonDecode('{"data": "$dataEnc"}');
//       var response =
//           await dio.post(HttpEndpoints.auth(AuthEndpoint.REFRESH_TOKEN),
//               data: dataToSend,
//               options: Options(
//                 headers: {
//                   'x-tenant-id': 'TENANT_${Preferences.tenant.toUpperCase()}',
//                 },
//               ));

//       // on success response, deserialize the response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final ResponseData enc = ResponseData.fromJson(response.data);
//         final keies = enc.data.split(':');
//         final decrypt = GlobalFunctions.decryptData(keies[0], keies[1]);
//         final dataDec = jsonDecode(decrypt);

//         final newData = RefreshTokenMapper.refreshTokenJsonToEntity(dataDec);
//         Preferences.authToken = newData.token;
//         return response;
//       }
//       return response;
//     } on DioException catch (e) {
//       throw HandleErrors.handleHttpErrors(e);
//     } catch (e) {
//       throw HandleErrors.handleCatchError(e.toString());
//     }
//   }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = SessionService.getToken();

    final options = Options(
      method: 'GET',
      headers: {"access-token": token},
    );

    // Retry the request with the new `RequestOptions` object.
    return dio.request<dynamic>(ApiEndpoints.auth(AuthEndpoint.REFRESH_TOKEN),
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
