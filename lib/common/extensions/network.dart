import 'package:dio/dio.dart';

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
