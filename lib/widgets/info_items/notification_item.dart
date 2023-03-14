import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  String title, desc;
  List<int> date;
  Function() onPressed;
  NotificationItem({
    required this.title,
    required this.desc,
    required this.date,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          bottom: 24,
          right: 15
        ),
        margin: EdgeInsets.only(
          bottom: 20
        ),
        height: 120,
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
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: regularBlackSemibold,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    desc,
                    style: xSmallGrayMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 16,),
            Text(
              getDayMonth(date[0], date[1], date[2]),
              style: xSmallGrayLight,
            )
          ],
        ),
      ),
    );
  }
}