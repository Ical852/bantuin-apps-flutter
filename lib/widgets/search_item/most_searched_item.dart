import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class MostSearchedItem extends StatelessWidget {

  String title;
  Function() onPress;

  MostSearchedItem({
    required this.title,
    required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 6
        ),
        margin: EdgeInsets.only(
          bottom: 12
        ),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(
            color: grey2
          ),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Text(
          title,
          style: regularBlackRegular,
        ),
      ),
    );
  }
}