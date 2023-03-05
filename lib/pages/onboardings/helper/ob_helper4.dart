import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/obheader.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBHelper4Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_obok.png',
                  title: 'Menunggu Konfirmasi',
                  desc: 'Setelah selesai mendaftarkan diri sebagai helper, admin akan mengecek data yang kamu daftarkan, jika di konfirmasi oleh admin, kamu akan mendapatkan email konfirmasi bahwa kamu terkonfirmasi menjadi helper di aplikasi ini',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-helper5');
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