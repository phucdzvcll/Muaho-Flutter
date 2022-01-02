import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static final String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _emailAnimationController;
  late AnimationController _passwordAnimationController;
  late AnimationController _passwordConfirmAnimationController;

  bool obscureText = true;
  bool _isShowVisibilityPasswordIcon = false;
  bool _isShowVisibilityConfirmPasswordIcon = false;
  bool _isShowRemoveEmailInputIcon = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    _emailAnimationController = new AnimationController(vsync: this);
    _passwordAnimationController = new AnimationController(vsync: this);
    _passwordConfirmAnimationController = new AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _emailAnimationController.dispose();
    _passwordAnimationController.dispose();
    _passwordConfirmAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBarComponent(
              widget: SizedBox.shrink(),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _loginBuilder(context),
            ),
          ),
        ));
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
            child: Flash(
              controller: (c) {
                _emailAnimationController = c;
              },
              manualTrigger: true,
              delay: Duration(milliseconds: 900),
              duration: Duration(milliseconds: 300),
              child: _emailInput(theme),
            ),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInRight(
            child: _passwordInput(theme),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          FadeInLeft(
            child: _confirmPasswordInput(theme),
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 700),
          ),
          SizedBox(
            height: 50,
          ),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: _doneBtn(ctx),
          ),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Bạn đã có tài khoản",
                        style: theme.textTheme.bodyText2),
                    TextSpan(
                      text: " đăng nhập ngay",
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
            child: Image.asset(
              "assets/images/logo_square.png",
              width: (MediaQuery.of(context).size.width / 6) * 4,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Khuyến mãi cực hấp dẫn.",
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 26),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Đăng ký ngay!",
              style: theme.textTheme.headline3
                  ?.copyWith(color: theme.primaryColorLight, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doneBtn(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        _emailAnimationController.reset();
        _emailAnimationController.forward();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Center(
          child: Text(
            "Đăng kí",
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

  Widget _emailInput(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        onTap: () {
          log("Tab");
        },
        validator: (value) {
          if (value != null) {
            return 'Please enter some text';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Text("Email"),
            hintText: "muaho@email.com",
            labelStyle: theme.textTheme.headline3,
            contentPadding:
                const EdgeInsets.only(right: 16, left: 8, top: 20, bottom: 20),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black87,
                width: 1,
              ),
            ),
            focusColor: Colors.deepOrange,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            )),
      ),
    );
  }

  Widget _passwordInput(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _passwordController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!_isShowVisibilityPasswordIcon) {
              setState(() {
                _isShowVisibilityPasswordIcon = true;
              });
            }
          } else {
            setState(() {
              _isShowVisibilityPasswordIcon = false;
            });
          }
        },
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: _isShowVisibilityPasswordIcon,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text("Password"),
          hintText: "password",
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
        ),
      ),
    );
  }

  Widget _confirmPasswordInput(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
      width: double.infinity,
      child: TextFormField(
        controller: _confirmPasswordController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!_isShowVisibilityConfirmPasswordIcon) {
              setState(() {
                _isShowVisibilityConfirmPasswordIcon = true;
              });
            }
          } else {
            setState(() {
              _isShowVisibilityConfirmPasswordIcon = false;
            });
          }
        },
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: _isShowVisibilityConfirmPasswordIcon,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Colors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
          label: Text("Confirm password"),
          hintText: "nhập lại password",
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
        ),
      ),
    );
  }
}
