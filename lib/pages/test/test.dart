import 'dart:async';
import 'dart:io';

import 'package:bantuin/get_fcm.dart';
import 'package:bantuin/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';


class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  void getDeviceId() async {
    print("test");
    String? key = await getFcmToken();
    print('FCM TOKEN = $key');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      endDrawer: Drawer(),
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
                    "Map Test",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: (){
                      Scaffold.of(context).openDrawer();
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
                        "Left Drawer Test",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: (){
                      Scaffold.of(context).openEndDrawer();
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
                        "Right Drawer Test",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                }
              ),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)
                          )
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Modal BottomSheet'),
                              ElevatedButton(
                                child: Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
                    "Bottom Drawer Test",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  NotificationService.showIOS(
                    id: 1,
                    title: 'Test on IOS',
                    payload: 'Isi Payload',
                    body: 'Body Test on IOS'
                  );
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
                    "Manual Notif",
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
