import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muaho/generated/assets.gen.dart';
import 'package:timer_builder/timer_builder.dart';

class MaintenanceScreen extends StatelessWidget {
  final int totalMinute;
  final DateTime alert;

  MaintenanceScreen({Key? key, required this.totalMinute})
      : alert = DateTime.now().add(Duration(seconds: totalMinute * 60)),
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
                  "Chúng tôi hiện đang bảo trì",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                TimerBuilder.scheduled([alert], builder: (context) {
                  var now = DateTime.now();
                  var reached = now.compareTo(alert) >= 0;
                  return Center(
                    child: TimerBuilder.periodic(
                      Duration(
                        seconds: 1,
                      ),
                      alignment: Duration.zero,
                      builder: (context) {
                        DateTime now = DateTime.now();
                        Duration remaining = alert.difference(now);
                        return Text(
                          !reached
                              ? _printDuration(remaining)
                              : "Sắp xong rồi, bạn đới chút nhé",
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Bạn đừng lo lắng, chúng tôi sẽ xong sớm thôi!",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
