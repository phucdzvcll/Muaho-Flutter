import 'package:muaho/domain/domain.dart';

class LoginEmailUseCase extends BaseUseCase<LoginParam, LoginEmailEntity> {
  final SignInRepository signInRepository;

  @override
  Future<Either<Failure, LoginEmailEntity>> executeInternal(
      LoginParam input) async {
    return await signInRepository.loginEmail(input.email, input.password);
  }

  LoginEmailUseCase({
    required this.signInRepository,
  });
}

enum LoginError {
  emailNotExist,
  emailOrPassNotMatch,
  defaultError,
}

class LoginFailure extends FeatureFailure {
  final LoginError loginError;

  LoginFailure({
    required this.loginError,
  });
}

class LoginParam {
  final String email;
  final String password;

  const LoginParam({
    required this.email,
    required this.password,
  });
}
