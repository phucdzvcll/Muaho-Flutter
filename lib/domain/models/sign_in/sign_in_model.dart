class SignInEntity {
  final String jwtToken;
  final String userName;
  final String refreshToken;

  SignInEntity({
    required this.jwtToken,
    required this.userName,
    required this.refreshToken
  });

  SignInEntity copyWith({
    String? jwtToken,
    String? userName,
    String? refreshToken
  }) {
    return SignInEntity(
      jwtToken: jwtToken ?? this.jwtToken,
      userName: userName ?? this.userName,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() => 'SignInEntity(jwtToken: $jwtToken, userName: $userName, refreshToken: $refreshToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignInEntity &&
        other.jwtToken == jwtToken &&
        other.userName == userName &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => jwtToken.hashCode ^ userName.hashCode ^ refreshToken.hashCode;
}
