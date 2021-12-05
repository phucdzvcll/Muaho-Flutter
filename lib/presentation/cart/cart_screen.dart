import 'package:flutter/material.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/order/model/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key, PurchaseArgument? argument}) : super(key: key);
  static final String routeName = "cart_screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarComponent(
              searchAction: () {},
              title: "Giở hàng",
              backAction: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                _shopDetail(
                    "argument!.shopName", "argument!.shopAddress", context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopDetail(
      String shopName, String shopAddress, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shopName,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              shopAddress,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

class PurchaseArgument {
  final String shopName;
  final String shopAddress;
  final List<OrderProduct> products;

  PurchaseArgument(
      {required this.shopName,
      required this.shopAddress,
      required this.products});
}
