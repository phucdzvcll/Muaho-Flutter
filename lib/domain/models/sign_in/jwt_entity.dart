class JwtEntity {
  final String jwtToken;
  final String userName;
  final String refreshToken;

//<editor-fold desc="Data Methods">

  const JwtEntity({
    required this.jwtToken,
    required this.userName,
    required this.refreshToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JwtEntity &&
          runtimeType == other.runtimeType &&
          jwtToken == other.jwtToken &&
          userName == other.userName &&
          refreshToken == other.refreshToken);

  @override
  int get hashCode =>
      jwtToken.hashCode ^ userName.hashCode ^ refreshToken.hashCode;

  @override
  String toString() {
    return 'JwtEntity{' +
        ' jwtToken: $jwtToken,' +
        ' userName: $userName,' +
        ' refreshToken: $refreshToken,' +
        '}';
  }

  JwtEntity copyWith({
    String? jwtToken,
    String? userName,
    String? refreshToken,
  }) {
    return JwtEntity(
      jwtToken: jwtToken ?? this.jwtToken,
      userName: userName ?? this.userName,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jwtToken': this.jwtToken,
      'userName': this.userName,
      'refreshToken': this.refreshToken,
    };
  }

  factory JwtEntity.fromMap(Map<String, dynamic> map) {
    return JwtEntity(
      jwtToken: map['jwtToken'] as String,
      userName: map['userName'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

//</editor-fold>
}
