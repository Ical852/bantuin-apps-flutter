import 'package:bantuin/shared/constatns.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

String formatter(int number) {
  var formatted = intl.NumberFormat.decimalPattern().format(number);

  return 'IDR. ' + formatted.replaceAll(',', '.');
}

void showGLobalAlert(type, text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
    content: Text(
      text,
      style: poppinsText.copyWith(fontSize: 14, color: white, fontWeight: bold),
      textAlign: TextAlign.center,
    ),
    backgroundColor: type == 'danger' ? red1 : Color(0xff27BD48),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
  ));
}