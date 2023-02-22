import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../getFcm.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void apakek() async {
    print("test");
    String? key = await getFcmToken();
    print('FCM KEY = $key');
  }

  var currentMenu = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: GestureDetector(
              onTap: () {
                apakek();
                Navigator.pushNamed(context, "/map");
              },
              child: Text("Splash Pages"),
            ),
          ),
        ),
      ),
    );
  }
}
