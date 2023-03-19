import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/headers/ob_header.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBCustomer4Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_helped.png',
                  title: 'Helper Membantu',
                  desc: 'Setelah kamu mengupload kebutuh bantuanmu, seorang helper akan memilih card bantuan kamu, lalu kamu akan chat dengan helper untuk kejelasan jasa bantuan tersebut. Dari transaksi hingga apa yang akan dikerjakan helper',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-customer5');
                  },
                  onSecPress: (){
                    setStringPref('onboarding', 'done');
                    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
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