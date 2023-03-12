import 'dart:async';

import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushNamed(context, '/get-started');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: green1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCustom(
                width: 120,
                height: 120,
                image: AssetImage('assets/images/logo.png'),
                margin: EdgeInsets.only(
                  bottom: 16
                ),
              ),
              Text(
                'Bantuin',
                style: poppinsText.copyWith(
                  fontSize: 32,
                  fontWeight: semiBold,
                  color: white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}