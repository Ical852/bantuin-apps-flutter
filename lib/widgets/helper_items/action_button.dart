import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  String type;
  Function() onPressed;

  ActionButton({
    required this.onPressed,
    this.type = 'primary'  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: type == 'danger' ? red1 : green1
      ),
      width: 30,
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.all(0)
        ),
        onPressed: onPressed,
        child: ImageCustom(
          width: type == 'danger' ? 10 : 13,
          height: 10,
          image: AssetImage('assets/icons/' + (type == 'danger' ? 'ic_cross' : 'ic_check_btn') + '.png'),
        ),
      ),
    );
  }
}