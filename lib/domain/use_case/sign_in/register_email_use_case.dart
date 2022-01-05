import 'package:equatable/equatable.dart';
import 'package:muaho/domain/domain.dart';

class RegisterEmailUseCase
    extends BaseUseCase<RegisterParam, RegisterEmailEntity> {
  final SignInRepository signInRepository;

  @override
  Future<Either<Failure, RegisterEmailEntity>> executeInternal(
      RegisterParam input) async {
    return await signInRepository.registerEmail(
        input.email, input.password, input.displayName);
  }

  RegisterEmailUseCase({
    required this.signInRepository,
  });
}

enum RegisterError {
  weakPassword,
  emailAlreadyInUse,
  defaultError,
}

class RegisterFailure extends FeatureFailure {
  final RegisterError registerError;

  RegisterFailure({
    required this.registerError,
  });
}

class RegisterParam extends Equatable {
  final String email;
  final String password;
  final String displayName;
  const RegisterParam({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}
