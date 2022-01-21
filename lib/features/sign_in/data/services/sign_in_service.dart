import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/sign_in/data/response/refresh_token_response.dart';
import 'package:muaho/features/sign_in/data/response/sign_in_response.dart';
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

class RefreshTokenBodyParam extends Equatable {
  final String? refreshToken;

  RefreshTokenBodyParam({
    this.refreshToken,
  });

  factory RefreshTokenBodyParam.fromJson(Map<String, dynamic> json) {
    return RefreshTokenBodyParam(
      refreshToken: json.parseString('refresh_token'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['refresh_token'] = refreshToken;
    return data;
  }

  @override
  List<Object?> get props => [
        refreshToken,
      ];
}

class SignInBodyParam extends Equatable {
  final String? firebaseToken;
  final String? displayName;
  final String? email;

  SignInBodyParam({
    this.firebaseToken,
    this.displayName,
    this.email,
  });

  factory SignInBodyParam.fromJson(Map<String, dynamic> json) {
    return SignInBodyParam(
      firebaseToken: json.parseString('firebase_token'),
      displayName: json.parseString('displayName'),
      email: json.parseString('email'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firebase_token'] = firebaseToken;
    data['displayName'] = displayName;
    data['email'] = email;
    return data;
  }

  @override
  List<Object?> get props => [
        firebaseToken,
        displayName,
        email,
      ];
}
