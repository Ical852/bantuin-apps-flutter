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
          Expanded(
            child: Text(
              keyVal,
              style: regularGrayRegular,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 12,),
          Text(
            value,
            style: regularBlackSemibold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}