import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  String image, title, desc, location;
  int price;
  Function() onPress;

  NewItem({
    required this.image,
    required this.title,
    required this.desc,
    required this.location,
    required this.price,
    required this.onPress
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(
        bottom: 20
      ),
      height: 150,
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
          ImageCustom(
            width: 118,
            height: 118,
            image: AssetImage(image),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationTag(location: location),
                SizedBox(height: 7,),
                Text(
                  title,
                  style: regularBlackSemibold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 7,),
                Text(
                  desc,
                  style: xSmallGrayRegular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatter(price),
                      style: regularPrimarySemibold
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: green1
                      ),
                      width: 58,
                      height: 24,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent.withOpacity(0.1),
                          padding: EdgeInsets.all(0)
                        ),
                        onPressed: onPress,
                        child: Text(
                          'Help',
                          style: xSmallWhiteRegular
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}