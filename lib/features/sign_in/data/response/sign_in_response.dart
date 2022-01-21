import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class SignInResponse extends Equatable {
  final String? jwtToken;
  final String? userName;
  final String? refreshToken;

  SignInResponse({
    this.jwtToken,
    this.userName,
    this.refreshToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      jwtToken: json.parseString('jwtToken'),
      userName: json.parseString('userName'),
      refreshToken: json.parseString('refreshToken'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['jwtToken'] = jwtToken;
    data['userName'] = userName;
    data['refreshToken'] = refreshToken;
    return data;
  }

  @override
  List<Object?> get props => [
        jwtToken,
        userName,
        refreshToken,
      ];
}
