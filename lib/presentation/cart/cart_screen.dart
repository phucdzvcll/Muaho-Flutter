import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/adjustment_auantity_Button.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/components/cart_over_view.dart';
import 'package:muaho/presentation/components/image_network_builder.dart';
import 'package:muaho/presentation/payment/payment_screen.dart';

import 'bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static final String routeName = "cart_screen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartOverviewController;

  @override
  void initState() {
    super.initState();
    _cartOverviewController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) =>
          CartBloc(cartStore: getIt.get())..add(RequestCartEvent()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBarComponent(
                searchAction: () {},
                title: "Giỏ hàng",
                backAction: () {
                  Navigator.pop(context);
                }),
            body: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              margin: EdgeInsets.only(top: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(48),
                ),
              ),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (ctx, state) {
                  return _handleStateResult(state, ctx);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleStateResult(CartState state, BuildContext ctx) {
    if (state is CartLoading || state is CartInitial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CartEmpty) {
      return Center(
        child: Text("Không có gì trong giỏ hàng"),
      );
    } else if (state is CartSuccess) {
      return Center(
        child: _handleSuccessBuilder(state, ctx),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  SliverAppBar _sliverAppBarBuilder(CartSuccess state) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 70,
      backgroundColor: Colors.transparent,
      primary: true,
      pinned: true,
      floating: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.fadeTitle],
        background: _appbarHeaderBuilder(state),
      ),
    );
  }

  Widget _appbarHeaderBuilder(CartSuccess state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              state.cartSuccessResult.cartStore.shopName,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              state.cartSuccessResult.cartStore.shopAddress,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  SingleChildRenderObjectWidget _sliverListProductBuilder(
      CartSuccess state, BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 120),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemProductDetailBuilder(
                state.cartSuccessResult.cartStore.productStores[index],
                context);
          },
          addAutomaticKeepAlives: true,
          childCount: state.cartSuccessResult.cartStore.productStores
              .length, // 1000 list items
        ),
      ),
    );
  }

  Widget _itemProductDetailBuilder(
      ProductStore product, BuildContext blocContext) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: blocContext,
                builder: (ctx) => AlertDialog(
                  backgroundColor: MyTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  title: Text(
                    "Xóa sản phẩm",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  content: Text(
                    "Món hàng này sẽ bị xóa khỏi giỏ hàng của bạn",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("Yes"),
                      onPressed: () {
                        var newProduct = product.copyWith(quantity: 0);
                        Navigator.of(blocContext, rootNavigator: true).pop();
                        BlocProvider.of<CartBloc>(blocContext)
                            .add(EditCartEvent(productStore: newProduct));
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                ),
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
            label: 'Xóa',
          ),
        ],
      ),
      child: Container(
        height: 120,
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ImageNetworkBuilder(
                imgUrl: product.thumbUrl,
                isSquare: true,
                width: 120,
                height: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.productName,
                        style: Theme.of(blocContext).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (product.productPrice * product.quantity)
                                .formatDouble() +
                            " Vnd",
                        style: Theme.of(blocContext)
                            .textTheme
                            .headline1!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: product.quantity > 0
                          ? _upDownWidget(blocContext, product)
                          : _upDownButton(
                              context: blocContext,
                              onSelectedProduct: () {
                                var newProduct = product.copyWith(
                                    quantity: product.quantity + 1);
                                BlocProvider.of<CartBloc>(blocContext).add(
                                    EditCartEvent(productStore: newProduct));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Theme.of(blocContext).primaryColorLight,
                                size: 16,
                              ),
                              color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _handleSuccessBuilder(CartSuccess state, BuildContext ctx) {
    bool isVisible = state.cartSuccessResult.cartStore.productStores.length > 0;
    return Stack(
      children: [
        NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              _cartOverviewController.reverse();
              return false;
            } else if (notification is ScrollEndNotification) {
              _cartOverviewController.forward();
              return true;
            }
            return false;
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              _sliverAppBarBuilder(state),
              isVisible
                  ? _sliverListProductBuilder(state, ctx)
                  : SliverToBoxAdapter(
                      child: Center(
                        child: Text("Không có sản phẩm nào trong giỏ"),
                      ),
                    )
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FadeInUp(
              manualTrigger: true,
              duration: Duration(milliseconds: 400),
              controller: (controller) => _cartOverviewController = controller,
              child: CartOverView(
                onClick: () {
                  Navigator.pushNamed(context, PaymentScreen.routeName);
                },
                cartOverViewModel: state.cartSuccessResult.cartOverViewModel,
                icon: FadeInLeft(
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 1000),
                  child: Icon(Icons.payments_outlined,
                      size: 48, color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _upDownButton(
      {required BuildContext context,
      required void onSelectedProduct(),
      required Icon icon,
      required Color color}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => onSelectedProduct(),
        child: AdjustmentQuantityButton(
          icon: icon,
          color: color,
        ),
      ),
    );
  }

  Widget _upDownWidget(BuildContext context, ProductStore productStore) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _upDownButton(
              context: context,
              onSelectedProduct: () {
                var newProduct =
                    productStore.copyWith(quantity: productStore.quantity - 1);
                if (newProduct.quantity == 0) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: MyTheme.backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      title: Text(
                        "Xóa sản phẩm",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      content: Text(
                        "Món hàng này sẽ bị xóa khỏi giỏ hàng của bạn",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text("Yes"),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            BlocProvider.of<CartBloc>(context)
                                .add(EditCartEvent(productStore: newProduct));
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  BlocProvider.of<CartBloc>(context)
                      .add(EditCartEvent(productStore: newProduct));
                }
              },
              icon: Icon(
                Icons.remove,
                color: Theme.of(context).primaryColorLight,
                size: 16,
              ),
              color: productStore.quantity > 0
                  ? Theme.of(context).backgroundColor
                  : Colors.white),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              productStore.quantity.toString(),
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          _upDownButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColorLight,
              size: 16,
            ),
            color: productStore.quantity > 0
                ? Theme.of(context).backgroundColor
                : Colors.white,
            context: context,
            onSelectedProduct: () {
              var newProduct =
                  productStore.copyWith(quantity: productStore.quantity + 1);
              BlocProvider.of<CartBloc>(context)
                  .add(EditCartEvent(productStore: newProduct));
            },
          ),
        ],
      ),
    );
  }
}
