import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/category_tag.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class ExpensiveItem extends StatelessWidget {
  BantuanModel bantuan;
  Function() onPress;

  ExpensiveItem({
    required this.onPress,
    required this.bantuan
  });

  String getLocation() {
    return bantuan.location.split('|')[1];
  }

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
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
              margin: EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12
              ),
              network: true,
              nwUrl: bantuan.image,
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
                      bantuan.title,
                      style: mediumBlackSemibold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8,),
                  CategoryTag(title: bantuan.bantuanCategory!.name)
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
                location: getLocation(),
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
                    formatter(bantuan.price),
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