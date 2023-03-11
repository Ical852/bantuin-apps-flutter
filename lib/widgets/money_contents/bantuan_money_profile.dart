import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class BantuanMoneyProfile extends StatelessWidget {

  String name, phone;
  int price;
  int? minus;
  int? plus;

  BantuanMoneyProfile({
    required this.name,
    required this.phone,
    required this.price,
    this.minus,
    this.plus
  });

  Widget RenderPrice() {
    return Row(
      children: [
        Text(
          formatter(price),
          style: basePrimarySemibold
        ),
        minus != null ? 
        Text(
          ' - ' + rawFormat(minus!),
          style: baseDangerSemibold
        )
        : SizedBox(),
        plus != null ? 
        Text(
          ' + ' + rawFormat(plus!),
          style: basePrimarySemibold
        )
        : SizedBox()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 147,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          ),
        ],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: minus != null && minus! > price ? 0.3 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: green1,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: ImageCustom(
                          height: 32,
                          width: 27,
                          image: AssetImage('assets/icons/ic_up.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: regularBlackSemibold
                        ),
                        Text(
                          phone,
                          style: regularBlackSemibold
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Text(
                  'Bantuin Money Anda',
                  style: smallGrayRegular
                ),
                Spacer(),
                RenderPrice()
              ],
            ),
          ),
          minus != null && minus! > price ?
          Center(
            child: Text(
              'Not Enough Bantuin Money !',
              style: baseDangerSemibold
            ),
          )
          :
          SizedBox()
        ], 
      ),
    );
  }
}