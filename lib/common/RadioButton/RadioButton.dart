import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final String title;
  int value;
  int groupValue;
  Function onChance;

  RadioButton(
      {Key? key,
      required this.title,
      required this.onChance,
      required this.value,
      required this.groupValue})
      : super(key: key);

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
