import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class RequestSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ImgTextDescMiniButton(
            image: 'assets/illustrations/il_request_success.png',
            title: 'Request Berhasil',
            desc: 'Request kamu menjadi helper sudah terikirim ke admin, tunggu hingga admin mengkonfirmasi request kamu',
            width: 290,
            btnTitle: 'Ke Home',
            onPressed: (){
              Navigator.pushNamed(context, '/main');
            },
          ),
        ),
      ),
    );
  }
}