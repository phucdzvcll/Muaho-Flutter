import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/sign_in/sign_in_service.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/sign_in/get_jwt_token_use_case.dart';
import 'package:muaho/main.dart';

part 'sign_bloc_event.dart';
part 'sign_bloc_state.dart';

final String rJTW = "rJWT";
final String userNameKey = "userName";

class SignBloc extends Bloc<SignBlocEvent, SignBlocState> {
  SignBloc() : super(SignInitial());

  GetJwtTokenUseCase _useCase = GetIt.instance.get();
  var auth = FirebaseAuth.instance;

  Future<String?> loginAnonymousUser(FirebaseAuth auth) async {
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
  Stream<SignBlocState> mapEventToState(SignBlocEvent event) async* {
    if (event is GetJwtTokenEvent) {
      yield* _handleRequestSignIn();
    }
  }

  Stream<SignBlocState> _handleRequestSignIn() async* {
    yield SignLoading();

    if (auth.currentUser != null) {
      String? rToken = await storage.read(key: rJTW);
      var jwt = await apiSignInService.refreshToken(
          RefreshTokenBodyParam(refreshToken: rToken.defaultEmpty()));
      //Di singleton JWT
      getIt.get<TokenStore>().setToken(jwt.jwtToken.defaultEmpty());
      log(jwt.jwtToken.defaultEmpty());
      String? userName = await storage.read(key: userNameKey);

      yield SignSuccess(
          entity: SignInEntity(
              jwtToken: "",
              userName: userName.defaultEmpty(),
              refreshToken: ""));
    } else {
      loginAnonymousUser(auth);
      String? firebaseToken = await loginAnonymousUser(auth);

      Either<Failure, SignInEntity> result = await _useCase
          .execute(SignInParam(firebaseToken: firebaseToken.defaultEmpty()));

      if (result.isSuccess) {
        //Di singleton JWT
        getIt
            .get<TokenStore>()
            .setToken(result.success.jwtToken.defaultEmpty());

        try {
          await _storeStaticData(result);

          yield SignSuccess(entity: result.success);
        } on Exception catch (e) {
          yield SignError(errorMss: e.toString());
        }
      } else {
        yield SignError(errorMss: "Error");
      }
    }
  }

  Future<void> _storeStaticData(Either<Failure, SignInEntity> result) async {
    String? rToken = await storage.read(key: rJTW);
    if (rToken != null) {
      await storage.delete(key: rJTW);
    }
    //store refresh JWT
    await storage.write(key: rJTW, value: result.success.refreshToken);

    String? userName = await storage.read(key: userNameKey);
    if (userName != null) {
      await storage.delete(key: userNameKey);
    }
    //store userName
    await storage.write(key: userNameKey, value: result.success.userName);
  }
}
