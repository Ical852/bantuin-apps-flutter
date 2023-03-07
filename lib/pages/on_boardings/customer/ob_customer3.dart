import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/ob_header.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class OBCustomer3Page extends StatelessWidget {
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
                  image: 'assets/illustrations/il_upload.png',
                  title: 'Mengupload Bantuan',
                  desc: 'Masuk ke menu home / explore / chat / profile untuk menekan tombol help untuk mengupload bantuan, disitu kamu bisa mengupload foto dan deskripsi untuk keterangan kamu butuh bantu apa dan kamu bersedia membayar helper berapa',
                  mainBtnTitle: 'Lanjutkan',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/ob-customer4');
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