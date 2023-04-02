import 'dart:ffi';

import 'package:bantuin/shared/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCustom extends StatelessWidget {
  ImageProvider? image;
  double width, height;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxFit? fit;
  Widget? child;
  bool network;
  String? nwUrl;

  ImageCustom({ 
    this.image,
    required this.height,
    required this.width,
    this.borderRadius,
    this.padding,
    this.margin,
    this.fit,
    this.child,
    this.network = false,
    this.nwUrl
  });

  @override
  Widget build(BuildContext context) {
    if (network) {
      return CachedNetworkImage(
        imageUrl: nwUrl!,
        imageBuilder: (BuildContext context, ImageProvider imageProvider) {
          return Container(
            margin: margin,
            padding: padding,
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit
              ),
              borderRadius: borderRadius
            ),
          );
        },
        placeholder: (context, url) => CircularProgressIndicator(
          color: green1,
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          child: Icon(Icons.error),
        ),
      );
    }
    
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image!,
          fit: fit
        ),
        borderRadius: borderRadius
      ),
      child: child,
    );
  }
}