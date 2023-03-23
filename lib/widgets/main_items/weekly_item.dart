import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/info_items/bantuan_status_tag.dart';
import 'package:bantuin/widgets/location_tag.dart';
import 'package:flutter/material.dart';

class WeeklyItem extends StatelessWidget {
  BantuanModel bantuan;
  Function() onPress;
  bool isMine, isHelper;

  WeeklyItem({
    required this.bantuan,
    required this.onPress,
    this.isMine = false,
    this.isHelper = false,
  });

  String getLocation() {
    return bantuan.location.split('|')[1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(
        bottom: 20
      ),
      height: 170,
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
      child: Stack(
        children: [
          Row(
            children: [
              ImageCustom(
                height: 146,
                width: 100,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12),
                network: true,
                nwUrl: bantuan.image,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationTag(location: getLocation()),
                    SizedBox(height: 4,),
                    Text(
                      bantuan.title,
                      style: regularBlackSemibold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7,),
                    Text(
                      bantuan.desc,
                      style: xSmallGrayRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4,),
                    Text(
                      formatter(bantuan.price),
                      style: regularPrimarySemibold
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [green2, green1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent.withOpacity(0.1),
                        ),
                        onPressed: onPress,
                        child: Text(
                          isMine ? 'Check' : isHelper ? 'Detail' : 'Help',
                          style: xSmallWhiteMedium
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          bantuan.status != 'active' ? Align(
            alignment: Alignment.topRight,
            child: BantuanStatusTag(status: bantuan.status)
          ) : SizedBox()
        ],
      ),
    );
  }
}