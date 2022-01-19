import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/login/domain/use_case/login_email_use_case.dart';
import 'package:muaho/features/register/domain/models/register_email_entity.dart';
import 'package:muaho/features/register/domain/repo/register_repository.dart';
import 'package:muaho/features/register/domain/use_case/register_email_use_case.dart';
import 'package:muaho/features/sign_in/data/services/sign_in_service.dart';
import 'package:muaho/features/sign_in/domain/models/jwt_entity.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final SignInService service;
  final UserStore userStore;
  final FirebaseAuth firebaseAuth;

  RegisterRepositoryImpl({
    required this.service,
    required this.userStore,
    required this.firebaseAuth,
  });

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
}
