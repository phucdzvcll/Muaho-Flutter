import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/sign_in/domain/models/sign_in_model.dart';
import 'package:muaho/features/sign_in/domain/repo/sign_in_repository.dart';

class SignInUseCase extends BaseUseCase<EmptyInput, SignInEntity> {
  final SignInRepository signInRepository;

  SignInUseCase({required this.signInRepository});

  @override
  Future<Either<Failure, SignInEntity>> executeInternal(
      EmptyInput input) async {
    return await signInRepository.loginAnonymous();
  }
}
