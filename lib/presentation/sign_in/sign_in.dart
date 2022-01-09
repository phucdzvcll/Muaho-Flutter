import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/maintenance/maintenance.dart';

import 'bloc/sign_bloc_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocProvider<SignBloc>(
            create: (ctx) => getIt()..add(GetJwtTokenEvent()),
            child: BlocListener<SignBloc, SignBlocState>(
              listener: (ctx, state) {
                if (state is SignSuccess) {
                  Navigator.pushReplacementNamed(
                    ctx,
                    HomeScreen.routeName,
                  );
                } else if (state is MaintenanceSate) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MaintenanceScreen(totalMinute: state.totalMinutes),
                    ),
                  );
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
