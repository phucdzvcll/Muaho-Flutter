import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/sign_in/jwt_entity.dart';
import 'package:muaho/main.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInService service = GetIt.instance.get();

  @override
  Future<Either<Failure, JwtEntity>> getJwtToken(
      {required String firebaseToken}) async {
    var signInRequest =
        service.signIn(SignInBodyParam(firebaseToken: firebaseToken));
    var result = await handleNetworkResult(signInRequest);
    if (result.isSuccess()) {
      JwtEntity entity = JwtEntity(
          jwtToken: result.response!.jwtToken.defaultEmpty(),
          userName: result.response!.userName.defaultEmpty(),
          refreshToken: result.response!.refreshToken.defaultEmpty());
      return SuccessValue(entity);
    } else {
      return FailValue(Failure());
    }
  }

  @override
  Future<Either<Failure, SignInEntity>> loginAnonymous() async {
    var auth = FirebaseAuth.instance;
    UserStore userStore = getIt.get();
    String? rToken = await userStore.getRefreshToken();
    if (auth.currentUser != null && rToken != null && rToken.isNotEmpty) {
      var jwt = await apiSignInService.refreshToken(
          RefreshTokenBodyParam(refreshToken: rToken.defaultEmpty()));
      //Di singleton JWT
      String? userName = await userStore.getUserName();
      getIt.get<UserStore>()
        ..setToken(jwt.jwtToken.defaultEmpty())
        ..setUseName(userName.defaultEmpty());
      return SuccessValue(SignInEntity(userName: userName.defaultEmpty()));
    } else {
      String? firebaseToken = await _loginFirebaseAnonymousUser(auth);

      Either<Failure, JwtEntity> result =
          await getJwtToken(firebaseToken: firebaseToken.defaultEmpty());

      if (result.isSuccess) {
        //Di singleton JWT
        var jwt = result.success.jwtToken;
        var rJwt = result.success.refreshToken;
        var userName = result.success.userName;
        getIt.get<UserStore>()
          ..setToken(jwt)
          ..setUseName(userName);
        await userStore.save(userName: userName, refreshToken: rJwt);

        return SuccessValue(SignInEntity(userName: userName));
      } else {
        return FailValue(Failure());
      }
    }
  }

  Future<String?> _loginFirebaseAnonymousUser(FirebaseAuth auth) async {
    try {
      await auth.signInAnonymously();
    } on FirebaseException {
      return null;
    }
    if (auth.currentUser != null) {
      IdTokenResult token =
          await FirebaseAuth.instance.currentUser!.getIdTokenResult(true);
      String? firebaseToken = token.token;
      return firebaseToken;
    } else {
      return null;
    }
  }
}
