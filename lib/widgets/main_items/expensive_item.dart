import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/category_tag.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class ExpensiveItem extends StatelessWidget {
  String image, title, category, location;
  int price;
  Function() onPress;

  ExpensiveItem({
    required this.image,
    required this.title,
    required this.category,
    required this.location,
    required this.price,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 280,
        height: 350,
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCustom(
              height: 200,
              width: 256,
              image: AssetImage(image),
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
              margin: EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: mediumBlackSemibold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8,),
                  CategoryTag(title: category)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
                left: 12,
                right: 12
              ),
              child: LocationTag(
                location: location,
              )
            ),
            Container(
              height: 1,
              color: grey2,
              margin: EdgeInsets.only(
                top: 18
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 19,
                left: 12,
                right: 12
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Start from:',
                    style: smallGrayRegular
                  ),
                  Text(
                    formatter(price),
                    style: regularPrimarySemibold
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