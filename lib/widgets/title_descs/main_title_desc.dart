import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class MainTitleDesc extends StatelessWidget {
  String title;
  String desc;

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
            style: poppinsText.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
              color: black1
            ),
          ),
          SizedBox(height: 2,),
          Text(
            desc,
            style: poppinsText.copyWith(
              fontSize: 12,
              fontWeight: light,
              color: grey1
            ),
          )
        ],
      ),
    );
  }
}