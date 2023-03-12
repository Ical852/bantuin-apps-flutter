import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class TextPress extends StatelessWidget {

  String text, pressText;
  Function() onPress;

  TextPress({
    required this.text,
    required this.pressText,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: regularBlackRegular
          ),
          GestureDetector(
            onTap: onPress,
            child: Text(
              pressText,
              style: regularPrimarySemibold
            ),
          )
        ],
      ),
    );
  }
}