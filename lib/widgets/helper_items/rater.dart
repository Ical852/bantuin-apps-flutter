import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class Rater extends StatelessWidget {

  int rate;
  Rater({
    required this.rate
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (int i = 1; i <= rate; i ++)
            ImageCustom(
              height: 16,
              width: 16,
              image: AssetImage('assets/icons/ic_star_mini.png'),
              margin: EdgeInsets.only(right: 4),
            )
        ],
      ),
    );
  }
}