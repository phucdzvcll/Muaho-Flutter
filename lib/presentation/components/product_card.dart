import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';

import 'image_netword_builder.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final void Function(int productID, int amount) onSelectedProduct;

  const ProductCard(
      {Key? key, required this.product, required this.onSelectedProduct})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
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
                    imgUrl: widget.product.thumbUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.product.productName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 5,
                ),
                Text(
                  widget.product.price,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Positioned.fill(
              bottom: 10,
              child:
                  amount == 0 ? _upDownButton(isPlus: true) : _upDownWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _upDownButton({required bool isPlus}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          if (isPlus) {
            setState(() {
              amount++;
            });
          } else {
            setState(() {
              if (amount > 0) {
                amount--;
              }
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).primaryColorLight),
              color: Theme.of(context).backgroundColor),
          width: 24,
          height: 24,
          child: isPlus
              ? Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
                  size: 16,
                )
              : Icon(Icons.remove,
                  color: Theme.of(context).primaryColorLight, size: 16),
        ),
      ),
    );
  }

  Widget _upDownWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _upDownButton(isPlus: false),
          Text(
            amount.toString(),
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black),
          ),
          _upDownButton(isPlus: true),
        ],
      ),
    );
  }
}
