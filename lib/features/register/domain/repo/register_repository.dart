import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/register/domain/models/register_email_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterEmailEntity>> registerEmail(
      String email, String password, String displayName);
}
