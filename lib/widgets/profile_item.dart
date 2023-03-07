import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16
      ),
      padding: EdgeInsets.only(
        left: 16,
        top: 12,
        bottom: 12,
        right: 24
      ),
      height: 76,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ],
        borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: grey3,
              borderRadius: BorderRadius.circular(14)
            ),
            child: Center(
              child: ImageCustom(
                height: 20,
                width: 20,
                image: AssetImage('assets/icons/ic_edit.png'),
              ),
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Edit Profile',
                  style: poppinsText.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                    color: black1
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Edit data pribadi anda',
                  style: poppinsText.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                    color: grey1
                  ),
                )
              ],
            ),
          ),
          ImageCustom(
            height: 11.5,
            width: 7.2,
            image: AssetImage('assets/icons/ic_right.png'),
          )
        ],
      ),
    );
  }
}