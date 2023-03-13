import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class MidtransPay extends StatelessWidget {

  bool detail;
  int? total;
  MidtransPay({
    this.detail = false,
    this.total
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20
      ),
      height: 132,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 1)
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail ? 'Bantuin Money + ' + formatter(total!) : 'Payment Method',
            style: detail ? mediumPrimarySemibold : mediumBlackSemibold
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16
            ),
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: grey1
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ImageCustom(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/icons/ic_midtrans.png'),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 12,),
                    Text(
                      'Midtrans Payment',
                      style: regularBlackRegular
                    )
                  ],
                ),
                ImageCustom(
                  height: 7,
                  width: 14,
                  image: AssetImage('assets/icons/ic_chevron_down.png'),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}