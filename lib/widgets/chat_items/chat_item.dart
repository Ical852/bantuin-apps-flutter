import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {

  String image, name, text, time;
  int notif;

  ChatItem({
    required this.image,
    required this.name,
    required this.text,
    required this.time,
    this.notif = 0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20
      ),
      child: Column(
        children: [
          Container(
            height: 46,
            child: Row(
              children: [
                ImageCustom(
                  width: 46,
                  height: 46,
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(50),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: poppinsText.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                          color: black1
                        ),
                      ),
                      Text(
                        text,
                        style: poppinsText.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                          color: notif > 0 ? black1 : grey1
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        time,
                        style: poppinsText.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                          color: grey1
                        ),
                      ),
                      Spacer(),
                      notif > 0 ? Container(
                        width: 21,
                        height: 21,
                        decoration: BoxDecoration(
                          color: green1,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(
                          child: Text(
                            notif.toString(),
                            style: poppinsText.copyWith(
                              fontSize: 10,
                              fontWeight: semiBold,
                              color: white
                            ),
                          ),
                        ),
                      ) : SizedBox(),
                      Spacer()
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 1,
            color: grey2,
          )
        ],
      ),
    );
  }
}