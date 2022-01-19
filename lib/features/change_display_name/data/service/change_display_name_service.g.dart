// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_display_name_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ChangeDisplayNameService implements ChangeDisplayNameService {
  _ChangeDisplayNameService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.254:8000/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DisplayNameResponse> changeDisplayName(displayName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(displayName.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DisplayNameResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/update/username',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DisplayNameResponse.fromJson(_result.data!);
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
