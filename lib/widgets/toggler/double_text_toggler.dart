import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class DoubleTextToggler extends StatelessWidget {

  String left, right, current;
  Function() leftPress, rightPress;

  DoubleTextToggler({
    required this.left,
    required this.right,
    required this.current,
    required this.leftPress,
    required this.rightPress,
  });

  Color getActive(value) {
    return current == value ? green1 : green3;
  }

  TextStyle getStyle(value) {
    return current == value ? regularPrimarySemibold : regularBlackSemibold;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: leftPress,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 14
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: getActive('left'),
                      width: 2
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    left,
                    style: getStyle('left'),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: rightPress,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 14
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: getActive('right'),
                      width: 2
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    right,
                    style: getStyle('right'),
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