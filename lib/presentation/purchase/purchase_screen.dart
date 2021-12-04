import 'package:flutter/material.dart';

class PurchaseScreen extends StatefulWidget {
  static final String routeName = "purchase_screen";

  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          indicatorColor: Color(0x00000000),
          labelColor: Color.fromRGBO(4, 2, 46, 1),
          labelStyle: theme.textTheme.headline1,
          unselectedLabelColor: Colors.grey,
          automaticIndicatorColorAdjustment: false,
          controller: tabController,
          tabs: [
            Text('Trong Giỏ'),
            Text('Đang Giao'),
            Text('Đã Giao'),
          ],
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.orange,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
