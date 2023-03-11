import 'package:flutter/material.dart';

class Marginner extends StatelessWidget {

  EdgeInsetsGeometry margin;
  Widget child;

  Marginner({
    required this.child,
    required this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}