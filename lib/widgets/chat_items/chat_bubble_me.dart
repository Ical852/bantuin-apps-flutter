import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class ChatBubbleMe extends StatelessWidget {

  String message;
  bool noPadding;
  Function()? onLongPress;
  ChatBubbleMe({
    required this.message,
    this.noPadding = false,
    this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.only(
          bottom: noPadding ? 3 : 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6
              ),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: green6,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: noPadding ? Radius.circular(10) : Radius.circular(0)
                ),
                border: Border.all(
                  color: green3
                )
              ),
              child: Text(
                message,
                style: regularBlackRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}