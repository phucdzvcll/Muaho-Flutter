import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetJwtTokenUseCase extends BaseUseCase<SignInParam, SignInEntity> {
  final SignInRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, SignInEntity>> executeInternal(
      SignInParam input) async {
    return await repository.getJwtToken(firebaseToken: input.firebaseToken);
  }
}

class SignInParam {
  final String firebaseToken;

  SignInParam({required this.firebaseToken});
}
