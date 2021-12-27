import 'package:flutter/material.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';

import 'image_network_builder.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onSelectedIncreaseBtn;
  final VoidCallback onSelectedReducedBtn;
  final VoidCallback onSelectedAddToCartBtn;
  final VoidCallback onTab;

  const ProductCard(
      {Key? key,
      required this.product,
      required this.onSelectedIncreaseBtn,
      required this.onSelectedReducedBtn,
      required this.onSelectedAddToCartBtn,
      required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
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
                      imgUrl: product.thumbUrl,
                      size: Size.square(50),
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
                    product.productPrice.format(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 10,
                child: product.quantity == 0
                    ? _upDownButton(
                        isIncrease: true,
                        context: context,
                        onClick: onSelectedAddToCartBtn)
                    : _upDownWidget(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _upDownButton(
      {required bool isIncrease,
      required BuildContext context,
      required VoidCallback onClick}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onClick,
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
          _upDownButton(
              isIncrease: false,
              context: context,
              onClick: this.onSelectedReducedBtn),
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
          _upDownButton(
              isIncrease: true,
              context: context,
              onClick: this.onSelectedIncreaseBtn),
        ],
      ),
    );
  }
}
