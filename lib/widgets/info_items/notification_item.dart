import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/notification_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  Function() onPressed;
  NotificationModel notif;
  NotificationItem({
    required this.onPressed,
    required this.notif
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
                    notif.title,
                    style: regularBlackSemibold,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    notif.message,
                    style: xSmallGrayMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 16,),
            Text(
              getDayMonth(getDate(notif)['year'], getDate(notif)['month'], getDate(notif)['day']),
              style: xSmallGrayLight,
            )
          ],
        ),
      ),
    );
  }
}