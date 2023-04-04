import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {

  Function() onPress;
  BantuanModel bantuan;

  GridItem({
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
        margin: EdgeInsets.symmetric(),
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
            AspectRatio(
              aspectRatio: 157/100,
              child: ImageCustom(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)
                ),
                network: true,
                nwUrl: bantuan.image,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatter(bantuan.price),
                      style: smallPrimarySemibold,
                    ),
                    SizedBox(height: 4,),
                    Expanded(
                      child: Text(
                        bantuan.title,
                        style: xSmallBlackSemibold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    LocationTag(
                      location: getLocation(),
                      small: true,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}