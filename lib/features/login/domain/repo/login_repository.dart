import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/login/domain/models/login_email_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEmailEntity>> loginEmail(
      String email, String password);
}
