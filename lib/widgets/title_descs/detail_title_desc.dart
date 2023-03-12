import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class DetailTitleDesc extends StatelessWidget {

  String title, desc;
  DetailTitleDesc({
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
            style: regularBlackSemibold
          ),
          SizedBox(height: 4,),
          Text(
            desc,
            style: smallGrayLight
          )
        ],
      ),
    );
  }
}