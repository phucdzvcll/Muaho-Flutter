// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_address_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CreateAddressService implements CreateAddressService {
  _CreateAddressService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://muaho.tinyflutterteam.com:9000/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> createAddress(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/user/address',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
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
