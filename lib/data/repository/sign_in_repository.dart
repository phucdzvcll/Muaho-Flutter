import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/data/response/sign_in/refresh_token_response.dart';
import 'package:muaho/domain/domain.dart';

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

  @override
  Future<Either<Failure, LoginEmailEntity>> loginEmail(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await configLogin();
      return SuccessValue(LoginEmailEntity());
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
      String email, String password, String displayName) async {
    try {
      User? anonymousUser = firebaseAuth.currentUser;
      await anonymousUser?.updateEmail(email);
      await anonymousUser?.updatePassword(password);
      await anonymousUser?.updateDisplayName(displayName);
      await configLogin();
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
