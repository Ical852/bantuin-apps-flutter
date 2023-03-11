import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 32
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ImageCustom(
                width: 250,
                height: 250,
                image: AssetImage('assets/illustrations/il_welcome.png'),
                margin: EdgeInsets.only(
                  bottom: 100
                ),
              ),
              Text(
                'Selamat datang di aplikasi bantuin!',
                style: extraBlackSemibold
              ),
              SizedBox(height: 8,),
              Text(
                'Selamat datang di aplikasi bantuin, terima kasih telah mendaftarkan akun di aplikasi ini, selamat mencari bantuan dan membantu sesama',
                style: mediumGrayRegular
              ),
              SizedBox(height: 32,),
              MainButtonCustom(
                title: 'Lanjutkan',
                onPressed: (){
                  Navigator.pushNamed(context, '/main');
                },
              ),
            ],
          ),
        ),
      ),      
    );
  }
}