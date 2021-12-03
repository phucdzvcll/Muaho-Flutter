import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/shop_detail_bloc.dart';

class ShopScreen extends StatelessWidget {
  static const String routeName = "shop_screen";
  final ShopArgument shopArgument;

  const ShopScreen({Key? key, required this.shopArgument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailBloc()
        ..add(GetShopDetailEvent(shopID: shopArgument.shopIDd)),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              child: BlocBuilder<ShopDetailBloc, ShopDetailState>(
                builder: (ctx, state) {
                  return Center(
                    child: _shopDetailBuilder(state, ctx),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopDetailBuilder(ShopDetailState state, BuildContext ctx) {
    if (state is ShopDetailLoading) {
      return CircularProgressIndicator();
    } else if (state is ShopDetailSuccess) {
      return ListView.builder(
        itemBuilder: (context, index) =>
            Text(state.shopProductEntity.groups[index].groupName),
        itemCount: state.shopProductEntity.groups.length,
      );
    } else {
      return Text("Error");
    }
  }
}

class ShopArgument {
  final int shopIDd;

  ShopArgument({required this.shopIDd});
}
