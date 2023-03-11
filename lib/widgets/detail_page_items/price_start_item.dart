import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class PriceStartItem extends StatelessWidget {

  int price;
  PriceStartItem({
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 50,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Price starts from',
            style: regularBlackRegular
          ),
          Text(
            formatter(price),
            style: regularPrimarySemibold
          )
        ],
      ),
    );
  }
}