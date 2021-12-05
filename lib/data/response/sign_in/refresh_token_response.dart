import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response.g.dart';

@JsonSerializable()
class RefreshTokenResponse {
  final String? jwtToken;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);

//<editor-fold desc="Data Methods">

  const RefreshTokenResponse({
    this.jwtToken,
  });

  @override
  String toString() {
    return 'RefreshTokenResponse{' + ' jwtToken: $jwtToken,' + '}';
  }

//</editor-fold>
}
