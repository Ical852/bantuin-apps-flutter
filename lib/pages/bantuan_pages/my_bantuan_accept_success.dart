import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:flutter/material.dart';

class MyBantuanAcceptSuccess extends StatelessWidget {
  const MyBantuanAcceptSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ImgTextDescMiniButton(
            image: 'assets/illustrations/il_accept_success.png',
            title: 'Terima Berhasil',
            desc: 'Terima request dari helper berhasil, silakan komunikasikan dengan helper apa yang kamu perlu',
            width: 265,
            btnTitle: 'Ke Profile',
            onPressed: (){
              setPage(context, 'Profile');
              Navigator.pushNamed(context, '/main');
            },
          ),
        ),
      ),
    );
  }
}