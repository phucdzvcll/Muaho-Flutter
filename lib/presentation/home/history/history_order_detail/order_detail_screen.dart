import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/models/history/order_detail.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/components/cart_over_view.dart';
import 'package:muaho/presentation/components/image_network_builder.dart';
import 'package:muaho/presentation/home/history/models/order_detail_argument.dart';

import 'bloc/order_detail_bloc.dart';

class OrderDetail extends StatefulWidget {
  static final String routeName = "order_detail";

  final OrderDetailArgument argument;

  const OrderDetail({Key? key, required this.argument}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartOverviewController;

  @override
  void initState() {
    super.initState();
    _cartOverviewController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailBloc>(
      create: (ctx) =>
          getIt()..add(GetOrderDetailEvent(orderID: widget.argument.orderID)),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBarComponent.titleOnly(
                    title: LocaleKeys.orderDetail_titleScreen.translate(),
                ),
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
                  child: _handleSuccessState(state, context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _handleSuccessState(OrderDetailState state, BuildContext ctx) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
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
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              _sliverAppBarBuilder(state),
              state is OrderDetailSuccess
                  ? _sliverListProductBuilder(state, ctx)
                  : (state is OrderDetailLoading
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Center(
                            child: Text(LocaleKeys.orderDetail_error.translate()),
                          ),
                        )),
            ],
          ),
        ),
        state is OrderDetailSuccess
            ? Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: FadeInUp(
                  manualTrigger: true,
                  duration: Duration(milliseconds: 400),
                  controller: (controller) =>
                      _cartOverviewController = controller,
                  child: CartOverView(
                    onClick: () {},
                    cartInfo: state.orderDetailSuccessModel.cartInfo,
                    icon: FadeInLeft(
                      delay: Duration(milliseconds: 200),
                      duration: Duration(milliseconds: 1000),
                      child: SvgPicture.asset(
                        "assets/images/delivery_dining_black_24dp.svg",
                        width: 48,
                        height: 48,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }

  SingleChildRenderObjectWidget _sliverListProductBuilder(
      OrderDetailSuccess state, BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 120),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _itemProductDetailBuilder(
                state.orderDetailSuccessModel.entity.products[index], context);
          },
          addAutomaticKeepAlives: true,
          childCount: state.orderDetailSuccessModel.entity.products
              .length, // 1000 list items
        ),
      ),
    );
  }

  Widget _itemProductDetailBuilder(Product product, BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(4),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColorLight, width: 0.7),
                borderRadius: BorderRadius.circular(8)),
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
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (product.price * product.quantity).format() + " " + LocaleKeys.orderDetail_vndCurrency.translate(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _upDownWidget(context, product),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBarBuilder(OrderDetailState state) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 80,
      backgroundColor: Colors.transparent,
      primary: true,
      pinned: true,
      floating: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.fadeTitle],
        background:
            state is OrderDetailSuccess ? _appbarHeaderBuilder(state) : null,
      ),
    );
  }

  Widget _appbarHeaderBuilder(OrderDetailSuccess state) {
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
              state.orderDetailSuccessModel.entity.shopName,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              state.orderDetailSuccessModel.entity.shopAddress,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget _upDownButton(
      {required bool isIncrease, required BuildContext context}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).backgroundColor),
            color: Color(0x9eeae5e1)),
        child: IconButton(
          disabledColor: Colors.white,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.add,
            color: Color(0xffecd1c9),
            size: 16,
          ),
          onPressed: null,
        ),
      ),
    );
  }

  Widget _upDownWidget(BuildContext context, Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _upDownButton(isIncrease: false, context: context),
        Padding(
          padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
          child: Text(
            product.quantity.toString(),
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black),
          ),
        ),
        _upDownButton(isIncrease: true, context: context),
      ],
    );
  }
}
