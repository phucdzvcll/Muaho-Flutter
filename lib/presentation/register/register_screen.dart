import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/use_case/sign_in/register_email_use_case.dart';
import 'package:muaho/generated/assets.gen.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/home/home_screen.dart';

import 'bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static final String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => getIt(),
      child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBarComponent(
                widget: SizedBox.shrink(),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Builder(builder: (ctx) {
                  return BlocListener<RegisterBloc, RegisterState>(
                    listener: (ctx, state) {
                      if (state is RegisterSubmitErrorState) {
                        switch (state.registerError) {
                          case RegisterError.weakPassword:
                            context
                                .showSnackBar(RegisterError.weakPassword.name);
                            break;
                          case RegisterError.emailAlreadyInUse:
                            context.showSnackBar(
                                RegisterError.emailAlreadyInUse.name);
                            break;
                          case RegisterError.defaultError:
                            context
                                .showSnackBar(RegisterError.defaultError.name);
                            break;
                        }
                      } else if (state is CreateAccountSuccess) {
                        context.popUtil(HomeScreen.routeName);
                      }
                    },
                    child: _loginBuilder(ctx),
                  );
                }),
              ),
            ),
          )),
    );
  }

  Widget _loginBuilder(BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            duration: Duration(milliseconds: 1000),
            child: _logoBuilder(theme, ctx),
          ),
          FadeInLeft(
            child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (pre, curr) => curr is EmailValidatedState,
              builder: (ctx, state) {
                return _emailInput(theme, state, ctx);
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInRight(
            child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (pre, curr) => curr is DisplayNameValidatedState,
              builder: (ctx, state) {
                return _displayNameInput(theme, state, ctx);
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInLeft(
            child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (pre, curr) => curr is PasswordValidatedState,
              builder: (ctx, state) {
                return _passwordInput(theme, state, ctx);
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInLeft(
            child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (pre, curr) => curr is ConfirmPasswordValidatedState,
              builder: (ctx, state) {
                return _confirmPasswordInput(theme, state, ctx);
              },
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          SizedBox(
            height: 50,
          ),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (pre, curr) =>
                  curr is RequestingCreateAccountState ||
                  curr is RegisterSubmitErrorState,
              builder: (context, state) {
                return _doneBtn(context, state);
              },
            ),
          ),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: LocaleKeys.register_youDonHaveAccountQuestion
                            .translate(),
                        style: theme.textTheme.bodyText2),
                    TextSpan(
                      text: LocaleKeys.register_loginNowLabel.translate(),
                      style: theme.textTheme.bodyText1?.copyWith(
                        color: theme.primaryColorLight,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    )
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
            child: Assets.images.logoSquare.image(
              width: (MediaQuery.of(context).size.width / 6) * 4,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.register_sloganHeadline.translate(),
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 26),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.register_sloganSub.translate(),
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doneBtn(BuildContext ctx, RegisterState state) {
    return GestureDetector(
      onTap: () {
        if (!(state is RequestingCreateAccountState)) {
          BlocProvider.of<RegisterBloc>(ctx).add(
            PressSubmitRegisterEvent(),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Center(
          child: (state is RequestingCreateAccountState)
              ? SizedBox(
                  width: 27,
                  height: 27,
                  child: CircularProgressIndicator(),
                )
              : Text(
                  LocaleKeys.register_registerLabel.translate(),
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
  }

  Color _colorsEmailBorderBuilder(RegisterState state) {
    if (state is EmailValidatedState) {
      switch (state.emailValidatedState) {
        case EmailValidated.Invalid:
          return Colors.green;
        case EmailValidated.Illegal:
          return Colors.red;
        case EmailValidated.Empty:
          return Colors.blue;
      }
    } else {
      return Colors.blue;
    }
  }

  Color _colorsEmailEnableBorderBuilder(RegisterState state) {
    if (state is EmailValidatedState) {
      switch (state.emailValidatedState) {
        case EmailValidated.Invalid:
          return Colors.green[200] ?? Colors.green;
        case EmailValidated.Illegal:
          return Colors.red[100] ?? Colors.red;
        case EmailValidated.Empty:
          return Theme.of(context).backgroundColor;
      }
    } else {
      return Theme.of(context).backgroundColor;
    }
  }

  String? _errorEmailWarning(RegisterState state) {
    if (state is EmailValidatedState) {
      switch (state.emailValidatedState) {
        case EmailValidated.Invalid:
          return null;
        case EmailValidated.Illegal:
          return LocaleKeys.register_emailNotInvalidMess.translate();
        case EmailValidated.Empty:
          return LocaleKeys.register_emailEmptyInvalidMess.translate();
      }
    } else {
      return null;
    }
  }

  String? _errorDisplayNameWarning(RegisterState state) {
    if (state is DisplayNameValidatedState) {
      switch (state.displayNameValidated) {
        case DisplayNameValidated.Invalid:
          return null;
        case DisplayNameValidated.TooLong:
          return LocaleKeys.register_displayNameTooLongWarning.translate();
        case DisplayNameValidated.Empty:
          return LocaleKeys.register_displayNameEmptyWarning.translate();
      }
    } else {
      return null;
    }
  }

  Color _colorsDisplayNameBorderBuilder(RegisterState state) {
    if (state is DisplayNameValidatedState) {
      switch (state.displayNameValidated) {
        case DisplayNameValidated.Invalid:
          return Colors.green;
        case DisplayNameValidated.TooLong:
          return Colors.red;
        case DisplayNameValidated.Empty:
          return Colors.blue;
      }
    } else {
      return Colors.blue;
    }
  }

  Color _colorsDisplayNameEnableBorderBuilder(RegisterState state) {
    if (state is DisplayNameValidatedState) {
      switch (state.displayNameValidated) {
        case DisplayNameValidated.Invalid:
          return Colors.green[200] ?? Colors.green;
        case DisplayNameValidated.TooLong:
          return Colors.red[100] ?? Colors.red;
        case DisplayNameValidated.Empty:
          return Theme.of(context).backgroundColor;
      }
    } else {
      return Theme.of(context).backgroundColor;
    }
  }

  Widget _displayNameInput(
      ThemeData theme, RegisterState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _displayNameController,
        onChanged: (value) {
          BlocProvider.of<RegisterBloc>(ctx).add(
            TextingDisplayNameEvent(displayName: value),
          );
        },
        decoration: InputDecoration(
          errorText: _errorDisplayNameWarning(state),
          suffixIcon: Visibility(
            visible: state is DisplayNameValidatedState &&
                !(state.displayNameValidated == DisplayNameValidated.Empty),
            child: GestureDetector(
              onTap: () {
                _displayNameController.clear();
                BlocProvider.of<RegisterBloc>(ctx).add(
                  TextingDisplayNameEvent(displayName: ""),
                );
              },
              child: Icon(
                Icons.highlight_off_outlined,
                color: Colors.grey[600] ?? Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text(LocaleKeys.register_displayNameLabel.translate()),
          hintText: LocaleKeys.register_displayNameHintText.translate(),
          labelStyle: theme.textTheme.headline3,
          contentPadding:
              const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: _colorsDisplayNameBorderBuilder(state)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusColor: _colorsDisplayNameBorderBuilder(state),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsDisplayNameEnableBorderBuilder(state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailInput(ThemeData theme, RegisterState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _emailController,
        onChanged: (value) {
          BlocProvider.of<RegisterBloc>(ctx).add(
            TextingEmailEvent(email: value),
          );
        },
        decoration: InputDecoration(
          errorText: _errorEmailWarning(state),
          suffixIcon: Visibility(
            visible: state is EmailValidatedState &&
                !(state.emailValidatedState == EmailValidated.Empty),
            child: GestureDetector(
              onTap: () {
                _emailController.clear();
                BlocProvider.of<RegisterBloc>(ctx).add(
                  TextingEmailEvent(email: ""),
                );
              },
              child: Icon(
                Icons.highlight_off_outlined,
                color: Colors.grey[600] ?? Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text(LocaleKeys.register_emailLabel.translate()),
          hintText: LocaleKeys.register_emailHintText.translate(),
          labelStyle: theme.textTheme.headline3,
          contentPadding:
              const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _colorsEmailBorderBuilder(state)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusColor: _colorsEmailBorderBuilder(state),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsEmailEnableBorderBuilder(state),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorsPasswordBorderBuilder(RegisterState state) {
    if (state is PasswordValidatedState) {
      switch (state.passwordValidated) {
        case PasswordValidated.Invalid:
          return Colors.green;
        case PasswordValidated.Illegal:
          return Colors.red;
        case PasswordValidated.Empty:
          return Colors.blue;
        case PasswordValidated.Weak:
          return Colors.red;
      }
    } else {
      return Colors.blue;
    }
  }

  Color _colorsPasswordEnableBorderBuilder(RegisterState state) {
    if (state is PasswordValidatedState) {
      switch (state.passwordValidated) {
        case PasswordValidated.Invalid:
          return Colors.green[200] ?? Colors.green;
        case PasswordValidated.Illegal:
          return Colors.red[100] ?? Colors.red;
        case PasswordValidated.Empty:
          return Theme.of(context).backgroundColor;
        case PasswordValidated.Weak:
          return Colors.red[100] ?? Colors.red;
      }
    } else {
      return Theme.of(context).backgroundColor;
    }
  }

  String? _errorPasswordWarning(RegisterState state) {
    if (state is PasswordValidatedState) {
      switch (state.passwordValidated) {
        case PasswordValidated.Invalid:
          return null;
        case PasswordValidated.Illegal:
          return LocaleKeys.register_passwordTooSortMess.translate();
        case PasswordValidated.Empty:
          return LocaleKeys.register_passwordEmptyMess.translate();
        case PasswordValidated.Weak:
          return LocaleKeys.register_passwordTooWeakMess.translate();
      }
    } else {
      return null;
    }
  }

  Widget _passwordInput(
      ThemeData theme, RegisterState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        onChanged: (value) {
          BlocProvider.of<RegisterBloc>(ctx).add(
            TextingPasswordEvent(password: value),
          );
        },
        decoration: InputDecoration(
          errorText: _errorPasswordWarning(state),
          suffixIcon: Visibility(
            visible: state is PasswordValidatedState &&
                state.passwordValidated != PasswordValidated.Empty,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _obscurePassword = !(_obscurePassword);
                });
              },
              child: Icon(
                _obscurePassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[600] ?? Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text(LocaleKeys.register_passwordLabel.translate()),
          hintText: LocaleKeys.register_passwordHintText.translate(),
          labelStyle: theme.textTheme.headline3,
          contentPadding:
              const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsPasswordBorderBuilder(state),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsPasswordEnableBorderBuilder(state),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Color _colorsConfirmPasswordBorderBuilder(RegisterState state) {
    if (state is ConfirmPasswordValidatedState) {
      switch (state.confirmPasswordValidated) {
        case ConfirmPasswordValidated.Correct:
          return Colors.green;
        case ConfirmPasswordValidated.Illegal:
          return Colors.red;
        case ConfirmPasswordValidated.Empty:
          return Colors.blue;
      }
    } else {
      return Colors.blue;
    }
  }

  Color _colorsConfirmPasswordEnableBorderBuilder(RegisterState state) {
    if (state is ConfirmPasswordValidatedState) {
      switch (state.confirmPasswordValidated) {
        case ConfirmPasswordValidated.Correct:
          return Colors.green[200] ?? Colors.green;
        case ConfirmPasswordValidated.Illegal:
          return Colors.red[100] ?? Colors.red;
        case ConfirmPasswordValidated.Empty:
          return Theme.of(context).backgroundColor;
      }
    } else {
      return Theme.of(context).backgroundColor;
    }
  }

  String? _errorConfirmPasswordWarning(RegisterState state) {
    if (state is ConfirmPasswordValidatedState) {
      switch (state.confirmPasswordValidated) {
        case ConfirmPasswordValidated.Correct:
          return null;
        case ConfirmPasswordValidated.Illegal:
          return LocaleKeys.register_confirmPasswordNotMatchMess.translate();
        case ConfirmPasswordValidated.Empty:
          return LocaleKeys.register_requestConfirmPasswordMess.translate();
      }
    } else {
      return null;
    }
  }

  Widget _confirmPasswordInput(
      ThemeData theme, RegisterState state, BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _confirmPasswordController,
        onChanged: (value) {
          BlocProvider.of<RegisterBloc>(ctx).add(
            TextingConfirmPasswordEvent(passwordConfirm: value),
          );
        },
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscureConfirmPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          errorText: _errorConfirmPasswordWarning(state),
          suffixIcon: Visibility(
            visible: state is ConfirmPasswordValidatedState &&
                state.confirmPasswordValidated !=
                    ConfirmPasswordValidated.Empty,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureConfirmPassword = !(_obscureConfirmPassword);
                });
              },
              child: Icon(
                _obscureConfirmPassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[600] ?? Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text(
            LocaleKeys.register_confirmPasswordLabel.translate(),
          ),
          hintText: LocaleKeys.register_confirmPasswordHintText.translate(),
          labelStyle: theme.textTheme.headline3,
          contentPadding:
              const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsConfirmPasswordBorderBuilder(state),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorsConfirmPasswordEnableBorderBuilder(state),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
