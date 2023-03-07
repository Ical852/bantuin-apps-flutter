import 'package:bantuin/shared/constatns.dart';
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
                style: poppinsText.copyWith(
                  fontSize: 24,
                  color: black1,
                  fontWeight: semiBold
                ),
              ),
              SizedBox(height: 8,),
              Text(
                'temukan dan pilih orang yang membutuhkan bantuanmu, sesuaikan kebutuhan bayaran yang ingin kamu dapatkan dari peminta bantuan',
                style: poppinsText.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                  color: grey1
                ),
              ),
              SizedBox(height: 32,),
              MainButtonCustom(
                title: 'Get Started',
                onPressed: (){
                  Navigator.pushNamed(context, '/tutor-guide');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}