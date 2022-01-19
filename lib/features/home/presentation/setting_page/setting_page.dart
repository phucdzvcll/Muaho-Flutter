import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/change_display_name/presentation/dialog.dart';
import 'package:muaho/features/home/presentation/setting_page/bloc/setting_bloc.dart';
import 'package:muaho/features/login/presentation/login_screen.dart';
import 'package:muaho/features/main/bloc/main_bloc.dart';
import 'package:muaho/features/voucher_list/presentaition/voucher_list_screen.dart';
import 'package:muaho/generated/assets.gen.dart';
import 'package:muaho/generated/locale_keys.g.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<SettingBloc>(
      create: (context) => inject()..add(InitSettingEvent()),
      child: Container(
        color: Theme.of(context).cardColor,
        child: SafeArea(
          child: BlocListener<SettingBloc, SettingState>(
            listener: (context, state) {
              if (state is ChangeDisplayNameState) {
                switch (state.changeName) {
                  case ChangeName.success:
                    context.showSnackBar("Thành công");
                    break;
                  case ChangeName.fail:
                    context.showSnackBar("Thất bại");
                    break;
                }
              }
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 92),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 110),
                    child: Column(
                      children: [
                        userInfoBuilder(context),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 35, left: 20, right: 20),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _settingEmailBuilder(context),
                              _itemSettingBuilder(
                                title: LocaleKeys.setting_phoneNumberTitle
                                    .translate(),
                                leadingIcon: Icon(
                                  Icons.phone_iphone_sharp,
                                  color: Colors.blue,
                                ),
                                trailingIcon: Icon(
                                  Icons.navigate_next_sharp,
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                                onPress: () {},
                                underlineWidth: 0.5,
                              ),
                              _itemSettingBuilder(
                                title: LocaleKeys.setting_discountTitle
                                    .translate(),
                                subtitle: LocaleKeys.setting_discountSubtitle
                                    .translate(namedArgs: {
                                  "discount": "8",
                                }),
                                leadingIcon: Icon(
                                  Icons.local_offer,
                                  color: Colors.red,
                                ),
                                trailingIcon: Icon(
                                  Icons.navigate_next_sharp,
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                                onPress: () {
                                  Navigator.of(context)
                                      .pushNamed(VoucherListScreen.routeName);
                                },
                                underlineWidth: 0.5,
                              ),
                              _buildSettingMode(context),
                              _itemSettingBuilder(
                                title: LocaleKeys.setting_languageTitle
                                    .translate(),
                                subtitle: LocaleKeys
                                    .setting_currentLanguageSubtitle
                                    .translate(),
                                leadingIcon: Icon(
                                  Icons.language,
                                  color: Colors.green,
                                ),
                                trailingIcon: Icon(
                                  Icons.navigate_next_sharp,
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                                onPress: () {
                                  _showDialogChangeLanguage(context);
                                },
                                underlineWidth: 0.5,
                              ),
                              BlocBuilder<SettingBloc, SettingState>(
                                buildWhen: (pre, curr) => curr is SignInState,
                                builder: (context, state) {
                                  return Visibility(
                                    visible: state is SignInState &&
                                        state.signIn == SignIn.Logout,
                                    child: _itemSettingBuilder(
                                      title: LocaleKeys
                                          .setting_changePasswordTitle
                                          .translate(),
                                      leadingIcon: Icon(
                                        Icons.change_circle,
                                        color: Colors.brown,
                                      ),
                                      trailingIcon: Icon(
                                        Icons.navigate_next_sharp,
                                        color: Colors.grey[400] ?? Colors.grey,
                                      ),
                                      onPress: () {},
                                      underlineWidth: 0.5,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SettingBloc, SettingState>(
                                buildWhen: (pre, curr) => curr is SignInState,
                                builder: (ctx, state) {
                                  bool isLogin = (state is SignInState &&
                                      state.signIn == SignIn.Login);
                                  return _itemSettingBuilder(
                                    title: isLogin
                                        ? LocaleKeys.setting_loginTitle
                                            .translate()
                                        : LocaleKeys.setting_logoutTitle
                                            .translate(),
                                    leadingIcon: Icon(
                                      isLogin ? Icons.login : Icons.logout,
                                      color: Colors.grey,
                                    ),
                                    trailingIcon: Icon(
                                      Icons.navigate_next_sharp,
                                      color: Colors.grey[400] ?? Colors.grey,
                                    ),
                                    onPress: () {
                                      if (isLogin) {
                                        ctx.navigatorWithRouteName(
                                            LoginScreen.routeName);
                                      } else {
                                        BlocProvider.of<SettingBloc>(ctx)
                                            .add(LogoutEvent());
                                      }
                                    },
                                    underlineWidth: 0,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingMode(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (pre, curr) => curr is ThemeState,
      builder: (context, state) {
        bool status = false;
        if (state is ThemeState) {
          status = state.isDark;
        }
        return _itemSettingBuilder(
          title: LocaleKeys.setting_darkModeTitle.translate(),
          leadingIcon: Icon(
            Icons.nightlight_round,
            color: Theme.of(context).primaryColorLight,
          ),
          trailingIcon: FlutterSwitch(
            value: status,
            width: 40,
            height: 20,
            padding: 0,
            borderRadius: 16,
            activeColor: Theme.of(context).primaryColorLight,
            toggleSize: 18,
            onToggle: (val) {
              BlocProvider.of<MainBloc>(context).add(
                ChangeThemeEvent(),
              );
              BlocProvider.of<SettingBloc>(context).add(
                ChangeSettingThemeEvent(),
              );
            },
          ),
          onPress: () {
            BlocProvider.of<MainBloc>(context).add(
              ChangeThemeEvent(),
            );
            BlocProvider.of<SettingBloc>(context).add(
              ChangeSettingThemeEvent(),
            );
          },
          underlineWidth: 0.5,
        );
      },
    );
  }

  Widget _settingEmailBuilder(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (pre, curr) => curr is EmailState,
      builder: (context, state) {
        return _itemSettingBuilder(
          title: LocaleKeys.setting_emailTitle.translate(),
          leadingIcon: Icon(
            Icons.email_outlined,
            color: Colors.deepOrange,
          ),
          trailingIcon: Icon(
            Icons.navigate_next_sharp,
            color: Colors.grey[400] ?? Colors.grey,
          ),
          subtitle: (state is EmailState && state.email.isNotEmpty)
              ? state.email
              : null,
          onPress: () {},
          underlineWidth: 0.5,
        );
      },
    );
  }

  Future<dynamic> _showDialogChangeLanguage(BuildContext context) async {
    int _value = 1;
    if (inject<AppLocalization>().getCurrentLocale(context).languageCode ==
        'vi') {
      _value = 1;
    } else {
      _value = 2;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          side: BorderSide(
              color: Theme.of(context).primaryColorLight, width: 1.5),
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                LocaleKeys.setting_languageSelectionTitle.translate(),
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.grey,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await inject<AppLocalization>().setLocale(
                  context,
                  Locale("vi"),
                );
                context.pop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _value,
                    activeColor: Theme.of(context).primaryColorLight,
                    onChanged: (int? value) async {
                      await inject<AppLocalization>().setLocale(
                        context,
                        Locale("vi"),
                      );
                      context.pop();
                    },
                  ),
                  Text("Tiếng Việt"),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await inject<AppLocalization>().setLocale(
                  context,
                  Locale("en"),
                );
                context.pop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Radio(
                    value: 2,
                    activeColor: Theme.of(context).primaryColorLight,
                    groupValue: _value,
                    onChanged: (value) async {
                      await inject<AppLocalization>().setLocale(
                        context,
                        Locale("en"),
                      );
                      context.pop();
                    },
                  ),
                  Text("English"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemSettingBuilder({
    required Icon leadingIcon,
    required String title,
    String? subtitle,
    Function()? onPress,
    Widget? trailingIcon,
    double? underlineWidth,
  }) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            height: subtitle != null ? 10 : 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: leadingIcon,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    subtitle != null
                        ? SizedBox(
                            height: 7,
                          )
                        : SizedBox.shrink(),
                    subtitle != null
                        ? Text(
                            subtitle,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              trailingIcon != null
                  ? Expanded(
                      flex: 2,
                      child: trailingIcon,
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: subtitle != null ? 12 : 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: SizedBox(
              width: double.infinity,
              height: underlineWidth ?? 0.5,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Container userInfoBuilder(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: BlocBuilder<SettingBloc, SettingState>(
        buildWhen: (pre, curr) => curr is UserNameState,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200/300'),
                      radius: 39,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                (state is UserNameState &&
                                        state.displayName.isNotEmpty)
                                    ? state.displayName
                                    : "Guest",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  final TextEditingController
                                      _displayNameController =
                                      new TextEditingController();
                                  showDialogChangeDisplayName(
                                      context, _displayNameController);
                                },
                                child: Icon(
                                  Icons.mode_edit,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.images.crownSvgrepoCom.svg(
                              width: 20,
                              height: 20,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Thành viên vàng",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
