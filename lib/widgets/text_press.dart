import 'package:bantuin/shared/constatns.dart';
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
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: regular,
              color: black1
            ),
          ),
          GestureDetector(
            onTap: onPress,
            child: Text(
              pressText,
              style: poppinsText.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
                color: green1
              ),
            ),
          )
        ],
      ),
    );
  }
}