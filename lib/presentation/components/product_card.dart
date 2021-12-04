import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muaho/presentation/order/model/product_model.dart';

import 'image_network_builder.dart';

class ProductCard extends StatelessWidget {
  final OrderProduct product;
  final void Function(OrderProduct, bool) onSelectedProduct;

  const ProductCard(
      {Key? key, required this.product, required this.onSelectedProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: product.amount > 0
            ? Theme.of(context).backgroundColor
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ImageNetworkBuilder(
                    isSquare: true,
                    imgUrl: product.thumbUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text(
                    product.productName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 5,
                ),
              ],
            ),
            Positioned.fill(
              bottom: 45,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  product.price,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: product.amount == 0
                  ? _upDownButton(isIncrease: true, context: context)
                  : _upDownWidget(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _upDownButton(
      {required bool isIncrease, required BuildContext context}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          if (isIncrease) {
            onSelectedProduct(
                OrderProduct(
                    amount: product.amount + 1,
                    productId: product.productId,
                    productName: product.productName,
                    productPrice: product.productPrice,
                    price: product.price,
                    groupId: product.groupId,
                    thumbUrl: product.thumbUrl),
                isIncrease);
          } else {
            if (product.amount > 0) {
              int newAmount = product.amount - 1;
              onSelectedProduct(
                  OrderProduct(
                      amount: newAmount,
                      productId: product.productId,
                      productName: product.productName,
                      productPrice: product.productPrice,
                      price: product.price,
                      groupId: product.groupId,
                      thumbUrl: product.thumbUrl),
                  isIncrease);
            }
          }
        },
        child: Container(
          width: 32,
          height: 32,
          child: Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).backgroundColor),
                color: product.amount > 0
                    ? Colors.white
                    : Theme.of(context).backgroundColor),
            width: 24,
            height: 24,
            child: isIncrease
                ? Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColorLight,
                    size: 16,
                  )
                : Icon(Icons.remove,
                    color: Theme.of(context).primaryColorLight, size: 16),
          ),
        ),
      ),
    );
  }

  Widget _upDownWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _upDownButton(isIncrease: false, context: context),
          Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              product.amount.toString(),
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black),
            ),
          ),
          _upDownButton(isIncrease: true, context: context),
        ],
      ),
    );
  }
}
