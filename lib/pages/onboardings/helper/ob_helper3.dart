import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/obheader.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBHelper3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: 32
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OBHeader(
                onPress: (){
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: OBContents(
                  image: 'assets/illustrations/il_obhelp.png',
                  title: 'Daftar Sebagai Helper',
                  desc: 'Setelah berhasil memiliki akun di bantuin app, kamu bisa melanjutkan mendaftar sebagai helper, kamu akan diarahkan untuk mengisi data pribadi lagi untuk kepentingan peraturan sebagai helper',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-helper4');
                  },
                  onSecPress: (){
                    Navigator.pushNamed(context, '/sign-in');
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}