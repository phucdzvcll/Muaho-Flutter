import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/use_case/sign_in/login_email_use_case.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/register/register_screen.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static final String routeName = 'LoginScreen';

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt(),
      child: Builder(builder: (ctx) {
        return BlocListener<LoginBloc, LoginState>(
          listenWhen: (pre, curr) =>
              curr is LoginSuccess ||
              curr is LoginFail ||
              curr is LoginValidatedState,
          listener: (context, state) async {
            if (state is LoginSuccess) {
              ctx.showSnackBar(LocaleKeys.login_successTitle.translate());
            } else if (state is LoginFail) {
              if (state.errorMss == LoginError.emailNotExist) {
                ctx.showSnackBar(
                    LocaleKeys.login_emailNotExistTitle.translate());
              } else if (state.errorMss == LoginError.emailOrPassNotMatch) {
                ctx.showSnackBar(
                    LocaleKeys.login_emailOrPassNotMatchMess.translate());
              } else {
                ctx.showSnackBar(LocaleKeys.login_errorDefaultMess.translate());
              }
            } else if (state is LoginValidatedState) {
              ctx.showSnackBar(state.mess);
            }
          },
          child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBarComponent(
                    widget: SizedBox.shrink(),
                  ),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    scrollDirection: Axis.vertical,
                    child: _loginBuilder(ctx),
                  ),
                ),
              )),
        );
      }),
    );
  }

  Widget _loginBuilder(BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: Duration(milliseconds: 1000),
            child: _logoBuilder(theme, ctx),
          ),
          FadeInLeft(
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (pre, curr) => curr is ValidatedEmailState,
              builder: (ctx, state) {
                return Stack(
                  children: [
                    _emailInput(theme, state, ctx),
                    state is ValidatedEmailState
                        ? Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: _iconEmailValidatedBuilder(state),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                );
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInRight(
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (pre, curr) => curr is ValidatedPasswordState,
              builder: (ctx, state) {
                return Stack(
                  children: [
                    _passwordInput(theme, state, ctx),
                    state is ValidatedPasswordState
                        ? Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: _iconPasswordValidatedBuilder(state),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                );
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          SizedBox(
            height: 50,
          ),
          FadeInUp(
            duration: Duration(milliseconds: 1000),
            child: _doneBtn(ctx),
          ),
          FadeInUp(
            duration: Duration(milliseconds: 1200),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: LocaleKeys.login_youDonNotHaveAccountQuestion
                            .translate(),
                        style: theme.textTheme.bodyText2),
                    TextSpan(
                        text: LocaleKeys.login_registerNowLabel.translate(),
                        style: theme.textTheme.bodyText1?.copyWith(
                          color: theme.primaryColorLight,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(ctx, RegisterScreen.routeName);
                          }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoBuilder(ThemeData theme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/images/logo_square.png",
              width: (MediaQuery.of(context).size.width / 6) * 4,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.login_sloganHeadline.translate(),
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 28),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.login_sloganSub.translate(),
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doneBtn(BuildContext ctx) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await getIt.get<AppLocalization>().setLocale(context, Locale("en"));
            if (!(state is RequestingLoginState)) {
              BlocProvider.of<LoginBloc>(ctx).add(
                PressLoginBtnEvent(),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Center(
              child: state is RequestingLoginState
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          LocaleKeys.login_requestLoginMess.translate(),
                          style: Theme.of(ctx)
                              .textTheme
                              .headline1
                              ?.copyWith(color: Colors.white, fontSize: 16),
                        )
                      ],
                    )
                  : Text(
                      LocaleKeys.login_loginLabel.translate(),
                      style: Theme.of(ctx)
                          .textTheme
                          .headline1
                          ?.copyWith(color: Colors.white),
                    ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(ctx).primaryColorLight,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _iconEmailValidatedBuilder(ValidatedEmailState state) {
    switch (state.emailValidated) {
      case EmailValidatedState.Invalid:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case EmailValidatedState.Illegal:
        return Icon(
          Icons.do_not_disturb_on,
          color: Colors.red,
        );
      case EmailValidatedState.Empty:
        return SizedBox.shrink();
    }
  }

  Widget _iconPasswordValidatedBuilder(ValidatedPasswordState state) {
    switch (state.validatedState) {
      case PasswordValidatedState.Invalid:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case PasswordValidatedState.Illegal:
        return Icon(
          Icons.do_not_disturb_on,
          color: Colors.red,
        );
      case PasswordValidatedState.Empty:
        return SizedBox.shrink();
    }
  }

  Widget _emailInput(ThemeData theme, LoginState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        onChanged: (value) {
          BlocProvider.of<LoginBloc>(ctx).add(TextingEmailEvent(value: value));
        },
        textAlignVertical: TextAlignVertical.center,
        controller: _emailController,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: state is ValidatedEmailState &&
                !(state.emailValidated == EmailValidatedState.Empty),
            child: GestureDetector(
              onTap: () {
                _emailController.clear();
                BlocProvider.of<LoginBloc>(ctx)
                    .add(TextingEmailEvent(value: ""));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 36.0),
                child: Icon(
                  Icons.highlight_off_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text(LocaleKeys.login_passwordLabel.translate()),
          hintText: LocaleKeys.login_emailHinText.translate(),
          labelStyle: theme.textTheme.headline3,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.primaryColorLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.backgroundColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordInput(ThemeData theme, LoginState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
          controller: _passwordController,
          onChanged: (value) {
            BlocProvider.of<LoginBloc>(ctx).add(
              TextingPasswordEvent(value: value),
            );
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.visiblePassword,
          obscureText: state is ValidatedPasswordState && state.obscureText,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: state is ValidatedPasswordState &&
                  EmailValidatedState.Empty.name != state.validatedState.name,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(ctx).add(
                    ChangeObscureTextEvent(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 36.0),
                  child: Icon(
                    state is ValidatedPasswordState && state.obscureText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            border: InputBorder.none,
            label: Text(LocaleKeys.login_passwordLabel.translate()),
            hintText: LocaleKeys.login_passwordHintText.translate(),
            labelStyle: theme.textTheme.headline3,
            contentPadding:
                const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.primaryColorLight,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.backgroundColor,
                width: 1.0,
              ),
            ),
          )),
    );
  }
}
