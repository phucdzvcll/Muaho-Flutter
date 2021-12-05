import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/presentation/home/home_screen.dart';

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
            create: (ctx) => SignBloc()..add(GetJwtTokenEvent()),
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
    );
  }

  Widget _signInBuilder(SignBlocState state, BuildContext ctx) {
    if (state is SignLoading) {
      return CircularProgressIndicator();
    } else if (state is SignSuccess) {
      return showAlertDialog(
        ctx,
        "Đăng Nhập Thành Công",
        () => {
          // ScaffoldMessenger.of(ctx).showSnackBar(
          //   SnackBar(
          //     content: Text(state.entity.jwtToken),
          //   ),
          // ),
          Navigator.pushReplacementNamed(ctx, HomeScreen.routeName,
              arguments: SignInArguments(userName: state.entity.userName))
        },
      );
    } else {
      return showAlertDialog(
          ctx,
          "Đăng Nhập Không Thành Công",
          () => {
                //todo resend request or turn back to login page
              });
    }
  }

  AlertDialog showAlertDialog(
      BuildContext context, String mess, Function handleSignIn) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Đồng Ý"),
      style: MyTheme.buttonStyleNormal,
      onPressed: () {
        handleSignIn();
      },
    );

    // set up the AlertDialog
    return AlertDialog(
      backgroundColor: MyTheme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text(
        "Đăng Nhập",
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        mess,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        okButton,
      ],
    );
  }
}

class SignInArguments {
  final String userName;

  SignInArguments({required this.userName});
}
