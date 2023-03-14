import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {

  bool isActive;
  TextEditingController controller;
  String hint;
  Function() onPressed;
  Function(String) onChanged;

  ChatInput({
    required this.isActive,
    required this.controller,
    required this.hint,
    required this.onPressed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget ActiveButton() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: green1
        ),
        width: 45,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            padding: EdgeInsets.all(0)
          ),
          onPressed: onPressed,
          child: Center(
            child: ImageCustom(
              height: 16,
              width: 19,
              image: AssetImage('assets/icons/ic_send_active.png'),
            ),
          )
        ),
      );
    }

    Widget UnactiveButton() {
      return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: grey5,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: ImageCustom(
            height: 16,
            width: 19,
            image: AssetImage('assets/icons/ic_send.png'),
          ),
        ),
      );
    }
    
    Widget RenderButton() {
      return isActive ? ActiveButton() : UnactiveButton();
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              margin: EdgeInsets.only(
                right: 10
              ),
              decoration: BoxDecoration(
                color: grey5,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                onChanged: onChanged,
                controller: controller,
                style: mediumBlackRegular,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: mediumPrimaryRegular.copyWith(
                    color: green3
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: green3
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: green1
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
              ),
            ),
          ),
          RenderButton()
        ],
      ),
    );
  }
}