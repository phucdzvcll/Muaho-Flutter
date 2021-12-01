import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'sign_in_service.g.dart';

@RestApi(baseUrl: "http://103.221.220.249:9000/api/")
abstract class SignInService {
  factory SignInService(Dio dio) = _SignInService;

  @POST("/user/signin")
  Future<SignInResponse> signIn(@Body() BodyParam bodyParam);
}

@JsonSerializable()
class BodyParam {
  @JsonKey(name: 'firebase_token')
  final String firebaseToken;

  BodyParam({required this.firebaseToken});

  factory BodyParam.fromJson(Map<String, dynamic> json) =>
      _$BodyParamFromJson(json);

  Map<String, dynamic> toJson() => _$BodyParamToJson(this);
}
