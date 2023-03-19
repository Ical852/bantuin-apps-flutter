import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class TotalHelpInsight extends StatelessWidget {

  int totalHelp;
  Function() onPressed;
  TotalHelpInsight({
    required this.totalHelp,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: green1,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ]
      ),
      height: 67,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11
          )
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            ImageCustom(
              width: 45,
              height: 45,
              image: AssetImage('assets/icons/ic_hand_shake_white.png'),
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Bantuan',
                    style: smallWhiteMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2,),
                  Text(
                    '$totalHelp',
                    style: regularWhiteSemibold,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}