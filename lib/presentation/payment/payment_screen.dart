import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/models/payment/payment_entity.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/home/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/presentation/home/history/models/order_detail_argument.dart';
import 'package:muaho/presentation/home/home_screen.dart';

import 'bloc/payment_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static final String routeName = "PaymentScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) =>
          getIt(param1: BlocProvider.of<CartUpdateBloc>(context)),
      child: BlocBuilder<CartUpdateBloc, CartUpdateState>(
        builder: (ctx, cartUpdateState) {
          return Builder(builder: (context) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  appBar: AppBarComponent.titleOnly(
                    title: "Thanh Toán",
                  ),
                  body: BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (ctx, state) {
                      return BlocListener<PaymentBloc, PaymentState>(
                        listener: (_, state) {
                          if (state is CreateOrderSuccess ||
                              state is CreateOrderFailed) {
                            _showDialogResult(ctx, state);
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
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child:
                                    _handleRequestBuilder(cartUpdateState, ctx),
                                padding: const EdgeInsets.only(bottom: 60),
                              ),
                              cartUpdateState is CartUpdatedState
                                  ? Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (cartUpdateState.cartInfo
                                              .productStores.isNotEmpty) {
                                            _showNotifyDialog(
                                                ctx, cartUpdateState);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  height: 35,
                                                  child: Center(
                                                    child: Text(
                                                      "Không có sản phẩm nào trong giỏ hàng!",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 2000),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Hoàn tất đặt hàng",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Future<dynamic> _showDialogResult(
      BuildContext context, PaymentState state) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MyTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          "Thông báo",
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          state is CreateOrderSuccess
              ? "Tạo đơn hàng thành công"
              : "Tạo Đơn Hàng thất bại",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(HomeScreen.routeName));
              if (state is CreateOrderSuccess) {
                Navigator.pushNamed(
                  context,
                  OrderDetail.routeName,
                  arguments: OrderDetailArgument(
                    orderID: state.orderId,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showNotifyDialog(
      BuildContext context, CartUpdatedState cartUpdateState) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MyTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          "Thông báo",
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          "Đơn hàng sẽ được gửi đi!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<PaymentBloc>(context).add(CreateOrderEvent(
                  paymentEntity: PaymentEntity(
                      shopID: cartUpdateState.cartInfo.cartShopInfo.shopID,
                      shopAddress:
                          cartUpdateState.cartInfo.cartShopInfo.shopAddress,
                      shopName: cartUpdateState.cartInfo.cartShopInfo.shopName,
                      productEntities:
                          cartUpdateState.cartInfo.productStores)));
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _handleRequestBuilder(CartUpdateState state, BuildContext ctx) {
    if (state is CartUpdatedState) {
      return _paymentBuilder(state, ctx);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _paymentBuilder(CartUpdatedState state, BuildContext ctx) {
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
                    onPressed: () {},
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
              //todo setup feature user address
              Text(""),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                width: double.infinity,
                height: 0.5,
                color: Colors.grey,
              ),
              Column(
                children: state.cartInfo.productStores
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
                        state.cartInfo.cartSummary.totalAmount.format(),
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
