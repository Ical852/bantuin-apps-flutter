import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/headers/ob_header.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBHelper5Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_obhs.png',
                  title: 'Menjadi Helper',
                  desc: 'Setelah kamu dikonfirmasi menjadi helper, hal yg berikutnya kamu lakukan hanya memilih orang yang membutuhkan bantuan pada menu home / explore / search, dari situ kamu bisa mendapatkan uang sesuai yg di pasang oleh customer',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Kembali Ke Awal',
                  onMainPress: () async {
                    setStringPref('onboarding', 'done');
                    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
                  },
                  onSecPress: (){
                    Navigator.pushNamedAndRemoveUntil(context, '/tutor-guide', (route) => false);
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