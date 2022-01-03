import 'package:flutter/material.dart';
import 'package:muaho/common/common.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 92),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
              ),
              Column(
                children: [
                  userInfoBuilder(context),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        _itemSettingBuilder(
                          title: 'Muaho',
                          subtitle: 'Đổi tên',
                          leadingIcon: Icon(
                            Icons.account_circle_sharp,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Số điện thoại',
                          subtitle: '0909909909',
                          leadingIcon: Icon(
                            Icons.phone_iphone_sharp,
                            color: Colors.blue,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Địa chỉ',
                          subtitle: '171/6ter Tôn Thất Thuyết',
                          leadingIcon: Icon(
                            Icons.home_sharp,
                            color: Colors.amber,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Khuyến mãi',
                          subtitle: 'Bạn có 8 mã khuyến mãi',
                          leadingIcon: Icon(
                            Icons.local_offer,
                            color: Colors.red,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Ngôn ngữ',
                          subtitle: 'Tiếng Việt',
                          leadingIcon: Icon(
                            Icons.language,
                            color: Colors.green,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Đổi mật khẩu',
                          leadingIcon: Icon(
                            Icons.change_circle,
                            color: Colors.brown,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0.5,
                        ),
                        _itemSettingBuilder(
                          title: 'Đăng xuất',
                          leadingIcon: Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                          trailingIcon: Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.grey[400] ?? Colors.grey,
                          ),
                          onPress: () {
                            context.showSnackBar("đổi tên");
                          },
                          underlineWidth: 0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemSettingBuilder({
    required Icon leadingIcon,
    required String title,
    String? subtitle,
    Function()? onPress,
    Icon? trailingIcon,
    double? underlineWidth,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
            height: 12,
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
        color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                radius: 40,
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
                        Text(
                          "Tiny Flutter team",
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          child: Icon(
                            Icons.check_circle_sharp,
                            color: Colors.green,
                          ),
                          visible: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Muaho@email.com",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
