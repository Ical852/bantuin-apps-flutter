import 'package:bantuin/pages/notification_pages/notification_detail.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/info_items/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  var empty = false;

  @override
  Widget build(BuildContext context) {
    Widget EmptyContent() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: ImgTextDescMiniButton(
            image: 'assets/illustrations/il_emptynotif.png',
            title: 'Notifikasi Kosong',
            desc: 'Sepertinya kamu belum memiliki notifikasi sama sekali, silakan gunakan fitur di aplikasi ini untuk mendapatkannya',
            width: 300,
            btnTitle: 'Ke Home',
            onPressed: (){
              Navigator.pushNamed(context, '/main');
            },
          ),
        ),
      );
    }

    Widget ExistContent() {
      return Container(
        child: ListView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24
          ),
          children: [
            Text(
              'Account Info',
              style: mediumBlackSemibold,
            ),
            SizedBox(height: 16,),
            NotificationItem(
              title: 'Your account has been verified',
              desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard...',
              date: [2023, 05, 20],
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => NotificationDetailPage()
                  )
                );
              },
            ),
            NotificationItem(
              title: 'New Koz on Jakarta, Check Now !',
              desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard...',
              date: [2023, 05, 20],
              onPressed: (){},
            ),
            NotificationItem(
              title: 'New Modern Place on Bekasi',
              desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard...',
              date: [2023, 05, 20],
              onPressed: (){},
            ),
            NotificationItem(
              title: 'Don’t Forget to Check Your Rent !',
              desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard...',
              date: [2023, 05, 20],
              onPressed: (){},
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget RenderContent() {
      return empty ? EmptyContent() : ExistContent();
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Notifications',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: RenderContent(),
            )
          ],
        ),
      ),
    );
  }
}