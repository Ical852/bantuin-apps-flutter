import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/headers/ob_header.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBCustomer1Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_regis.png',
                  title: 'Registrasi',
                  desc: 'Daftarkan akunmu terlebih dahulu di aplikasi ini, lanjutkan atau lewati dari halaman ini ke halaman sign up, lalu dilanjutkan dengan mengisi data diri kamu',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-customer2');
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