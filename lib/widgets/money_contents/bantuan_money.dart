import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class BantuanMoney extends StatelessWidget {

  int money;
  Function() onPress;

  BantuanMoney({
    required this.money,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      height: 80,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bantuan Money Anda',
                style: regularGrayRegular
              ),
              Text(
                formatter(money),
                style: basePrimarySemibold
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: green5
            ),
            width: 24,
            height: 24,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.1),
                padding: EdgeInsets.all(0)
              ),
              onPressed: onPress,
              child: ImageCustom(
                width: 12,
                height: 12,
                image: AssetImage('assets/icons/ic_plustopup.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}