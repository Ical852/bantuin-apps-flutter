import 'package:bantuin/widgets/textdescbtn.dart';
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
        child: TextDescButton(
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