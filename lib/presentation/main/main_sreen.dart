import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/home/home_screen.dart';
import 'package:muaho/presentation/maintenance/maintenance.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';

import 'bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  static final String routeName = "/main-screen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        context.popUtil(routeName);
      },
      child: BlocBuilder<MainBloc, MainState>(
        buildWhen: (pre, curr) => !(curr is ChangeThemeState),
        builder: (context, state) {
          return _buildMainBody(state);
        },
      ),
    );
  }

  Widget _buildMainBody(MainState state) {
    if (state is MaintainingScreenState) {
      return MaintenanceScreen(
        maintenanceArgument:
            MaintenanceArgument(totalMinutes: state.totalMinutes),
      );
    } else if (state is HomeScreenState) {
      return HomeScreen();
    } else {
      return SignIn();
    }
  }
}
