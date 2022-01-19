import 'package:equatable/equatable.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/register/domain/models/register_email_entity.dart';
import 'package:muaho/features/register/domain/repo/register_repository.dart';

class RegisterEmailUseCase
    extends BaseUseCase<RegisterParam, RegisterEmailEntity> {
  final RegisterRepository registerRepository;

  @override
  Future<Either<Failure, RegisterEmailEntity>> executeInternal(
      RegisterParam input) async {
    return await registerRepository.registerEmail(
        input.email, input.password, input.displayName);
  }

  RegisterEmailUseCase({
    required this.registerRepository,
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
