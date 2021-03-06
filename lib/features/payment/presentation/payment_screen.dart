import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/address_info/presentation/address_screen.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/components/app_bar_component.dart';
import 'package:muaho/features/home/presentation/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/features/home/presentation/history/models/order_detail_argument.dart';
import 'package:muaho/features/login/presentation/login_screen.dart';
import 'package:muaho/features/main/main_sreen.dart';
import 'package:muaho/features/payment/domain/models/payment_entity.dart';
import 'package:muaho/generated/locale_keys.g.dart';

import 'bloc/payment_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static final String routeName = "PaymentScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) =>
          inject(param1: BlocProvider.of<CartUpdateBloc>(context))
            ..add(CheckSignInEvent()),
      child: BlocBuilder<CartUpdateBloc, CartUpdateState>(
        builder: (ctx, cartUpdateState) {
          return Builder(
            builder: (context) {
              return Container(
                color: Theme.of(context).cardColor,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Theme.of(context).cardColor,
                    appBar: AppBarComponent.titleOnly(
                      title: LocaleKeys.payment_screenTitle.translate(),
                    ),
                    body: Builder(builder: (context) {
                      return BlocListener<PaymentBloc, PaymentState>(
                        listener: (_, state) {
                          if (state is CreateOrderSuccess) {
                            Navigator.popUntil(context,
                                ModalRoute.withName(MainScreen.routeName));
                            Navigator.pushNamed(
                              context,
                              OrderDetail.routeName,
                              arguments: OrderDetailArgument(
                                orderID: state.orderId,
                              ),
                            );
                          } else if (state is CreatingOrder) {
                            _showDialogResult(context);
                          }
                        },
                        child: Container(
                          height: double.infinity,
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.only(top: 32),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
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
                                                  .productStores.isNotEmpty &&
                                              cartUpdateState
                                                      .cartInfo.addressInfo !=
                                                  null) {
                                            _showNotifyDialog(
                                                ctx, cartUpdateState);
                                          } else {
                                            _snakeBarBuilder(context);
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
                                                LocaleKeys
                                                    .payment_successOrderMsg
                                                    .translate(),
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
                    }),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _snakeBarBuilder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        margin: const EdgeInsets.only(bottom: 100, left: 50, right: 50),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0x85444444),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                LocaleKeys.payment_missingDeliveryAddressMsg.translate(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<dynamic> _showDialogResult(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          LocaleKeys.payment_requestingCreateOrderTitle.translate(),
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.payment_requestingCreateOrderMsg.translate(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showNotifyDialog(
      BuildContext context, CartUpdatedState cartUpdateState) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          LocaleKeys.payment_saveOrderConfirmTitle.translate(),
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          LocaleKeys.payment_saveOrderConfirmMsg.translate(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(LocaleKeys.payment_yesSaveOrder.translate()),
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<PaymentBloc>(context).add(CreateOrderEvent(
                  paymentEntity: PaymentEntity(
                      addressID: cartUpdateState.cartInfo.addressInfo?.id ?? 0,
                      shopID: cartUpdateState.cartInfo.cartShopInfo.shopID,
                      shopAddress:
                          cartUpdateState.cartInfo.cartShopInfo.shopAddress,
                      shopName: cartUpdateState.cartInfo.cartShopInfo.shopName,
                      productEntities:
                          cartUpdateState.cartInfo.productStores)));
            },
          ),
          CupertinoDialogAction(
            child: Text(LocaleKeys.payment_noSaveOrder.translate()),
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
                    LocaleKeys.payment_deliveryAddress.translate(),
                    style: Theme.of(ctx).textTheme.headline1,
                  ),
                  BlocBuilder<PaymentBloc, PaymentState>(
                    buildWhen: (pre, curr) => curr is SignInState,
                    builder: (context, state) {
                      bool isSignIn = state is SignInState && state.isSignIn;
                      return TextButton(
                        onPressed: () {
                          if (isSignIn) {
                            Navigator.pushNamed(ctx, AddressScreen.routeName)
                                .then((value) {
                              if (value != null && value is AddressInfoEntity) {
                                BlocProvider.of<PaymentBloc>(ctx).add(
                                    UpdateAddressEvent(
                                        addressInfoEntity: value));
                              }
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  side: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                                title: Text(
                                  LocaleKeys.payment_dialogLoginTitle
                                      .translate(),
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    LocaleKeys.payment_dialogLoginContent
                                        .translate(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                actions: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    child: GestureDetector(
                                      child: Text(
                                        LocaleKeys.payment_noLoginBtn
                                            .translate(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(fontSize: 16),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      child: Text(
                                        LocaleKeys.payment_yesLoginBtn
                                            .translate(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(fontSize: 16),
                                      ),
                                      onTap: () {
                                        context.pop();
                                        context.navigatorWithRouteName(
                                            LoginScreen.routeName);
                                      },
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          LocaleKeys.payment_editAddress.translate(),
                          style: Theme.of(ctx)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.deepPurpleAccent),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Text(state.cartInfo.addressInfo?.address ?? ''),
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
                        LocaleKeys.payment_total.translate(),
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
