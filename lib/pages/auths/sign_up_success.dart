import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class SignUpSuccessPage extends StatefulWidget {
  @override
  State<SignUpSuccessPage> createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_signup_success.png',
          title: 'Pendaftaran Berhasil',
          desc: 'Kami mengirim link verifikasi ke email kamu, cek email kamu untuk melakukan verifikasi akun yg kamu daftarkan',
          btnTitle: 'Cek Email',
          onPressed: (){
            Navigator.pushNamed(context, '/sign-in');
          },
        ),
      ),
    );
  }
}