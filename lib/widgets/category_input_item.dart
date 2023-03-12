import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/circle_indicator.dart';
import 'package:flutter/material.dart';

class CategoryInputItem extends StatelessWidget {

  String title;
  bool active;
  Function() onPress;
  CategoryInputItem({
    required this.title,
    required this.onPress,
    this.active = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24
        ),
        height: 45,
        color: active ? green7.withOpacity(0.3) : white,
        child: Row(
          children: [
            CircleIndicator(
              active: active,
            ),
            SizedBox(width: 12,),
            Text(
              title,
              style: mediumBlackRegular
            )
          ],
        ),
      ),
    );
  }
}