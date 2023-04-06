import 'dart:io';

import 'package:bantuin/cubit/page_cubit.dart';
import 'package:bantuin/get_fcm.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  bool isActive(state, menu) {
    return state == menu;
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

    Widget BottomNavigator(curState) {
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
                  setPage(context, 'home');
                },
                active: isActive(curState, 'home'),
              ),
              MenuItemCustom(
                icon: 'explore',
                onPress: (){
                  setPage(context, 'explore');
                },
                active: isActive(curState, 'explore'),
              ),
              Container(
                width: 48,
              ),
              MenuItemCustom(
                icon: 'chat',
                onPress: (){
                  setPage(context, 'chat');
                },
                active: isActive(curState, 'chat'),
              ),
              MenuItemCustom(
                icon: 'profile',
                onPress: (){
                  setPage(context, 'profile');
                },
                active: isActive(curState, 'profile'),
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

    Widget MainContent(curState) {
      return curState == 'home' ? HomePage(openDrawer)
      : curState == 'explore' ? ExplorePage()
      : curState == 'chat' ? ChatPage(openDrawer)
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
            ),
            SizedBox(height: 12,),
            MainButtonCustom(
              title: 'Check Chat',
              onPressed: () async {
                // FirebaseFirestore.instance
                //     .collection('icalios_icalandro')
                //     .orderBy("date")
                //     .limit(1)
                //     .get()
                //     .then((querySnapshot) {
                //       var time = DateTime.fromMillisecondsSinceEpoch(querySnapshot.docs.first.data()['date'].seconds * 1000);
                //       print(time.hour);
                //       print(time.minute);
                //     }
                // );
                // await FirebaseFirestore.instance
                //     .collection('2_1')
                //     .where('userId', isEqualTo: '1')
                //     .where('isRead', isEqualTo: false)
                //     .get()
                //     .then((value) {
                //   print(value.size);
                // });
                // FirebaseFirestore.instance
                //     .collection('2_1')
                //     .where('userId', isEqualTo: '1')
                //     .get()
                //     .then((value) async {
                //   print(value.docs.map((doc) {
                //     print(doc.id);
                //     FirebaseFirestore.instance
                //         .collection('2_1')
                //         .doc(doc.id.toString())
                //         .update({'isRead': true});
                //   }));
                // });
              },
            ),
            SizedBox(height: 12,),
            MainButtonCustom(
              title: 'Check Device Id',
              onPressed: () async {
                print(await getFcmToken());
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
      body: BlocBuilder<PageCubit, String>(
        builder: (context, state) {
          return Container(
              child: Stack(
                children: [
                  MainContent(state),
                  navHidden ? SizedBox() : BottomNavigator(state),
                  navHidden ? SizedBox() : UploadButton()
                ],
              ),
            );
        },
      ),
    );
  }
}