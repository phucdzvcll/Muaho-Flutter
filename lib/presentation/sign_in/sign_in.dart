import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/presentation/main/bloc/main_bloc.dart';

import 'bloc/sign_bloc_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: BlocProvider<SignBloc>(
            create: (ctx) => inject()..add(GetJwtTokenEvent()),
            child: BlocListener<SignBloc, SignBlocState>(
              listener: (ctx, state) {
                if (state is SignSuccess) {
                  BlocProvider.of<MainBloc>(context).add(GoToHomeScreenEvent());
                }
              },
              child: BlocBuilder<SignBloc, SignBlocState>(
                builder: (ctx, state) {
                  return Center(
                    child: Container(
                      child: _signInBuilder(state, ctx),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInBuilder(SignBlocState state, BuildContext ctx) {
    if (state is SignLoading) {
      return CircularProgressIndicator();
    } else {
      return SizedBox.shrink();
    }
  }
}
