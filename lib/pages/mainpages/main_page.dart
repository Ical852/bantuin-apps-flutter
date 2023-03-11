import 'dart:io';

import 'package:bantuin/pages/mainpages/chat_page.dart';
import 'package:bantuin/pages/mainpages/explore_page.dart';
import 'package:bantuin/pages/mainpages/home_page.dart';
import 'package:bantuin/pages/mainpages/profile_page.dart';
import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final globalKey = GlobalKey<ScaffoldState>();

  var currentMenu = 'home';
  bool isActive(menu) {
    return currentMenu == menu;
  }

  void openDrawer() {
    globalKey.currentState?.openDrawer();
  }

  var navHidden = false;

  @override
  Widget build(BuildContext context) {
    bool keyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    if (keyboard) {
      this.setState(() {
        navHidden = true;
      });
    } else {
      this.setState(() {
        navHidden = false;
      });
    }

    Widget BottomNavigator() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(
            bottom: Platform.isIOS ? 20 : 0
          ),
          height: Platform.isIOS ? 90 : 70,
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.9),
                blurRadius: 9,
                offset: Offset(0, 9)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuItemCustom(
                icon: 'home',
                onPress: (){
                  this.setState(() {
                    currentMenu = 'home';
                  });
                },
                active: isActive('home'),
              ),
              MenuItemCustom(
                icon: 'explore',
                onPress: (){
                  this.setState(() {
                    currentMenu = 'explore';
                  });
                },
                active: isActive('explore'),
              ),
              Container(
                width: 48,
              ),
              MenuItemCustom(
                icon: 'chat',
                onPress: (){
                  this.setState(() {
                    currentMenu = 'chat';
                  });
                },
                active: isActive('chat'),
              ),
              MenuItemCustom(
                icon: 'profile',
                onPress: (){
                  this.setState(() {
                    currentMenu = 'profile';
                  });
                },
                active: isActive('profile'),
              ),
            ],
          ),
        ),
      );
    }

    Widget UploadButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
            bottom: Platform.isIOS ? 28 : 8
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [green2, green1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          width: 80,
          height: 80,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              )
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/create-help');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCustom(
                  height: 42,
                  width: 35,
                  image: AssetImage('assets/icons/ic_upload.png'),
                  margin: EdgeInsets.only(
                    bottom: 4
                  ),
                ),
                Text(
                  'Help',
                  style: regularWhiteSemibold
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget MainContent() {
      return currentMenu == 'home' ? HomePage(openDrawer)
      : currentMenu == 'explore' ? ExplorePage()
      : currentMenu == 'chat' ? ChatPage(openDrawer)
      : ProfilePage(openDrawer);
    }

    return Scaffold(
      backgroundColor: white,
      key: globalKey,
      drawer: Drawer(),
      body: Container(
        child: Stack(
          children: [
            MainContent(),
            navHidden ? SizedBox() : BottomNavigator(),
            navHidden ? SizedBox() : UploadButton()
          ],
        ),
      ),
    );
  }
}