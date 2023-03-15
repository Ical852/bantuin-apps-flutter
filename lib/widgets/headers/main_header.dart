import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {

  Function() onBack;
  String title;
  Widget? rightContent;
  Function()? onRightPress;

  MainHeader({
    required this.title,
    required this.onBack,
    this.rightContent,
    this.onRightPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            child: ImageCustom(
              height: 24,
              width: 24,
              image: AssetImage('assets/icons/ic_back.png'),
            ),
          ),
          Text(
            title,
            style: regularBlackSemibold
          ),
          GestureDetector(
            onTap: onRightPress,
            child: Container(
              width: 24,
              child: rightContent,
            ),
          )
        ],
      ),
    );
  }
}