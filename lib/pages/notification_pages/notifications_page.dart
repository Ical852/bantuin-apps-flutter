import 'package:bantuin/pages/notification_pages/notification_detail.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/notification_view_model.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/info_items/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  var notifData = [];
  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  late var notifVm = NotificationViewModel(context);
  void getNotifData() async {
    toggleLoading(true);
    var result = await notifVm.getAll();
    toggleLoading(false);
    this.setState(() {
      notifData = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotifData();
  }

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
            Column(
              children: this.notifData.map((notif) {
                return NotificationItem(
                  notif: notif,
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => NotificationDetailPage(notif)
                      )
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget LoadingContent() {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: green1,
              ),
              SizedBox(height: 12,),
              Text(
                "Sedang mengambil data . . .",
                style: basePrimarySemibold,
              )
            ],
          ),
        ),
      );
    }

    Widget RenderContent() {
      return loading ? LoadingContent() : notifData.length > 0 ? ExistContent() : EmptyContent();
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