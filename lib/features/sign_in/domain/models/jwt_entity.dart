import 'package:equatable/equatable.dart';

class JwtEntity extends Equatable {
  final String jwtToken;
  final String userName;
  final String refreshToken;

  const JwtEntity({
    required this.jwtToken,
    required this.userName,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        jwtToken,
        userName,
        refreshToken,
      ];
}
