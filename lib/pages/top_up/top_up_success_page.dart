import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class TopUpSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_topup_success.png',
          title: 'Top Up Berhasil!',
          desc: 'Top Up Berhasil, anda dapat memintabantuan menggunakan bantuan money / mencairkan uang kembali',
          width: 235,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, '/main');
          },
        ),
      ),
    );
  }
}