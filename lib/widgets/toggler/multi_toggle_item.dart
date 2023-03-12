import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';

class MultiToggleItem extends StatelessWidget {

  String title;
  bool active;
  Function() onPress;

  MultiToggleItem({
    required this.title,
    this.active = false,
    required this.onPress
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 14
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? green1 : green3,
              width: 2
            )
          )
        ),
        child: Text(
          title,
          style: poppinsText.copyWith(
            fontSize: 14,
            fontWeight: semiBold,
            color: active ? green1 : black1
          ),
        ),
      ),
    );
  }
}