import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/helper_items/rater.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class CustomerReview extends StatelessWidget {

  String image, name, desc;
  int rate;

  CustomerReview({
    required this.image,
    required this.name,
    required this.desc,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            height: 36,
            width: 36,
            image: AssetImage(image),
            borderRadius: BorderRadius.circular(50),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: smallBlackSemibold,
                ),
                SizedBox(height: 6,),
                Text(
                  desc,
                  style: smallGrayRegular.copyWith(
                    fontSize: 11
                  ),
                ),
                SizedBox(height: 12,),
                Rater(rate: rate)
              ],
            ),
          )
        ],
      ),
    );
  }
}