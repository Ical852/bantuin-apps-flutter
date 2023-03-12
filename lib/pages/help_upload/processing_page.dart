import 'dart:async';

import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class ProcessingPage extends StatefulWidget {
  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushNamed(context, '/create-success-page');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageCustom(
              height: 250,
              width: 250,
              image: AssetImage('assets/illustrations/il_processing.png'),
            ),
            SizedBox(height: 24,),
            Text(
              'Memproses...',
              style: extraBlackSemibold,
            ),
            SizedBox(height: 6,),
            Container(
              width: 245,
              child: Text(
                'Memproses publikasi pencarian bantuan anda kepada para helper',
                style: regularGrayLight,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}