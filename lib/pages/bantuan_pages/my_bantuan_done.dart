import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class MyBantuanDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ImgTextDescMiniButton(
            image: 'assets/illustrations/il_done.png',
            title: 'Bantuan Selesai',
            desc: 'Permintaan bantuan kamu telah selesai, terima kasih sudah menggunakan aplikasi bantuin kami',
            width: 285,
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