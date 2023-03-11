import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class PaymentKeyValue extends StatelessWidget {

  String keyVal, value;
  PaymentKeyValue({
    required this.keyVal,
    required this.value
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            keyVal,
            style: regularGrayRegular,
          ),
          Text(
            value,
            style: regularBlackSemibold,
          )
        ],
      ),
    );
  }
}