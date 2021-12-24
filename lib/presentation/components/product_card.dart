import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muaho/common/common.dart';

import 'image_network_builder.dart';

class ProductCard extends StatelessWidget {
  final ProductStore product;
  final void Function(ProductStore, bool) onSelectedProduct;

  const ProductCard(
      {Key? key, required this.product, required this.onSelectedProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: product.quantity > 0
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
                  product.productPrice.formatDouble(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: product.quantity == 0
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
                ProductStore(
                    quantity: product.quantity + 1,
                    productId: product.productId,
                    productName: product.productName,
                    productPrice: product.productPrice,
                    unit: product.unit,
                    groupId: product.groupId,
                    thumbUrl: product.thumbUrl),
                isIncrease);
          } else {
            if (product.quantity > 0) {
              int newAmount = product.quantity - 1;
              onSelectedProduct(
                  ProductStore(
                      quantity: newAmount,
                      productId: product.productId,
                      productName: product.productName,
                      productPrice: product.productPrice,
                      unit: product.unit,
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
                color: product.quantity > 0
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
      ),
    );
  }
}
