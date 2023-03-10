import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {

  int price;
  Function() onPress;
  bool active;

  PriceItem({
    required this.price,
    required this.onPress,
    this.active = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: active ? green1 : white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ],
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            rawFormat(price),
            style: poppinsText.copyWith(
              fontSize: 20,
              fontWeight: regular,
              color: active ? white : black1
            ),
          ),
        ),
      ),
    );
  }
}