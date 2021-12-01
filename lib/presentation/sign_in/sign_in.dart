import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_bloc_bloc.dart';

class SignIn extends StatelessWidget {
  final String firebaseToken;

  const SignIn({Key? key, required this.firebaseToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocProvider<SignBloc>(
            create: (ctx) =>
                SignBloc()..add(GetJwtTokenEvent(firebaseToken: firebaseToken)),
            child: BlocBuilder<SignBloc, SignBlocState>(
              builder: (ctx, state) {
                return Center(
                  child: Container(
                    child: _signInBuilder(state),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInBuilder(SignBlocState state) {
    if (state is SignBlocLoading) {
      return CircularProgressIndicator();
    } else if (state is SignBlocSuccess) {
      return Text(state.entity.jwtToken);
    } else {
      return Text('Error');
    }
  }
}
