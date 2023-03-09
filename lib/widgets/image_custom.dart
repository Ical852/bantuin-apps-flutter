import 'dart:ffi';

import 'package:flutter/material.dart';

class ImageCustom extends StatelessWidget {
  ImageProvider image;
  double width, height;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxFit? fit;
  Widget? child;

  ImageCustom({ 
    required this.image,
    required this.height,
    required this.width,
    this.borderRadius,
    this.padding,
    this.margin,
    this.fit,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: fit
        ),
        borderRadius: borderRadius
      ),
      child: child,
    );
  }
}