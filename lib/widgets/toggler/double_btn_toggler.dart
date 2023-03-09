import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class DoubleBtnToggler extends StatelessWidget {
  String current, left, right;
  Function() leftPress, rightPress;

  DoubleBtnToggler({
    required this.current,
    required this.left,
    required this.right,
    required this.leftPress,
    required this.rightPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 40,
      decoration: BoxDecoration(
        color: green6,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: grey2
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: leftPress,
              child: Container(
                decoration: BoxDecoration(
                    color: current == 'left' ? green1 : green6,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    left,
                    style: poppinsText.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                        color: current == 'left' ? white : black1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: rightPress,
              child: Container(
                decoration: BoxDecoration(
                    color: current == 'right' ? green1 : green6,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    right,
                    style: poppinsText.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                        color: current == 'right' ? white : black1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}