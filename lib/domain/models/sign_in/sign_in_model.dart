class SignInEntity {
  final String userName;

//<editor-fold desc="Data Methods">

  const SignInEntity({
    required this.userName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignInEntity &&
          runtimeType == other.runtimeType &&
          userName == other.userName);

  @override
  int get hashCode => userName.hashCode;

  @override
  String toString() {
    return 'SignInEntity{' + ' userName: $userName,' + '}';
  }

  SignInEntity copyWith({
    String? userName,
  }) {
    return SignInEntity(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
    };
  }

  factory SignInEntity.fromMap(Map<String, dynamic> map) {
    return SignInEntity(
      userName: map['userName'] as String,
    );
  }

//</editor-fold>
}
