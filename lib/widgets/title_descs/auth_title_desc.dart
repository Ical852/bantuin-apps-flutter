import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class AuthTitleDesc extends StatelessWidget {

  String title, desc;
  AuthTitleDesc({
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
              fontSize: 24,
              fontWeight: semiBold,
              color: black1
            ),
          ),
          SizedBox(height: 2,),
          Text(
            desc,
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: light,
              color: grey1
            ),
          )
        ],
      ),
    );
  }
}