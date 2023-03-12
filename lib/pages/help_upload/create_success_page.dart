import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class CreateSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_signup_success.png',
          title: 'Publikasi Berhasil',
          desc: 'Pencarian bantuan kamu telah berhasil dipublikasikan ke publik, tunggu sampai seorang helper datang bantu kamu',
          width: 285,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, '/main');
          },
        ),
      ),
    );
  }
}