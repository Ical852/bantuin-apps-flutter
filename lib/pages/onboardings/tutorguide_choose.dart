import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/obheader.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class TutorGuideChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 24,
                  top: 24
                ),
                child: OBHeader(
                  onPress: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 32
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/ob-helper1');
                        },
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ImageCustom(
                                width: 250,
                                height: 250,
                                image: AssetImage('assets/illustrations/il_bikeman.png'),
                              ),
                              Text(
                                'Sebagai Helper',
                                style: poppinsText.copyWith(
                                  fontSize: 24,
                                  fontWeight: semiBold,
                                  color: black1
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: grey2,
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/ob-customer1');
                        },
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ImageCustom(
                                width: 250,
                                height: 250,
                                image: AssetImage('assets/illustrations/il_kurir.png'),
                              ),
                              Text(
                                'Sebagai Customer',
                                style: poppinsText.copyWith(
                                  fontSize: 24,
                                  fontWeight: semiBold,
                                  color: black1
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}