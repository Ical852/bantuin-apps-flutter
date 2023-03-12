import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class DrawerTitleDesc extends StatelessWidget {

  String title, desc;
  DrawerTitleDesc({
    required this.title,
    required this.desc
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: mediumBlackSemibold
          ),
          SizedBox(height: 4,),
          Text(
            desc,
            style: smallBlackRegular
          )
        ],
      ),
    );
  }
}