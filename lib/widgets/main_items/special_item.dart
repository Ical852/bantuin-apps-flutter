import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/category_tag.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class SpecialItem extends StatelessWidget {
  String image, title, category, location;
  int price;
  Function() onPress;

  SpecialItem({
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
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(
          top: 16,
          bottom: 20,
          right: 16
        ),
        height: 270,
        width: 220,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCustom(
              height: 150,
              width: 188,
              image: AssetImage(image),
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                margin: EdgeInsets.only(
                  right: 10,
                  top: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CategoryTag(title: category)
                  ],
                ),
              ),
            ),
            SizedBox(height: 12,),
            Text(
              title,
              style: regularBlackSemibold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4,),
            LocationTag(location: location),
            Spacer(),
            Text(
              formatter(price),
              style: regularPrimarySemibold
            )
          ],
        ),
      ),
    );
  }
}