import 'package:bantuin/widgets/rate_items/star_active_item.dart';
import 'package:bantuin/widgets/rate_items/star_item.dart';
import 'package:flutter/material.dart';

class RateControl extends StatelessWidget {

  int rate;
  Function(int, Function(void Function())) onPress;
  Function(void Function()) setState;
  RateControl({
    required this.rate,
    required this.onPress,
    required this.setState
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 1; i <= rate; i++) 
            StarActiveItem(
              onPressed: (){
                onPress(i, setState);
              },
            ),
          for (int i = 1; i <= 5 - rate; i++)
            StarItem(
              onPressed: (){
                onPress(rate + i, setState);
              },
            )
        ],
      ),
    );
  }
}