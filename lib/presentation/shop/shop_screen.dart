import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/components/image_netword_builder.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/shop_detail_bloc.dart';

class ShopScreen extends StatelessWidget {
  static const String routeName = "shop_screen";
  final ShopArgument shopArgument;

  const ShopScreen({Key? key, required this.shopArgument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ShopDetailBloc()
        ..add(GetShopDetailEvent(shopID: shopArgument.shopId)),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: AppBarComponent(title: "Chọn Sản Phẩm"),
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
              child: BlocBuilder<ShopDetailBloc, ShopDetailState>(
                builder: (ctx, state) {
                  return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: _handleStateResult(state, ctx));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleStateResult(ShopDetailState state, BuildContext ctx) {
    if (state is ShopDetailLoading) {
      return CircularProgressIndicator();
    } else if (state is ShopDetailSuccess) {
      return _shopDetailBuilder(state, ctx);
    } else if (state is ShopDetailError) {
      return Text("Error");
    } else {
      return Container();
    }
  }

  Widget _shopDetailBuilder(ShopDetailSuccess state, BuildContext ctx) {
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
        _productBuilder(state.shopDetailModel.currentListProducts)
      ],
    );
  }

  Widget _productGroupBuilder(
      ShopDetailSuccess state, BuildContext blocContext) {
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
                BlocProvider.of<ShopDetailBloc>(blocContext).add(
                    FilterProductEvent(groupID: productGroupEntity.groupId));
              },
              child: Text(
                productGroupEntity.groupName,
                style: Theme.of(ctx).textTheme.subtitle1!.copyWith(
                    color: productGroupEntity.groupId ==
                            state.shopDetailModel.currentIndex
                        ? Colors.white
                        : Colors.black),
              ),
              style: MyTheme.buttonStyleDisableLessImportant.copyWith(
                backgroundColor: productGroupEntity.groupId ==
                        state.shopDetailModel.currentIndex
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

  Widget _productBuilder(List<Product> currentListProducts) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.73,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          itemCount: currentListProducts.length,
          itemBuilder: (ctx, index) {
            return _productCard(currentListProducts[index], ctx);
          },
        ),
      ),
    );
  }

  Widget _productCard(Product product, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColorLight),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ImageNetworkBuilder(
                imgUrl: product.thumbUrl,
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.productName,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.productPrice.formatDouble() + " / " + product.unit,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
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
