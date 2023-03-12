import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
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
        child: ImgTextDescMiniButton(
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