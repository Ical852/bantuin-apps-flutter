import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class MainInputCustom extends StatelessWidget {
  String title, hint;
  bool password;
  TextEditingController controller;
  TextInputType inputType;
  Function(String)? onChanged;

  MainInputCustom({
    required this.title, 
    required this.hint,
    this.password = false, 
    required this.controller,
    this.inputType = TextInputType.text,
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
            style: regularBlackRegular
          ),
          SizedBox(height: 6,),
          TextFormField(
            onChanged: onChanged,
            keyboardType: inputType,
            controller: controller,
            obscureText: password,
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
              contentPadding: EdgeInsets.only(
                top: 13,
                bottom: 13,
                left: 21,
                right: 21
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: green1
                ),
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          )
        ],
      ),
    );
  }
}