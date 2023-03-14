import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ChatBtn extends StatelessWidget {

  bool isDetail;
  Function() onPressed;

  ChatBtn({
    required this.onPressed,
    this.isDetail = false
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDetail ? green8 : white,
        border: isDetail ? Border() : Border.all(
          color: green1,
          width: 1.5
        ),
      ),
      width: 46,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.all(0)
        ),
        onPressed: onPressed,
        child: ImageCustom(
          width: 19.6,
          height: 18.7,
          image: AssetImage('assets/icons/ic_chat_btn.png'),
        ),
      ),
    );
  }
}