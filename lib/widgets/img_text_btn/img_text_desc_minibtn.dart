import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/mini_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ImgTextDescMiniButton extends StatelessWidget {

  String image, title, desc, btnTitle;
  Function() onPressed;
  double? width;

  ImgTextDescMiniButton({
    required this.image,
    required this.title,
    required this.desc,
    required this.btnTitle,
    required this.onPressed,
    this.width  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageCustom(
            height: 250,
            width: 250,
            image: AssetImage(image),
            margin: EdgeInsets.only(
              bottom: 20
            ),
          ),
          Text(
            title,
            style: megaBlackSemibold
          ),
          Container(
            margin: EdgeInsets.only(
              top: 6,
              bottom: 30
            ),
            width: width ?? 240,
            child: Text(
              desc,
              style: regularGrayLight,
              textAlign: TextAlign.center,
            ),
          ),
          MiniButtonCustom(
            title: btnTitle,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}