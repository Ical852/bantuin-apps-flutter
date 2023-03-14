import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {

  bool failed;
  StatusTag({
    this.failed = false
  });

  @override
  Widget build(BuildContext context) {

    String getIcon() {
      return failed ? "ic_cross" : 'ic_check';
    }
    return Container(
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: failed ? red1 : green1,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: ImageCustom(
                height: failed ? 6.6 : 5,
                width: failed ? 6.6 : 6.6,
                image: AssetImage('assets/icons/' + getIcon()  + '.png'),
              ),
            ),
          ),
          SizedBox(width: 8,),
          Text(
            failed ? 'Failed' : 'Success',
            style: failed ? regularDangerSemibold : regularPrimarySemibold,
          )
        ],
      ),
    );
  }
}