import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/info_items/status_tag.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {

  String title;
  int price;
  List<int> date;
  bool failed;

  TransactionItem({
    required this.title,
    required this.price,
    required this.date,
    this.failed = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      margin: EdgeInsets.only(
        bottom: 20
      ),
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
                  SizedBox(height: 11,),
                  Text(
                    formatter(price),
                    style: mediumBlackSemibold,
                  ),
                  SizedBox(height: 11,),
                  StatusTag(
                    failed: failed,
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
    );
  }
}