import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {

  IconData icon;
  String title;
  Function() onPress;

  NavItem({
    required this.icon,
    required this.title,
    required this.onPress
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              color: grey1,
              size: 26,
            ),
            SizedBox(width: 12,),
            Text(
              title,
              style: regularGraySemibold,
            ),
          ],
        ),
      ),
    );
  }
}