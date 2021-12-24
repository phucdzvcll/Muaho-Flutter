import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/extensions/string.dart';
import 'package:muaho/common/model/jwt_token_store.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:synchronized/synchronized.dart' as sLock;

import '../../main.dart';

final BaseOptions baseOptions =
    BaseOptions(connectTimeout: 30000, receiveTimeout: 30000, baseUrl: baseUrl);

Dio createDioInstance() {
  //todo edit become a class

  final Dio dio = Dio(baseOptions);
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handle) async {
        if (error.response?.statusCode == 401) {
          TokenExpiredHandler tokenExpiredHandler =
              getIt.get<TokenExpiredHandler>();
          var response = await tokenExpiredHandler.handleTokenExpired(error);
          if (response != null) {
            return handle.resolve(response);
          } else {
            return handle.next(error);
          }
        } else {
          return handle.next(error);
        }
      },
      onRequest: (options, handler) async {
        UserStore token = GetIt.instance.get();
        Map<String, dynamic> headers = _buildHeaders(token.getToken());
        options.headers.addAll(headers);
        return handler.next(options);
      },
      onResponse: (response, handle) {
        handle.next(response);
      },
    ),
  );

  return dio;
}

Map<String, String> _buildHeaders(String? token) {
  Map<String, String> headers = {"Authorization": "Bearer $token"};

  return headers;
}

class TokenExpiredHandler {
  final UserStore userStore;
  String _currentJwt = "";
  var lock = new sLock.Lock();

  TokenExpiredHandler({required this.userStore});

  Future<Response<dynamic>?> handleTokenExpired(DioError error) async {
    try {
      await lock.synchronized(() async {
        if (error.requestOptions.headers["Authorization"] ==
                "Bearer $_currentJwt" ||
            _currentJwt.isEmpty) {
          String? rToken = await userStore.getRefreshToken();
          var jwt = await apiSignInService.refreshToken(
              RefreshTokenBodyParam(refreshToken: rToken.defaultEmpty()));
          getIt.get<UserStore>().setToken(jwt.jwtToken.defaultEmpty());
          _currentJwt = jwt.jwtToken.defaultEmpty();
        }
      });
      log(_currentJwt);
      return await _retry(error, _currentJwt);
    } on Exception catch (e) {
      return null;
    }
  }

  Future<Response> _retry(DioError error, String jwt) async {
    var requestOptions = error.requestOptions;
    final Dio dio = Dio(baseOptions);
    final Options options = Options(headers: requestOptions.headers);
    options.headers?.remove("Authorization");
    options.headers?.addAll(_buildHeaders(jwt));
    var response = await dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
    return response;
  }
}

Future<NetworkResult<T>> handleNetworkResult<T>(
  Future<T> request,
) async {
  try {
    final dynamic response = await request;
    if (response is T) {
      return NetworkResult<T>(response: response);
    }
    throw Exception();
  } on DioError catch (e) {
    NetworkResult<T> networkResult =
        NetworkResult<T>(error: NetworkError.DEFAULT);

    switch (e.type) {
      case DioErrorType.connectTimeout:
        networkResult = NetworkResult<T>(error: NetworkError.CONNECT_TIMEOUT);
        break;
      case DioErrorType.sendTimeout:
        networkResult = NetworkResult<T>(error: NetworkError.PROCESS_TIMEOUT);
        break;
      case DioErrorType.receiveTimeout:
        networkResult = NetworkResult<T>(error: NetworkError.PROCESS_TIMEOUT);
        break;
      case DioErrorType.response:
        networkResult = NetworkResult<T>(error: NetworkError.SERVER_ERROR);
        break;
      case DioErrorType.cancel:
        networkResult = NetworkResult<T>(error: NetworkError.CANCEL);
        break;
      case DioErrorType.other:
        networkResult = NetworkResult<T>(error: NetworkError.DEFAULT);
        break;
    }
    return networkResult;
  }
}

enum NetworkError {
  CONNECT_TIMEOUT,
  PROCESS_TIMEOUT,
  SERVER_ERROR,
  CANCEL,
  DEFAULT,
}

class NetworkResult<T> {
  final T? response;
  final NetworkError error;
  final int errorCode;

  NetworkResult(
      {this.response, this.error = NetworkError.DEFAULT, this.errorCode = 0});

  bool isSuccess() {
    return response != null;
  }
}

enum HttpMethod {
  GET,
  POST,
}
