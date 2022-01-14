import 'package:flutter/material.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/generated/locale_keys.g.dart';

class CartOverView extends StatelessWidget {
  final VoidCallback onClick;
  final CartSummary cartInfo;
  final Widget icon;
  const CartOverView(
      {Key? key,
      required this.onClick,
      required this.cartInfo,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: double.infinity,
          height: 90,
          color: Theme.of(context).primaryColorLight,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.cartOverView_productQuantityLabel.translate(namedArgs: {
                          "itemQuantity" : cartInfo.itemQuantity.format(),
                          "unitQuantity" : cartInfo.unitQuantity.format(),
                        }),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        LocaleKeys.cartOverView_totalAmountLabel.translate(namedArgs: {
                          "totalAmount" : cartInfo.totalAmount.format(),
                        }),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: icon,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
