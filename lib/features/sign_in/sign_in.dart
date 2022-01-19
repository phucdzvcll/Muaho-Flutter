import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/features/main/bloc/main_bloc.dart';
import 'package:muaho/generated/assets.gen.dart';

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
                  return Container(
                    height: double.infinity,
                    child: _signInBuilder(state, ctx),
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
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // return SizedBox.shrink();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(Assets.json.error),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                BlocProvider.of<SignBloc>(ctx).add(ReloadEvent());
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).primaryColorLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Thử lại",
                  textAlign: TextAlign.center,
                  style: Theme.of(ctx)
                      .textTheme
                      .headline2
                      ?.copyWith(color: Theme.of(ctx).backgroundColor),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
