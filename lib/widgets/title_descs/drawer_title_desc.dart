import 'package:bantuin/shared/constatns.dart';
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
            style: poppinsText.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
              color: black1
            ),
          ),
          SizedBox(height: 4,),
          Text(
            desc,
            style: poppinsText.copyWith(
              fontSize: 12,
              fontWeight: regular,
              color: black1
            ),
          )
        ],
      ),
    );
  }
}