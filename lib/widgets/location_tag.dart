import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class LocationTag extends StatelessWidget {

  String location;
  bool? small;
  LocationTag({ required this.location, this.small });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ImageCustom(
            height: small != null ? 8.5 : 11,
            width: small != null ? 6 : 8,
            image: AssetImage('assets/icons/ic_location.png'),
          ),
          SizedBox(width: 6,),
          Text(
            location,
            style: small != null ? xSmallGrayRegular : smallGrayRegular
          )
        ],
      ),
    );
  }
}