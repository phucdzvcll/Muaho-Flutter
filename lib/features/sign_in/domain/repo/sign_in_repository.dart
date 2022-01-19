import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/sign_in/domain/models/jwt_entity.dart';
import 'package:muaho/features/sign_in/domain/models/sign_in_model.dart';

abstract class SignInRepository {
  Future<Either<Failure, JwtEntity>> getJwtToken(
      {required String firebaseToken});

  Future<Either<Failure, SignInEntity>> loginAnonymous();
}
