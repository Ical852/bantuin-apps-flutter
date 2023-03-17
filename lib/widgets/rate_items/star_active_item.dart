import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class StarActiveItem extends StatelessWidget {

  Function() onPressed;
  StarActiveItem({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 42,
        height: 42,
        child: ImageCustom(
          width: 42,
          height: 42,
          image: AssetImage('assets/icons/ic_star_active.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
