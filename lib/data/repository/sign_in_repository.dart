import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/data/response/sign_in/refresh_token_response.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/sign_in/jwt_entity.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInService service;
  final UserStore userStore;

  SignInRepositoryImpl({
    required this.service,
    required this.userStore,
  });

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
    String? rToken = await userStore.getRefreshToken();
    if (auth.currentUser != null && rToken != null && rToken.isNotEmpty) {
      RefreshTokenResponse refreshTokenResponse =
          await apiSignInService.refreshToken(
              RefreshTokenBodyParam(refreshToken: rToken.defaultEmpty()));
      String userName = (await userStore.getUserName()).defaultEmpty();
      userStore
        ..setToken(refreshTokenResponse.jwtToken.defaultEmpty())
        ..setUseName(userName);
      return SuccessValue(SignInEntity(userName: userName));
    } else {
      String? firebaseToken = await _loginFirebaseAnonymousUser(auth);
      if (firebaseToken != null) {
        Either<Failure, JwtEntity> result =
            await getJwtToken(firebaseToken: firebaseToken.defaultEmpty());

        if (result.isSuccess) {
          //Di singleton JWT
          var jwt = result.success.jwtToken;
          var rJwt = result.success.refreshToken;
          var userName = result.success.userName;
          userStore
            ..setToken(jwt)
            ..setUseName(userName);
          await userStore.save(userName: userName, refreshToken: rJwt);

          return SuccessValue(SignInEntity(userName: userName));
        } else {
          return FailValue(Failure());
        }
      }

      return FailValue(Failure());
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
