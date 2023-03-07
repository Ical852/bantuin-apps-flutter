import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/ob_header.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBCustomer2Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_verif.png',
                  title: 'Verifikasi Email',
                  desc: 'Verifikasi data diri yang kamu daftarkan melalui email yang kamu daftarkan, setelah selesai mendaftarkan data diri kamu akan mendapat email untuk verifikasi akun',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-customer3');
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