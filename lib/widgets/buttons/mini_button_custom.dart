import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class MiniButtonCustom extends StatelessWidget {

  String title;
  Function() onPressed;

  MiniButtonCustom({
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: green1
      ),
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: mediumWhiteMedium
        ),
      ),
    );
  }
}