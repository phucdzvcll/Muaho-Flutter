import 'package:flutter/material.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/home/history/delivering/order_history_delivery_tab.dart';

import 'complete/order_history_complete_tab.dart';

class HistoryPage extends StatelessWidget {
  static final String routeName = "purchase_screen";

  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 40,
                    child: TabBar(
                      tabs: [
                        Text(LocaleKeys.orderHistory_deliveringTitle
                            .translate()),
                        Text(
                            LocaleKeys.orderHistory_deliveredTitle.translate()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 1.5,
                    color: Color(0xffdadee8),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        OrderHistoryDeliveryTab(),
                        OrderHistoryCompleteTab()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
