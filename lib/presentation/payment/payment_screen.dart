import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/home/home_screen.dart';

import '../map_example.dart';
import 'bloc/payment_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static final String routeName = "PaymentScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) => getIt()..add(RequestLocationPermission()),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (ctx, state) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: SafeArea(
              child: Scaffold(
                floatingActionButton: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  onPressed: () {
                    BlocProvider.of<PaymentBloc>(ctx).add(CreateOrderEvent());
                  },
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBarComponent(
                  title: "Thanh Toán",
                  backAction: () {
                    Navigator.pop(context);
                  },
                  searchAction: () {},
                ),
                body: BlocListener<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                    if (state is CreateOrderSuccess ||
                        state is CreateOrderFailed) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: MyTheme.backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          title: Text(
                            "Thông báo",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          content: Text(
                            state is CreateOrderSuccess
                                ? "Tạo đơn hàng thành công"
                                : "Tạo Đơn Hàng Thất Bại",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.popUntil(context,
                                    ModalRoute.withName(HomeScreen.routeName));
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: double.infinity,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(top: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: _handleRequestBuilder(state, ctx)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _handleRequestBuilder(PaymentState state, BuildContext ctx) {
    if (state is GetPaymentInfoSuccess) {
      return _paymentBuilder(state, ctx);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _paymentBuilder(GetPaymentInfoSuccess state, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Giao tới địa chỉ",
                    style: Theme.of(ctx).textTheme.headline1,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(ctx,
                          new MaterialPageRoute(builder: (_) => MapSample()));
                    },
                    child: Text(
                      "Chỉnh sửa",
                      style: Theme.of(ctx)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
              Text(state.paymentInfoModel.userInfo.address),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              Column(
                children: state.paymentInfoModel.cartStore.productStores
                    .map((e) => Container(
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  e.productName,
                                  style: Theme.of(ctx)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  e.productPrice.format() +
                                      " x " +
                                      e.quantity.toString(),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Tổng cộng",
                        style: Theme.of(ctx)
                            .textTheme
                            .headline2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        state.paymentInfoModel.total.format(),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
