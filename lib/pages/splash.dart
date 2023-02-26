import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../getFcm.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void getDeviceId() async {
    print("test");
    String? key = await getFcmToken();
    print('FCM TOKEN = $key');
  }

  var currentMenu = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getDeviceId();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 10
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    "Get Device Id",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/chat');
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 10
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    "Chat Test",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/map');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    "Map Test",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
