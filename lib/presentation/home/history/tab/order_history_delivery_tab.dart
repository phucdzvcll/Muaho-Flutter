import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/home/history/bloc/order_history_delivering_bloc.dart';
import 'package:muaho/presentation/home/history/model/order_history_delivering_model.dart';

class OrderHistoryDeliveryTab extends StatefulWidget {
  const OrderHistoryDeliveryTab({Key? key}) : super(key: key);

  @override
  State<OrderHistoryDeliveryTab> createState() =>
      _OrderHistoryDeliveryTabState();
}

class _OrderHistoryDeliveryTabState extends State<OrderHistoryDeliveryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryDeliveringBloc>(
      create: (context) =>
          OrderHistoryDeliveringBloc()..add(GetOrderHistoryDeliveringEvent()),
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
      return Text("Error");
    } else if (state is OrderHistoryDeliveringSuccess) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return _orderHistoryItem(state.orderHistoryDeliveries[index]);
        },
        itemCount: state.orderHistoryDeliveries.length,
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.only(bottom: 70),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _orderHistoryItem(OrderHistoryDeliveringModel historyDelivering) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyTheme.backgroundCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            historyDelivering.shopName,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        historyDelivering.subText,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        historyDelivering.totalPrice,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.location_searching_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
