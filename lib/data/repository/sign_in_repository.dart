import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/data/response/sign_in/refresh_token_response.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/sign_in/jwt_entity.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInService service;
  final UserStore userStore;
  final FirebaseAuth firebaseAuth;

  SignInRepositoryImpl({
    required this.service,
    required this.userStore,
    required this.firebaseAuth,
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
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
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
      log(refreshTokenResponse.jwtToken.defaultEmpty());
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
          return FailValue(result.fail);
        }
      } else {
        return FailValue(
          CommonError(),
        );
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

  @override
  Future<Either<Failure, LoginEmailEntity>> loginEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      IdTokenResult? token = await userCredential.user?.getIdTokenResult(true);
      String? firebaseToken = token?.token;

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
        return SuccessValue(LoginEmailEntity());
      }
      return FailValue(
        LoginFailure(loginError: LoginError.defaultError),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return FailValue(
          LoginFailure(loginError: LoginError.emailNotExist),
        );
      } else {
        return FailValue(
          LoginFailure(loginError: LoginError.emailOrPassNotMatch),
        );
      }
    } on Exception catch (e) {
      return FailValue(
        UnCatchError(exception: e),
      );
    }
  }

  @override
  Future<Either<Failure, RegisterEmailEntity>> registerEmail(
      String email, String password) async {
    try {
      User? anonymousUser = firebaseAuth.currentUser;
      await anonymousUser?.updateEmail(email);
      await anonymousUser?.updatePassword(password);

      return SuccessValue(RegisterEmailEntity());
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return FailValue(
          RegisterFailure(registerError: RegisterError.weakPassword),
        );
      } else if (e.code == 'email-already-in-use') {
        return FailValue(
          RegisterFailure(registerError: RegisterError.emailAlreadyInUse),
        );
      } else {
        return FailValue(
          RegisterFailure(registerError: RegisterError.defaultError),
        );
      }
    } on Exception catch (e) {
      return FailValue(
        UnCatchError(exception: e),
      );
    }
  }
}
