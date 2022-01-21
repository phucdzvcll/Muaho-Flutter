import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/login/domain/models/login_email_entity.dart';
import 'package:muaho/features/login/domain/repo/login_repository.dart';

class LoginEmailUseCase extends BaseUseCase<LoginParam, LoginEmailEntity> {
  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, LoginEmailEntity>> executeInternal(
      LoginParam input) async {
    return await loginRepository.loginEmail(input.email, input.password);
  }

  LoginEmailUseCase({
    required this.loginRepository,
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
