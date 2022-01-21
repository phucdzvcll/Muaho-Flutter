import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/login/domain/use_case/login_email_use_case.dart';
import 'package:muaho/features/sign_in/data/response/refresh_token_response.dart';
import 'package:muaho/features/sign_in/data/services/sign_in_service.dart';
import 'package:muaho/features/sign_in/domain/models/jwt_entity.dart';
import 'package:muaho/features/sign_in/domain/models/sign_in_model.dart';
import 'package:muaho/features/sign_in/domain/repo/sign_in_repository.dart';

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
    var signInRequest = service.signIn(SignInBodyParam(
        firebaseToken: firebaseToken, email: null, displayName: null));
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

  Future configLogin() async {
    IdTokenResult? token =
        await FirebaseAuth.instance.currentUser?.getIdTokenResult(true);
    String? firebaseToken = token?.token;

    if (firebaseToken != null) {
      log(firebaseToken);
      Either<Failure, JwtEntity> result =
          await getJwtToken(firebaseToken: firebaseToken);
      if (result.isSuccess) {
        //Di singleton JWT
        String jwt;
        jwt = result.success.jwtToken;
        String rJwt = result.success.refreshToken;
        String userName =
            (firebaseAuth.currentUser?.displayName).defaultEmpty();
        String email = (firebaseAuth.currentUser?.email).defaultEmpty();
        userStore
          ..setToken(jwt)
          ..setUseName(userName)
          ..setEmail(email);
        await userStore.save(
            userName: userName,
            refreshToken: rJwt,
            email: email,
            contactPhone: "");
      } else {
        throw result.fail;
      }
    } else {
      throw LoginFailure(loginError: LoginError.defaultError);
    }
  }

  @override
  Future<Either<Failure, SignInEntity>> loginAnonymous() async {
    String? rToken = await userStore.getRefreshToken();
    if (firebaseAuth.currentUser != null &&
        rToken != null &&
        rToken.isNotEmpty) {
      Future<RefreshTokenResponse> request;
      request = apiSignInService.refreshToken(
          RefreshTokenBodyParam(refreshToken: rToken.defaultEmpty()));
      NetworkResult<RefreshTokenResponse> result =
          await handleNetworkResult(request);

      var response = result.response;
      if (result.isSuccess() && response != null) {
        String userName = (await userStore.getUserName()).defaultEmpty();
        String email = (await userStore.getEmail()).defaultEmpty();
        userStore
          ..setToken(response.jwtToken.defaultEmpty())
          ..setUseName(userName)
          ..setEmail(email);
        return SuccessValue(SignInEntity(
          userName: userName,
        ));
      } else {
        return FailValue(
          ServerError(msg: result.error, errorCode: result.errorCode),
        );
      }
    } else {
      try {
        await firebaseAuth.signInAnonymously();
        await configLogin();
        String userName =
            (firebaseAuth.currentUser?.displayName).defaultEmpty();
        return SuccessValue(SignInEntity(userName: userName));
      } on Exception catch (e) {
        return FailValue(UnCatchError(exception: e));
      }
    }
  }
}
