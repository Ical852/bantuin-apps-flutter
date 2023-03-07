import 'package:bantuin/shared/constatns.dart';
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
        style: poppinsText.copyWith(
          fontSize: 10,
          fontWeight: regular,
          color: white
        ),
      ),
    );
  }
}