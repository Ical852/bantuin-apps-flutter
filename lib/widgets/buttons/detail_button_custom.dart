import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class DetailButtonCustom extends StatelessWidget {

  Color? color;
  String title;
  Widget icon;
  Function() onPressed;

  DetailButtonCustom({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color ?? green1
      ),
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: 16
          )
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: regularWhiteMedium,
            ),
            icon
          ],
        )
      ),
    );
  }
}