import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class MainButtonCustom extends StatelessWidget {

  Function() onPressed;
  String title;
  String? type;
  bool disabled;

  MainButtonCustom({
    required this.onPressed,
    required this.title,
    this.type,
    this.disabled = false 
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.3 : 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: type == 'secondary' ? [yellow2, yellow1] : type == 'danger' ? [red2, red1] : [green2, green1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
          ),
          onPressed: disabled ? (){} : onPressed,
          child: Text(
            title,
            style: mediumWhiteMedium
          ),
        ),
      ),
    );
  }
}