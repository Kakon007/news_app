import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/network/server.dart';

// ignore: constant_identifier_names
enum RequestType { GET, POST, PUT, PATCH, DELETE }

class NetworkService {
  final dio = createDio();

  NetworkService._internal();

  static final _singleton = NetworkService._internal();

  factory NetworkService() => _singleton;

  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
        baseUrl: Server.BASE_URL,
        receiveTimeout: const Duration(milliseconds: 20000),
        connectTimeout: const Duration(milliseconds: 20000),
        sendTimeout: const Duration(milliseconds: 20000)));

    dio.interceptors.addAll({AuthInterceptor(dio)});
    dio.interceptors.addAll({Logging(dio)});
    dio.interceptors.addAll({ErrorInterceptors(dio)});
    return dio;
  }

  Future<dynamic> networkRequest(
      {String? url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      RequestType? requestType}) async {
    Response? result;
    // var cookieJar = await CookieMgr().getCookiee();
    // dio.interceptors.add(CookieManager(cookieJar));
    // log('Cookie: ${await cookieJar.loadForRequest(Uri.parse(Server.BASE_URL))}');
    try {
      switch (requestType!) {
        case RequestType.GET:
          {
            Options options = Options(headers: header);
            result = await dio.get(url!,
                queryParameters: queryParameters, options: options);
            break;
          }
        case RequestType.POST:
          {
            Options options = Options(headers: header);
            result = await dio.post(url!, data: body, options: options);
            break;
          }
        case RequestType.DELETE:
          {
            Options options = Options(headers: header);
            result =
                await dio.delete(url!, data: queryParameters, options: options);
            break;
          }
        case RequestType.PUT:
          // TODO: Handle this case.
          break;
        case RequestType.PATCH:
          // TODO: Handle this case.
          break;
      }
      if (result != null) {
        return result.data;
      }
    } on DioError catch (error) {
      return log("Error");
    } catch (error) {
      return log(error.toString());
    }
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // String accessToken = await PrefMgr.shared.getPrefStr("accessToken");
    // String refreshToken = await PrefMgr.shared.getPrefStr("refreshToken");

    // print('accessToken: $accessToken');

    // if (accessToken != null && accessToken != '') {
    //   options.headers['Accept'] = 'application/json';
    //   options.headers['Content-Type'] = 'application/json';
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    //   options.headers['refreshToken'] = refreshToken;
    // }

    return handler.next(options);
  }
}

class Logging extends Interceptor {
  final Dio dio;

  Logging(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response!.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

class ErrorInterceptors extends Interceptor {
  final Dio? dio;

  ErrorInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw TimeOutException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 406:
            throw NotAcceptableException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.connectionTimeout:
        // TODO: Handle this case.
        break;
      case DioErrorType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioErrorType.badResponse:
        // TODO: Handle this case.
        break;
      case DioErrorType.connectionError:
        // TODO: Handle this case.
        break;
      case DioErrorType.unknown:
        // TODO: Handle this case.
        break;
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NotAcceptableException extends DioError {
  NotAcceptableException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Not Acceptable';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class TimeOutException extends DioError {
  TimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

final Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};
