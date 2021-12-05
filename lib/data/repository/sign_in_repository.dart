import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/domain/domain.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInService service = GetIt.instance.get();
  @override
  Future<Either<Failure, SignInEntity>> getJwtToken(
      {required String firebaseToken}) async {
    var signInRequest = service.signIn(SignInBodyParam(firebaseToken: firebaseToken));
    var result = await handleNetworkResult(signInRequest);
    if (result.isSuccess()) {
      SignInEntity entity = SignInEntity(
          jwtToken: result.response!.jwtToken.defaultEmpty(),
          userName: result.response!.userName.defaultEmpty(),
          refreshToken: result.response!.refreshToken.defaultEmpty());
      return SuccessValue(entity);
    } else {
      return FailValue(Failure());
    }
  }
}
