import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  final String? jwtToken;
  final String? userName;
  final String? refreshToken;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  SignInResponse({
    required this.jwtToken,
    required this.userName,
    required this.refreshToken
  });

  @override
  String toString() =>
      'SignInResponse(jwtToken: $jwtToken, userName: $userName, refreshToken: $refreshToken)';
}
