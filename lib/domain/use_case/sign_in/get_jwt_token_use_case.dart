import 'package:get_it/get_it.dart';

import '../../domain.dart';

class SignInUseCase extends BaseUseCase<EmptyInput, SignInEntity> {
  final SignInRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, SignInEntity>> executeInternal(
      EmptyInput input) async {
    return await repository.loginAnonymous();
  }
}
