import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class OBContents extends StatelessWidget {
  String mainBtnTitle, image, title, desc;
  String? secBtnTitle;
  Function() onMainPress;
  Function()? onSecPress;
  bool mainOnly;

  OBContents({
    required this.image,
    required this.title,
    required this.desc,
    required this.onMainPress,
    this.mainOnly = false,
    this.onSecPress,
    required this.mainBtnTitle,
    this.secBtnTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ImageCustom(
            width: 250,
            height: 250,
            image: AssetImage(image),
            margin: EdgeInsets.only(
              bottom: 30
            ),
          ),
          Text(
            title,
            style: extraBlackSemibold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16,),
          Text(
            desc,
            style: mediumGrayRegular,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          MainButtonCustom(
            title: mainBtnTitle,
            onPressed: onMainPress,
          ),
          mainOnly ? Container() : Column(
            children: [
              SizedBox(height: 16,),
              MainButtonCustom(
                title: secBtnTitle!,
                onPressed: onSecPress!,
                type: 'secondary',
              )
            ],
          )
        ],
      ),
    );
  }
}