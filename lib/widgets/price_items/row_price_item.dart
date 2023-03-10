import 'package:bantuin/widgets/price_items/price_item.dart';
import 'package:flutter/material.dart';

class RowPriceItem extends StatelessWidget {
  int leftPrice, rightPrice;
  bool leftActive, rightActive;
  Function() onLeft, onRight;

  RowPriceItem({
    required this.leftPrice,
    required this.rightPrice,
    this.leftActive = false,
    this.rightActive = false,
    required this.onLeft,
    required this.onRight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 7
      ),
      child: Row(
        children: [
          Expanded(
            child: PriceItem(
              price: leftPrice,
              onPress: onLeft,
              active: leftActive,
            )
          ),
          SizedBox(width: 7,),
          Expanded(
            child: PriceItem(
              price: rightPrice,
              onPress: onRight,
              active: rightActive,
            )
          ),
        ],
      ),
    );
  }
}