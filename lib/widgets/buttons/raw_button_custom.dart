import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class RawButtonCustom extends StatelessWidget {

  Color? color;
  double? width, height;
  Function() onPress;
  Widget? child;
  String? title;

  RawButtonCustom({
    required this.onPress,
    this.child,
    this.color,
    this.width,
    this.height,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? green1
      ),
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
        ),
        onPressed: onPress,
        child: child != null ? child : Text(
          title!,
          style: poppinsText.copyWith(
            fontSize: 14,
            fontWeight: medium
          ),
        ),
      ),
    );
  }
}