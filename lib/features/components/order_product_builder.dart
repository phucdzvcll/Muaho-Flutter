import 'package:flutter/material.dart';
import 'package:muaho/features/home/presentation/history/models/order_history_delivering_model.dart';

class OrderProductBuilder extends StatelessWidget {
  final Function onClick;
  final OrderHistoryDeliveringModel historyDelivering;

  const OrderProductBuilder(
      {Key? key, required this.onClick, required this.historyDelivering})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor, width: 0.5),
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
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8),
                //     child: Container(
                //       width: 45,
                //       height: 45,
                //       decoration: BoxDecoration(
                //           color: Theme.of(context).primaryColorLight,
                //           borderRadius: BorderRadius.circular(8)),
                //       child: Icon(
                //         Icons.location_searching_outlined,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
