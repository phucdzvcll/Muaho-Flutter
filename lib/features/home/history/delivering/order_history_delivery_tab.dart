import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/generated/assets.gen.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/features/components/order_product_builder.dart';
import 'package:muaho/features/home/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/features/home/history/models/order_detail_argument.dart';
import 'package:muaho/features/home/history/models/order_history_delivering_model.dart';

import 'bloc/order_history_delivering_bloc.dart';

class OrderHistoryDeliveryTab extends StatefulWidget {
  const OrderHistoryDeliveryTab({Key? key}) : super(key: key);

  @override
  State<OrderHistoryDeliveryTab> createState() =>
      _OrderHistoryDeliveryTabState();
}

class _OrderHistoryDeliveryTabState extends State<OrderHistoryDeliveryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<OrderHistoryDeliveringBloc>(
      create: (context) => inject()..add(GetOrderHistoryDeliveringEvent()),
      child:
          BlocBuilder<OrderHistoryDeliveringBloc, OrderHistoryDeliveringState>(
        builder: (context, state) {
          return _handleBuilder(state, context);
        },
      ),
    );
  }

  Widget _handleBuilder(
      OrderHistoryDeliveringState state, BuildContext context) {
    if (state is OrderHistoryDeliveringError) {
      return Text(LocaleKeys.orderHistoryDelivering_error.translate());
    } else if (state is OrderHistoryDeliveringSuccess) {
      return state.orderHistoryDeliveries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Lottie.asset(
                    Assets.json.pageEmpty,
                  ),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return _orderHistoryItem(state.orderHistoryDeliveries[index]);
              },
              itemCount: state.orderHistoryDeliveries.length,
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.only(bottom: 170),
            );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _orderHistoryItem(OrderHistoryDeliveringModel historyDelivering) {
    return OrderProductBuilder(
        onClick: () {
          Navigator.pushNamed(context, OrderDetail.routeName,
              arguments:
                  OrderDetailArgument(orderID: historyDelivering.orderID));
        },
        historyDelivering: historyDelivering);
  }

  @override
  bool get wantKeepAlive => true;
}
