import 'package:bantuin/models/notification_model.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:flutter/material.dart';

class NotificationDetailPage extends StatefulWidget {
  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();

  NotificationModel notif;
  NotificationDetailPage(this.notif);
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Notification Detail',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 120
                ),
                children: [
                  Text(
                    this.widget.notif.title,
                    style: mediumBlackSemibold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25,),
                  Text(
                    this.widget.notif.message,
                    style: regularBlackLight,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}