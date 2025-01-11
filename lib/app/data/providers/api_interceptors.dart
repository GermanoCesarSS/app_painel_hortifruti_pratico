
import 'package:app_painel_hortifruti_pratico/app/core/errors/exception_handlers.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/services.service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  final _storageService = Get.find<StorageService>();

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = _storageService.token;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      // case DioExceptionType.response:
      //TODO: Analisar o tipo
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 422:
            throw UnprocessableEntity(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions);
      case DioExceptionType.unknown:
        throw UnknownException(err.requestOptions);
      // default:
      //   throw UnknownException(err.requestOptions);
    }

    return handler.next(err);
  }
}