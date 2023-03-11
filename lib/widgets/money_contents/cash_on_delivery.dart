import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class CashOnDelivery extends StatelessWidget {

  int price;
  CashOnDelivery({
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 70,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 1)
          ),
        ],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Bayar:',
                style: regularGrayRegular.copyWith(
                  fontSize: 13
                ),
              ),
              Text(
                formatter(price),
                style: baseBlackSemibold,
              )
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [green2, green1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Text(
                  'Cash',
                  style: regularWhiteMedium,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}