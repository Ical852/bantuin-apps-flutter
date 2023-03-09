import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/buttons/mini_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class TextDescButton extends StatelessWidget {

  String image, title, desc, btnTitle;
  Function() onPressed;

  TextDescButton({
    required this.image,
    required this.title,
    required this.desc,
    required this.btnTitle,
    required this.onPressed  
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
            style: poppinsText.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
              color: black1
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 6,
              bottom: 30
            ),
            width: 240,
            child: Text(
              desc,
              style: poppinsText.copyWith(
                fontSize: 14,
                fontWeight: light,
                color: grey1
              ),
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