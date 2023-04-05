import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ChatBubbleOther extends StatelessWidget {

  String message, image;
  bool noPadding, network;
  Function()? onLongPress;
  String? nwUrl;
  ChatBubbleOther({
    required this.message,
    required this.image,
    this.noPadding = false,
    this.onLongPress,
    this.network = false,
    this.nwUrl
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.only(
          bottom: noPadding ? 3 : 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ImageCustom(
              height: 34,
              width: 34,
              image: AssetImage(image),
              borderRadius: BorderRadius.circular(50),
              fit: BoxFit.cover,
              margin: EdgeInsets.only(
                right: 12
              ),
              network: network,
              nwUrl: nwUrl,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: screenWidthPercentage(context, 0.6)
              ),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: green1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: noPadding ? Radius.circular(10) : Radius.circular(0)
                )
              ),
              child: Text(
                message,
                style: regularWhiteRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}