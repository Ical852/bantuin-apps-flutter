import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ImageCustom(
        width: double.infinity,
        height: double.infinity,
        image: AssetImage('assets/images/bg.png'),
        fit: BoxFit.cover,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 32,
            left: 24,
            right: 24
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Temukan orang yang butuh bantuanmu',
                style: extraBlackSemibold
              ),
              SizedBox(height: 8,),
              Text(
                'temukan dan pilih orang yang membutuhkan bantuanmu, sesuaikan kebutuhan bayaran yang ingin kamu dapatkan dari peminta bantuan',
                style: mediumGrayRegular
              ),
              SizedBox(height: 32,),
              MainButtonCustom(
                title: 'Get Started',
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/tutor-guide', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}