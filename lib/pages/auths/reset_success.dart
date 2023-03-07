import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/text_desc_btn.dart';
import 'package:flutter/material.dart';

class ResetSuccessPage extends StatefulWidget {
  @override
  State<ResetSuccessPage> createState() => _ResetSuccessPageState();
}

class _ResetSuccessPageState extends State<ResetSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: TextDescButton(
          image: 'assets/illustrations/il_reset_success.png',
          title: 'Berhasil Mengirim ke Email',
          desc: 'Kami mengirim link reset untuk memperbarui password kamu, tunggu beberapa saat kemudian',
          btnTitle: 'Kembali',
          onPressed: (){
            Navigator.pushNamed(context, '/sign-in');
          },
        ),
      ),
    );
  }
}