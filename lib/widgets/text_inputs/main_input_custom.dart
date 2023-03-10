import 'package:bantuin/shared/constatns.dart';
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
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: regular,
              color: black1
            ),
          ),
          SizedBox(height: 6,),
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