// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrderService implements OrderService {
  _OrderService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://muaho.tinyflutterteam.com:9000/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OrderStatus> createOrder(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderStatus>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderStatus.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
