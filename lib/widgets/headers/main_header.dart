import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {

  Function() onBack;
  String title;
  Widget? rightContent;
  Function()? onRihtPress;

  MainHeader({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 24
      ),
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
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
              color: black1
            ),
          ),
          GestureDetector(
            onTap: onRihtPress,
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