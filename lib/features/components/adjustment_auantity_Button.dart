import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdjustmentQuantityButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  const AdjustmentQuantityButton(
      {Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      child: Container(
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).backgroundColor),
            color: color),
        width: 24,
        height: 24,
        child: icon,
      ),
    );
  }
}
