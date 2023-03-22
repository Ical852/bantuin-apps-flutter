import 'dart:io';

import 'package:bantuin/pages/main_pages/chat_page.dart';
import 'package:bantuin/pages/main_pages/explore_page.dart';
import 'package:bantuin/pages/main_pages/home_page.dart';
import 'package:bantuin/pages/main_pages/profile_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  void logout() async {
    var result = await userVm.logout();
    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
    }
  }

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

    Widget DrawerContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24
        ),
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            MainButtonCustom(
              title: 'Logout',
              onPressed: (){
                logout();
              },
            ),
            SizedBox(height: 12,),
            MainButtonCustom(
              title: 'Check Token',
              onPressed: () {
                print(userVm.getToken());
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: white,
      key: globalKey,
      drawer: Drawer(
        child: DrawerContent(),
      ),
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