import '../domain.dart';

abstract class SignInRepository {
  Future<Either<Failure, JwtEntity>> getJwtToken(
      {required String firebaseToken});

  Future<Either<Failure, SignInEntity>> loginAnonymous();

  Future<Either<Failure, LoginEmailEntity>> loginEmail(
      String email, String password);

  Future<Either<Failure, RegisterEmailEntity>> registerEmail(
      String email, String password, String displayName);
}
