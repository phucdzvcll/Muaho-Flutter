import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/cart/cart_screen.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/components/cart_over_view.dart';
import 'package:muaho/presentation/components/product_card.dart';
import 'package:muaho/presentation/home/home_page/bloc/home_page_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/order_bloc.dart';
import 'model/order_detail_model.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "shop_screen";
  final ShopArgument shopArgument;

  const OrderScreen({Key? key, required this.shopArgument}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartOverviewController;

  @override
  void initState() {
    super.initState();
    _cartOverviewController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (ctx) => getIt()
        ..add(
          GetShopDetailEvent(shopID: widget.shopArgument.shopId),
        ),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (ctx, state) {
          if (state is WarningRemoveProduct) {
            showDialogWarningRemoveProduct(ctx, state.productID);
          } else if (state is WarningChangeShop) {
            showDialogWarningChangeShop(ctx, state.productStore);
          }
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBarComponent(
                title: "Chọn Sản Phẩm",
                backAction: () {
                  Navigator.pop(context);
                },
                searchAction: () {},
              ),
              body: Container(
                margin: EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (ctx, state) {
                    return Center(child: _handleStateResult(state, ctx));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleStateResult(OrderState state, BuildContext ctx) {
    if (state is OrderLoading) {
      return CircularProgressIndicator();
    } else if (state is OrderSuccess) {
      return Stack(
        children: [
          _shopDetailBuilder(state, ctx),
          cartOverView(ctx, state),
        ],
      );
    } else if (state is OrderError) {
      return Text("Error");
    } else {
      return Container();
    }
  }

  Positioned cartOverView(BuildContext ctx, OrderSuccess state) {
    return Positioned(
      bottom: 20,
      left: 24,
      right: 24,
      child: FadeInUp(
        manualTrigger: true,
        duration: Duration(milliseconds: 400),
        controller: (controller) => _cartOverviewController = controller,
        child: CartOverView(
          onClick: () {
            Navigator.pushNamed(
              ctx,
              CartScreen.routeName,
            ).whenComplete(() {
              BlocProvider.of<OrderBloc>(ctx)
                  .add(GetShopDetailEvent(shopID: widget.shopArgument.shopId));
            });
          },
          cartOverViewModel: state.shopDetailModel.cartOverView,
          icon: FadeInDown(
            delay: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 1000),
            child: Swing(
              delay: Duration(milliseconds: 1400),
              duration: Duration(milliseconds: 1500),
              child: SvgPicture.asset(
                "assets/images/shopping_cart_checkout_black_24dp.svg",
                width: 40,
                height: 40,
                color: Theme.of(ctx).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopDetailBuilder(OrderSuccess state, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shopDetail(state.shopDetailModel.shopName,
            state.shopDetailModel.shopAddress, ctx),
        SizedBox(
          height: 16,
        ),
        _productGroupBuilder(state, ctx),
        _productBuilder(state.shopDetailModel)
      ],
    );
  }

  Widget _productGroupBuilder(OrderSuccess state, BuildContext blocContext) {
    ItemScrollController _controller = ItemScrollController();
    if (state.shopDetailModel.groups.length > 0) {
      return Container(
        width: double.infinity,
        height: 32,
        child: ScrollablePositionedList.separated(
          itemScrollController: _controller,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.shopDetailModel.groups.length,
          itemBuilder: (ctx, index) {
            var productGroupEntity = state.shopDetailModel.groups[index];
            return ElevatedButton(
              onPressed: () {
                _controller.scrollTo(
                    index: index, duration: Duration(milliseconds: 750));
                BlocProvider.of<OrderBloc>(blocContext).add(
                    FilterProductEvent(groupID: productGroupEntity.groupId));
              },
              child: Text(
                productGroupEntity.groupName,
                style: Theme.of(ctx).textTheme.subtitle1!.copyWith(
                    color: productGroupEntity.groupId ==
                            state.shopDetailModel.currentGroupId
                        ? Colors.white
                        : Colors.black),
              ),
              style: MyTheme.buttonStyleDisableLessImportant.copyWith(
                backgroundColor: productGroupEntity.groupId ==
                        state.shopDetailModel.currentGroupId
                    ? MaterialStateProperty.all<Color>(
                        Theme.of(ctx).primaryColorLight)
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 5,
            );
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _productBuilder(OrderDetailModel orderDetailModel) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          print(notification);
          if (notification is ScrollStartNotification) {
            _cartOverviewController.reverse();
            return false;
          } else if (notification is ScrollEndNotification) {
            _cartOverviewController.forward();
            return true;
          }
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: GridView.builder(
            cacheExtent: 0,
            padding: const EdgeInsets.only(
                top: 8.0, left: 12.0, right: 12, bottom: 130),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            itemCount: orderDetailModel.currentListProducts.length,
            itemBuilder: (ctx, index) {
              return _productCard(orderDetailModel.currentListProducts[index],
                  ctx, orderDetailModel.shopID);
            },
          ),
        ),
      ),
    );
  }

  Widget _productCard(ProductStore product, BuildContext context, int shopID) {
    return ProductCard(
      product: product,
      onSelectedAddToCartBtn: () {
        BlocProvider.of<OrderBloc>(context)
            .add(AddToCartEvent(productStore: product, shopID: shopID));
        BlocProvider.of<HomePageBloc>(context).add(ChangeCart());
      },
      onSelectedIncreaseBtn: () {
        BlocProvider.of<OrderBloc>(context)
            .add(AddToCartEvent(productStore: product, shopID: shopID));
        BlocProvider.of<HomePageBloc>(context).add(ChangeCart());
      },
      onSelectedReducedBtn: () {
        BlocProvider.of<OrderBloc>(context).add(ReducedProductEvent(
            productID: product.productId, productQuantity: product.quantity));
        BlocProvider.of<HomePageBloc>(context).add(ChangeCart());
      },
      onTab: () {
        BlocProvider.of<OrderBloc>(context)
            .add(AddToCartEvent(productStore: product, shopID: shopID));
        BlocProvider.of<HomePageBloc>(context).add(ChangeCart());
      },
    );
  }

  Future<dynamic> showDialogWarningChangeShop(
      BuildContext context, ProductStore productStore) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MyTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          "Bạn có muốn đổi cửa hàng?",
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          "Những món bạn chọn ở cửa hàng trước sẽ bị xóa.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<OrderBloc>(context)
                  .add(ChangeShopEvent(productStore: productStore));
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<OrderBloc>(context).add(ReloadEvent());
            },
          )
        ],
      ),
    );
  }
}

Future<dynamic> showDialogWarningRemoveProduct(
    BuildContext context, int productID) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: MyTheme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text(
        "Xóa sản phẩm khỏi giỏ hàng?",
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        "Sản phẩm này sẽ bị xóa khỏi giỏ hàng của bạn!",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            BlocProvider.of<OrderBloc>(context)
                .add(RemoveProductEvent(productID: productID));
          },
        ),
        CupertinoDialogAction(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            BlocProvider.of<OrderBloc>(context).add(ReloadEvent());
          },
        )
      ],
    ),
  );
}

Widget _shopDetail(String shopName, String shopAddress, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 32, left: 16, right: 16),
    child: Align(
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
    ),
  );
}

class ShopArgument {
  final int shopId;

  ShopArgument({required this.shopId});
}
