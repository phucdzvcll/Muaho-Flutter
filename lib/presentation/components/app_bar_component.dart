import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final Widget widget;
  final Function()? backAction;
  final List<IconButton>? actions;

  const AppBarComponent(
      {Key? key, required this.widget, this.backAction, this.actions})
      : super(key: key);

  AppBarComponent.titleOnly({
    Key? key,
    required String title,
    this.backAction,
    this.actions,
  })  : this.widget = _buildDefaultTitle(title),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).backgroundColor, width: 1)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.navigate_before,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (backAction != null) {
                        backAction?.call();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: widget,
              ),
              SizedBox(
                width: 10,
              ),
              actions != null
                  ? Row(
                      children: actions!
                          .map(
                            (e) => Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context).backgroundColor,
                                      width: 1)),
                              child: e,
                            ),
                          )
                          .toList())
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);

  static Widget _buildDefaultTitle(String title) {
    return Builder(builder: (context) {
      return Center(
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      );
    });
  }
}
