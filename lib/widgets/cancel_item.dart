import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class CancelItem extends StatelessWidget {

  String text;
  Function() onPressed;
  bool selected;

  CancelItem({
    required this.text,
    required this.onPressed,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(
        bottom: 12
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: selected ? green1 : grey6,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: 12
          )
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: selected ? smallWhiteMedium : smallBlackMedium
        ),
      ),
    );
  }
}