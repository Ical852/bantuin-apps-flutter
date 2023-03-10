import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class InputWithButtonCustom extends StatelessWidget {
  String title, hint;
  bool password;
  TextEditingController controller;
  TextInputType inputType;
  Widget iconContent;
  Function() onPress;
  Function(String)? onChanged;

  InputWithButtonCustom({
    required this.title,
    required this.hint,
    this.password = false,
    required this.controller,
    this.inputType = TextInputType.text,
    required this.iconContent,
    required this.onPress,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: regular,
              color: black1
            ),
          ),
          SizedBox(height: 6,),
          Container(
            height: 50,
            child: Stack(
              children: [
                TextFormField(
                  onChanged: onChanged,
                  keyboardType: inputType,
                  controller: controller,
                  obscureText: password,
                  style: poppinsText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                    color: black1
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: poppinsText.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                      color: green3
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green3
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 13,
                      bottom: 13,
                      left: 21,
                      right: 56
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green1
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPress,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 18
                    ),
                    height: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: iconContent,
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}