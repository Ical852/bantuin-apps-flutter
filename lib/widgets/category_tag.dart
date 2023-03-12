import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {

  String title;
  CategoryTag({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3
      ),
      decoration: BoxDecoration(
        color: green1,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text(
        title,
        style: xSmallWhiteRegular
      ),
    );
  }
}