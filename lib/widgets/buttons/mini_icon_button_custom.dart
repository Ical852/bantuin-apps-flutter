import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class MiniIconButtonCustom extends StatelessWidget {

  Function() onPressed;
  String icons;
  double width, height;

  MiniIconButtonCustom({
    required this.onPressed,
    required this.width,
    required this.height,
    required this.icons
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: green4
      ),
      width: 26,
      height: 26,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.all(0)
        ),
        onPressed: onPressed,
        child: ImageCustom(
          width: width,
          height: height,
          image: AssetImage(icons),
        ),
      ),
    );
  }
}