import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
import 'package:bantuin/widgets/chat_items/chat_btn.dart';
import 'package:bantuin/widgets/helper_items/action_button.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:flutter/material.dart';

class HelperRequestItem extends StatelessWidget {

  BantuanOrderModel order;
  Function() onAccept, onDeny, onChat, onProfile;

  HelperRequestItem({
    required this.order,
    required this.onAccept,
    required this.onDeny,
    required this.onChat,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      margin: EdgeInsets.only(
        bottom: 16
      ),
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
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                ImageCustom(
                  width: 46,
                  height: 46,
                  borderRadius: BorderRadius.circular(50),
                  fit: BoxFit.cover,
                  network: true,
                  nwUrl: order.helper!.user!.image,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.helper!.user!.fullName,
                        style: mediumBlackSemibold,
                      ),
                      Text(
                        'Helper',
                        style: regularGrayLight,
                      )
                    ],
                  ),
                ),
                ActionButton(
                  onPressed: onAccept,
                ),
                SizedBox(width: 12,),
                ActionButton(
                  onPressed: onDeny,
                  type: 'danger',
                )
              ],
            ),
          ),
          Line(),
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                ChatBtn(
                  onPressed: onChat,
                  isDetail: true,
                  size: 43,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: DetailButtonCustom(
                    title: 'Cek Profil',
                    onPressed: onProfile,
                    icon: ImageCustom(
                      width: 16,
                      height: 16.2,
                      image: AssetImage('assets/icons/ic_next.png'),
                    ),
                    size: 43,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}