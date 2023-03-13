import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/chat_items/chat_btn.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class OwnerItem extends StatelessWidget {
  String ownerImage, title, subTitle;
  Function() onPressed;

  OwnerItem({
    required this.ownerImage,
    required this.title,
    required this.subTitle,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      height: 95,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: grey2
          )
        )
      ),
      child: Row(
        children: [
          ImageCustom(
            height: 46,
            width: 46,
            image: AssetImage(ownerImage),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(50),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: mediumBlackSemibold,
                ),
                Text(
                  subTitle,
                  style: regularGrayLight,
                )
              ],
            ),
          ),
          ChatBtn(
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}