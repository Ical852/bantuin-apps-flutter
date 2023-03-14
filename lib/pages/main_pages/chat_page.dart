import 'dart:async';

import 'package:bantuin/pages/chat_pages/detail_chat_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/chat_items/chat_item.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/toggler/double_btn_toggler.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();

  Function() openDrawer;
  ChatPage(this.openDrawer);
}

class _ChatPageState extends State<ChatPage> {

  var current = 'left';

  @override
  Widget build(BuildContext context) {
    
    Widget HeaderContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 28,
          left: 24,
          right: 24
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                this.widget.openDrawer();
              },
              child: ImageCustom(
                height: 18,
                width: 18,
                image: AssetImage('assets/icons/ic_bar_chat.png'),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Your Recent Chats',
              style: regularBlackSemibold
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/notifications');
              },
              child: ImageCustom(
                height: 20,
                width: 17,
                image: AssetImage('assets/icons/ic_notif_chat.png'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }
    
    Widget SearchBar() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14
        ),
        margin: EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24
        ),
        height: 40,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ],
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Flexible(
              child: Focus(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search Text',
                    hintStyle: regularGrayRegular
                  ),
                  style: regularBlackRegular
                ),
              ),
            ),
            SizedBox(width: 14,),
            ImageCustom(
              height: 20,
              width: 20,
              image: AssetImage('assets/icons/ic_search_green.png'),
            )
          ],
        ),
      );
    }

    Widget Title() {
      return Container(
        margin: EdgeInsets.only(
          top: 25,
          left: 24,
          right: 24
        ),
        child: Text(
          'Messages',
          style: baseBlackSemibold
        ),
      );
    }

    Widget Toggler() {
      return Container(
        margin: EdgeInsets.only(
          top: 12,
          left: 24,
          right: 24
        ),
        child: DoubleBtnToggler(
          current: current,
          leftPress: (){
            this.setState(() {
              current = 'left';
            });
          },
          rightPress: (){
            this.setState(() {
              current = 'right';
            });
          },
          left: 'Helper',
          right: 'Customer',
        ),
      );
    }

    Widget HelperChats() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            ChatItem(
              onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => DetailChatPage()
                  )
                );
              },
              image: 'assets/dummies/user1.png',
              name: 'James Curt',
              text: 'I saw it clearly and might be go...',
              time: '12.30',
            ),
            ChatItem(
              onPress: (){},
              image: 'assets/dummies/user2.png',
              name: 'Rosalie Emily',
              text: 'Did you know how to get the...',
              time: '7:30',
              notif: 2,
            ),
            ChatItem(
              onPress: (){},
              image: 'assets/dummies/user3.png',
              name: 'Anna Joeson',
              text: 'Wanna hang out or something?...',
              time: '21:30',
            ),
            ChatItem(
              onPress: (){},
              image: 'assets/dummies/user4.png',
              name: 'Justin Anderson',
              text: 'Nobody’s gonna know until we...',
              time: '4:30',
              notif: 5,
            ),
            ChatItem(
              onPress: (){},
              image: 'assets/dummies/user5.png',
              name: 'Angela Claire',
              text: 'Why don’t you come to my hou...',
              time: '11:25',
              notif: 3,
            ),
          ],
        ),
      );
    }

    Widget CustomerChats() {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          children: [],
        ),
      );
    }

    Widget RenderChats() {
      return current == 'left' ? HelperChats() : CustomerChats();
    }

    return ListView(
      children: [
        HeaderContent(),
        SearchBar(),
        Title(),
        Toggler(),
        RenderChats(),
        SizedBox(height: 150,)
      ],
    );
  }
}