import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/TokenStore.dart';

Dio createDioInstance() {
  final BaseOptions baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  final Dio dio = Dio(baseOptions);
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    String url = options.uri.toString();
    String body = ((options.data is String)
            ? options.data
            : (options.data != null ? jsonEncode(options.data) : "")) ??
        "";
    HttpMethod method = HttpMethod.GET;
    if (options.method == 'POST') {
      method = HttpMethod.POST;
    }

    Map<String, dynamic> headers = await _buildHeaders(url, body, method);
    options.headers.addAll(headers);
    return handler.next(options);
  }));
  // if (kDebugMode) {
  //   dio.interceptors.add(PrettyDioLogger());
  // }

  return dio;
}

Future<Map<String, String>> _buildHeaders(
    String url, String body, HttpMethod method) async {
  TokenStore token = GetIt.instance.get();

  Map<String, String> headers = {"Authorization": "Bearer ${token.token} "};

  return headers;
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
