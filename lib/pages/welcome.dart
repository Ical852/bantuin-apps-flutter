import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/buttons/mainbutton_custom.dart';
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
                style: poppinsText.copyWith(
                  fontSize: 24,
                  color: black1,
                  fontWeight: semiBold
                ),
              ),
              SizedBox(height: 8,),
              Text(
                'Selamat datang di aplikasi bantuin, terima kasih telah mendaftarkan akun di aplikasi ini, selamat mencari bantuan dan membantu sesama',
                style: poppinsText.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                  color: grey1
                ),
              ),
              SizedBox(height: 32,),
              MainButtonCustom(
                title: 'Lanjutkan',
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