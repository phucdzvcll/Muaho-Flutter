import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
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
          inject(param1: BlocProvider.of<CartUpdateBloc>(context)),
      child: Builder(builder: (context) {
        return _blocListener(context);
      }),
    );
  }

  Widget _blocListener(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is WarningRemoveProduct) {
          showWarningRemoveProductDialog(context, state.productID);
        }
      },
      child: _bodyBuilder(context),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBarComponent.titleOnly(
            title: LocaleKeys.cart_titleScreen.translate(),
          ),
          body: _handleStateResult(),
        ),
      ),
    );
  }

  Widget _handleStateResult() {
    return BlocBuilder<CartUpdateBloc, CartUpdateState>(
      builder: (ctx, state) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          margin: EdgeInsets.only(top: 32),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: state is CartUpdatedState
              ? _handleSuccessBuilder(state, ctx)
              : Center(
                  child: Text(LocaleKeys.cart_noItemMsg.translate()),
                ),
        );
      },
    );
  }

  SliverAppBar _sliverAppBarBuilder() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 70,
      backgroundColor: Colors.transparent,
      primary: true,
      pinned: true,
      floating: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _appbarHeaderBuilder(),
      ),
    );
  }

  Widget _appbarHeaderBuilder() {
    return BlocBuilder<CartUpdateBloc, CartUpdateState>(
      builder: (context, state) {
        return state is CartUpdatedState
            ? Container(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.cartInfo.cartShopInfo.shopName,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.cartInfo.cartShopInfo.shopAddress,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 12),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  SingleChildRenderObjectWidget _sliverListProductBuilder(
      CartUpdatedState state, BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 120),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemProductDetailBuilder(
                state.cartInfo.productStores[index], context);
          },
          addAutomaticKeepAlives: true,
          childCount: state.cartInfo.productStores.length, // 1000 list items
        ),
      ),
    );
  }

  Widget _itemProductDetailBuilder(
      ProductEntity product, BuildContext blocContext) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showWarningRemoveProductDialog(blocContext, product.productId);
            },
            backgroundColor: Colors.red,
            foregroundColor: Theme.of(context).cardColor,
            icon: Icons.delete_forever,
            label: 'Xóa',
          ),
        ],
      ),
      child: Container(
        height: 120,
        margin: EdgeInsets.all(4),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 0.75)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageNetworkBuilder(
                  imgUrl: product.thumbUrl,
                  size: Size.square(120),
                ),
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
                        LocaleKeys.cart_totalAmountLabel.translate(namedArgs: {
                          "totalAmount":
                              (product.productPrice * product.quantity).format()
                        }),
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
                      child: _upDownWidget(blocContext, product),
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

  Widget _handleSuccessBuilder(CartUpdatedState state, BuildContext ctx) {
    bool isVisible = state.cartInfo.productStores.isNotEmpty;
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
              _sliverAppBarBuilder(),
              isVisible
                  ? _sliverListProductBuilder(state, ctx)
                  : SliverToBoxAdapter(
                      child: Center(
                        child: Text(LocaleKeys.cart_noItemMsg.translate()),
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
              child: _cartOverViewBuilder(state),
            ),
          ),
        )
      ],
    );
  }

  Widget _cartOverViewBuilder(CartUpdatedState state) {
    return CartOverView(
      onClick: () {
        Navigator.pushNamed(context, PaymentScreen.routeName);
      },
      cartInfo: state.cartInfo.cartSummary,
      icon: FadeInLeft(
        delay: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 1000),
        child: Icon(Icons.payments_outlined,
            size: 48, color: Theme.of(context).primaryColorLight),
      ),
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

  Widget _upDownWidget(BuildContext context, ProductEntity productEntity) {
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
                BlocProvider.of<CartBloc>(context).add(ReducedProductEvent(
                    productID: productEntity.productId,
                    quantity: productEntity.quantity));
              },
              icon: Icon(
                Icons.remove,
                color: Theme.of(context).primaryColorLight,
                size: 16,
              ),
              color: productEntity.quantity > 0
                  ? Theme.of(context).cardColor
                  : Theme.of(context).backgroundColor),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              productEntity.quantity.toString(),
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
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
            color: productEntity.quantity > 0
                ? Theme.of(context).cardColor
                : Theme.of(context).backgroundColor,
            context: context,
            onSelectedProduct: () {
              BlocProvider.of<CartBloc>(context)
                  .add(IncreaseProductEvent(productStore: productEntity));
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showWarningRemoveProductDialog(
      BuildContext context, int productID) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          LocaleKeys.cart_deleteItemTitle.translate(),
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          LocaleKeys.cart_deleteItemMsg.translate(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(LocaleKeys.cart_yesDeleteItem.translate()),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<CartBloc>(context)
                  .add(RemoveProductEvent(productId: productID));
            },
          ),
          CupertinoDialogAction(
            child: Text(LocaleKeys.cart_noDeleteItem.translate()),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }
}
