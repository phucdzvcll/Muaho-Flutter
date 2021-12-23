import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'sign_in_service.g.dart';

final apiSignInService = SignInService(Dio(baseOptions));

@RestApi(baseUrl: baseUrl)
abstract class SignInService {
  factory SignInService(Dio dio) = _SignInService;

  @POST("/user/signin")
  Future<SignInResponse> signIn(@Body() SignInBodyParam bodyParam);

  @POST("/user/refresh_token")
  Future<RefreshTokenResponse> refreshToken(
      @Body() RefreshTokenBodyParam bodyParam);
}

@JsonSerializable()
class RefreshTokenBodyParam {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  RefreshTokenBodyParam({required this.refreshToken});

  factory RefreshTokenBodyParam.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenBodyParamFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenBodyParamToJson(this);
}

@JsonSerializable()
class SignInBodyParam {
  @JsonKey(name: 'firebase_token')
  final String firebaseToken;

  SignInBodyParam({required this.firebaseToken});

  factory SignInBodyParam.fromJson(Map<String, dynamic> json) =>
      _$SignInBodyParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignInBodyParamToJson(this);
}
