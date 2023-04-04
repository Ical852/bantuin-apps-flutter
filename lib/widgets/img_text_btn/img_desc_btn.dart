import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ImgDescBtn extends StatelessWidget {

  String image, desc, title, type;
  bool noBtn;
  Function() onPress;

  ImgDescBtn({
    required this.image,
    required this.desc,
    required this.title,
    required this.onPress,
    this.type = 'primary',
    this.noBtn = false
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ImageCustom(
            height: 180,
            width: 180,
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 25,),
          Text(
            desc,
            style: mediumBlackSemibold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          noBtn ? SizedBox() : MainButtonCustom(
            title: title,
            onPressed: onPress,
            type: type,
          )
        ],
      ),
    );
  }
}