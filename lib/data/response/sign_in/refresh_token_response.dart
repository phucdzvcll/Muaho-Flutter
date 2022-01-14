import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class RefreshTokenResponse extends Equatable {
  final String? jwtToken;

  RefreshTokenResponse({
    this.jwtToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      jwtToken: json.parseString('jwtToken'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['jwtToken'] = jwtToken;
    return data;
  }

  @override
  List<Object?> get props => [
        jwtToken,
      ];
}
