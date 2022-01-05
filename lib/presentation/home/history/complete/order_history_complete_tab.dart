import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/home/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/presentation/home/history/models/order_detail_argument.dart';
import 'package:muaho/presentation/home/history/models/order_history_complete_model.dart';

import 'bloc/order_history_complete_bloc.dart';

class OrderHistoryCompleteTab extends StatefulWidget {
  const OrderHistoryCompleteTab({Key? key}) : super(key: key);

  @override
  State<OrderHistoryCompleteTab> createState() =>
      _OrderHistoryCompleteTabState();
}

class _OrderHistoryCompleteTabState extends State<OrderHistoryCompleteTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<OrderHistoryCompleteBloc>(
      create: (context) => getIt()..add(GetOrderHistoryCompleteEvent()),
      child: BlocBuilder<OrderHistoryCompleteBloc, OrderHistoryCompleteState>(
        builder: (context, state) {
          return _handleBuilder(state, context);
        },
      ),
    );
  }

  Widget _handleBuilder(OrderHistoryCompleteState state, BuildContext context) {
    if (state is OrderHistoryCompleteError) {
      return Text(LocaleKeys.orderHistoryDone_error.translate());
    } else if (state is OrderHistoryCompleteSuccess) {
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

  Widget _orderHistoryItem(OrderHistoryCompleteModel historyComplete) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetail.routeName,
            arguments: OrderDetailArgument(orderID: historyComplete.orderID));
      },
      child: Container(
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
              historyComplete.shopName,
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
                          historyComplete.subText,
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
                          historyComplete.totalPrice,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
