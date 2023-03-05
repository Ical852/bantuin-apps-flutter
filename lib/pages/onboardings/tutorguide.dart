import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/headers/obheader.dart';
import 'package:bantuin/widgets/ob_contents.dart';
import 'package:flutter/material.dart';

class TutorGuidePage extends StatefulWidget {
  @override
  State<TutorGuidePage> createState() => _TutorGuidePageState();
}

class _TutorGuidePageState extends State<TutorGuidePage> {
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
                  image: 'assets/illustrations/il_tutorguide.png',
                  title: 'Bagaimana cara aplikasi ini Bekerja ?',
                  desc: 'Bagaimana cara menggunakan aplikasi bantuin? tekan tombol telusuri untuk melihat tutorial, tekan lewati jika anda tidak tertarik dengan tutorial',
                  mainBtnTitle: 'Telusuri',
                  secBtnTitle: 'Lewati',
                  onMainPress: (){
                    Navigator.pushNamed(context, '/tutor-guide-choose');
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