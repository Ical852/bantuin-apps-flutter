import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class LocationTag extends StatelessWidget {

  String location;
  LocationTag({ required this.location });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ImageCustom(
            height: 11,
            width: 8,
            image: AssetImage('assets/icons/ic_location.png'),
          ),
          SizedBox(width: 6,),
          Text(
            location,
            style: smallGrayRegular
          )
        ],
      ),
    );
  }
}