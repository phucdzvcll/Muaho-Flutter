import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/features/change_display_name/presentation/bloc/change_display_name_bloc.dart';

Future<dynamic> showDialogChangeDisplayName(
    BuildContext context, TextEditingController _displayNameController) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        side:
            BorderSide(color: Theme.of(context).primaryColorLight, width: 1.5),
      ),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Đổi tên hiển thị",
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
      content: BlocProvider<ChangeDisplayNameBloc>(
        create: (ct) => GetIt.instance.get(),
        child: SingleChildScrollView(
          child: Builder(builder: (ctx) {
            return BlocListener<ChangeDisplayNameBloc, ChangeDisplayNameState>(
              listener: (context, state) {
                if (state is ChangeNameState) {
                  Navigator.pop(context);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<ChangeDisplayNameBloc, ChangeDisplayNameState>(
                    buildWhen: (pre, curr) => curr is ChangeNameState,
                    builder: (context, state) {
                      String? textError;
                      if (state is ChangeNameState &&
                          state.displayNameState == DisplayNameState.Empty) {
                        textError = "Không được để trống";
                      }
                      return _buildNameInput(Theme.of(ctx), ctx, textError,
                          _displayNameController);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (ct) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<ChangeDisplayNameBloc>(ct).add(
                            ChangeNameEvent(
                                displayName: _displayNameController.text));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Đổi tên",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                  color: Theme.of(context).backgroundColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Widget _buildNameInput(ThemeData theme, BuildContext ctx, String? errorText,
    TextEditingController displayNameController) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(ctx).backgroundColor,
        borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
    width: double.infinity,
    child: TextFormField(
      controller: displayNameController,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: Text("Tên Hiển Thị"),
        hintText: "Muaho",
        labelStyle: theme.textTheme.headline3,
        isCollapsed: true,
        errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColorLight,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.cardColor,
            width: 1.0,
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
      ),
    ),
  );
}
