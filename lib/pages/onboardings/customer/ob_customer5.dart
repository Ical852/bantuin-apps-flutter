import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/obheader.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBCustomer5Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_helpeds.png',
                  title: 'Bantuan Selesai',
                  desc: 'Setelah bantuan yang kamu butuhkan selesai, helper akan mendapatkan uang yang kamu pasang, baik pembayaran cash / bantuan money ataupun midtrans payment',
                  mainBtnTitle: 'Lanjutkan',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  mainOnly: true,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}