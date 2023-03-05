import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class OBHeader extends StatelessWidget {

  Function() onPress;
  OBHeader({required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ImageCustom(
        width: 24,
        height: 24,
        image: AssetImage('assets/icons/ic_back.png'),
      ),
    );
  }
}