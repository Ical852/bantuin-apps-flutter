import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/detail_page_items/payment_key_value.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:flutter/material.dart';

class PaymentSummary extends StatelessWidget {

  List<List<String>> keyVals;
  int total;
  PaymentSummary({
    required this.keyVals,
    required this.total
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      height: 232,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 1)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: mediumBlackSemibold,
          ),
          SizedBox(height: 13,),
          Column(
            children: keyVals.map((value) {
              return PaymentKeyValue(
                keyVal: value[0],
                value: value[1],
              );
            }).toList(),
          ),
          Line(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: mediumBlackMedium,
              ),
              Text(
                formatter(total),
                style: baseBlackSemibold,
              )
            ],
          )
        ],
      ),
    );
  }
}