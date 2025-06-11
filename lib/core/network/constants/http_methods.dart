import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

typedef JSON = Map<String, dynamic>;

abstract class HttpMethods {
  Future<Response<R>> get<R>({
    required String endpoint,
    JSON? queryParams,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  });

  Future<Response<R>> post<R>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<R>> put<R>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<R>> delete<R>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  });
}
