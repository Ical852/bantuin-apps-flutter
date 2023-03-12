import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 157/100,
            child: ImageCustom(
              width: double.infinity,
              height: double.infinity,
              image: AssetImage('assets/dummies/dummy13.png'),
              fit: BoxFit.cover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              ),
            ),
          ),
        ],
      ),
    );
  }
}