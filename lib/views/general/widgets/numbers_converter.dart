import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumbersConverter extends StatelessWidget {
  const NumbersConverter(
      {super.key,
      this.number = 0,
      this.size = 16.0,
      this.color = Colors.black});
  final int number;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      number < 999
          ? double.parse(NumberFormat.compactCurrency(
              decimalDigits: 2,
              symbol: '',
            ).format(number))
              .toStringAsFixed(0)
          : NumberFormat.compactCurrency(
              decimalDigits: 2,
              symbol: '',
            ).format(number),
      style:
          TextStyle(fontWeight: FontWeight.w400, fontSize: size, color: color),
    );
  }
}
