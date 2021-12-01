import '../domain.dart';

abstract class SignInRepository {
  Future<Either<Failure, SignInEntity>> getJwtToken(
      {required String firebaseToken});
}
