import '../../domain.dart';

class SignInUseCase extends BaseUseCase<EmptyInput, SignInEntity> {
  final SignInRepository signInRepository;

  SignInUseCase({required this.signInRepository});

  @override
  Future<Either<Failure, SignInEntity>> executeInternal(
      EmptyInput input) async {
    return await signInRepository.loginAnonymous();
  }
}
