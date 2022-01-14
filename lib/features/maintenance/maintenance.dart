import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/generated/assets.gen.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/features/main/bloc/main_bloc.dart';
import 'package:timer_builder/timer_builder.dart';

class MaintenanceScreen extends StatelessWidget {
  final MaintenanceArgument maintenanceArgument;
  final DateTime finishDateTime;

  MaintenanceScreen({Key? key, required this.maintenanceArgument})
      : finishDateTime = DateTime.now()
            .add(Duration(seconds: maintenanceArgument.totalMinutes * 60)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Lottie.asset(
                    Assets.json.maintenanceBackground,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  LocaleKeys.maintenance_label1.translate(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: _buildCountDown(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.maintenance_label2.translate(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      BlocProvider.of<MainBloc>(context)
                          .add(GoToHomeScreenEvent());
                    },
                    child: Center(
                      child: Text(
                        LocaleKeys.maintenance_checkButtonTitle.translate(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TimerBuilder _buildCountDown() {
    return TimerBuilder.periodic(
      Duration(
        seconds: 1,
      ),
      alignment: Duration.zero,
      builder: (context) {
        var now = DateTime.now();
        var reached = now.compareTo(finishDateTime) >= 0;
        Duration remaining = finishDateTime.difference(now);
        return Text(
          !reached
              ? _printDuration(remaining)
              : LocaleKeys.maintenance_messAfterCountDown.translate(),
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
              ),
        );
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class MaintenanceArgument extends Equatable {
  final int totalMinutes;

  const MaintenanceArgument({
    required this.totalMinutes,
  });

  @override
  List<Object?> get props => [totalMinutes];
}
