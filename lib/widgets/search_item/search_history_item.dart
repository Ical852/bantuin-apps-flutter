import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class SearchHistoryItem extends StatelessWidget {

  String title;
  Function() onPress, onLongPress;

  SearchHistoryItem({
    required this.title,
    required this.onPress,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24
        ),
        height: 53,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: grey2
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: regularBlackRegular,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}