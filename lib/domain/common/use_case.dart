import 'either.dart';
import 'failure.dart';

abstract class BaseUseCase<I, O> {
  Future<Either<Failure, O>> executeInternal(I input);

  Future<Either<Failure, O>> execute(I input) async {
    try {
      return await executeInternal(input);
    } on Exception catch (e) {
      return FailValue(Failure());
    }
  }
}

class EmptyInput {}
