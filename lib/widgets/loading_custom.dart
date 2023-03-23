import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class LoadingCustom extends StatelessWidget {
  String title;
  bool isWhite;

  LoadingCustom({
    required this.title,
    this.isWhite = false
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: isWhite ? white : green1,
          ),
          SizedBox(height: 12,),
          Text(
            title,
            style: isWhite ? baseWhiteSemibold : basePrimarySemibold,
          )
        ],
      ),
    );
  }
}