import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String userName;

  const SignInEntity({
    required this.userName,
  });

  @override
  List<Object?> get props => [userName];
}
