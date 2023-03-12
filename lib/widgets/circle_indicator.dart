import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class CircleIndicator extends StatelessWidget {

  bool active;
  CircleIndicator({
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: active ? green1 : white,
        borderRadius: BorderRadius.circular(50),
        border: active ? null : Border.all(
          color: grey4,
          width: 2.5
        ),
      ),
      child: Center(
        child: ImageCustom(
          width: 8.3,
          height: 5.8,
          image: AssetImage('assets/icons/ic_check.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}