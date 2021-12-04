import 'package:flutter/material.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';

import 'cart/perchase_screen.dart';

class PurchaseScreen extends StatelessWidget {
  static final String routeName = "purchase_screen";

  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PurchaseArgument argument =
        ModalRoute.of(context)!.settings.arguments as PurchaseArgument;
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Container(
                color: Colors.white,
                child: AppBarComponent(title: "Giỏ Hàng Của Bạn"),
              ),
            ),
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
                      indicatorWeight: 0,
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                      indicator: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      tabs: [
                        Container(child: Text("Trong giỏ")),
                        Text("Đang giao"),
                        Text("Đã giao"),
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
                    height: 25,
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CartScreen(
                          argument: argument,
                        ),
                        Container(
                          color: Colors.purple,
                        ),
                        Container(
                          color: Colors.orange,
                        ),
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
