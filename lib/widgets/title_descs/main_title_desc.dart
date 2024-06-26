import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class MainTitleDesc extends StatelessWidget {
  String title, desc;

  MainTitleDesc({
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
            style: baseBlackSemibold
          ),
          SizedBox(height: 2,),
          Text(
            desc,
            style: smallGrayLight
          )
        ],
      ),
    );
  }
}