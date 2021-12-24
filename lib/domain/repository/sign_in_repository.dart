import '../domain.dart';

abstract class SignInRepository {
  Future<Either<Failure, JwtEntity>> getJwtToken(
      {required String firebaseToken});

  Future<Either<Failure, SignInEntity>> loginAnonymous();
}
