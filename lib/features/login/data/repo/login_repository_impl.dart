import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/login/domain/models/login_email_entity.dart';
import 'package:muaho/features/login/domain/repo/login_repository.dart';
import 'package:muaho/features/login/domain/use_case/login_email_use_case.dart';
import 'package:muaho/features/sign_in/data/services/sign_in_service.dart';
import 'package:muaho/features/sign_in/domain/models/jwt_entity.dart';

class LoginRepositoryImpl extends LoginRepository {
  final FirebaseAuth firebaseAuth;
  final SignInService service;
  final UserStore userStore;

  LoginRepositoryImpl(
      {required this.firebaseAuth,
      required this.service,
      required this.userStore});

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
}
