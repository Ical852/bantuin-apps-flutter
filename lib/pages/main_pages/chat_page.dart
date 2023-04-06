import 'dart:async';
import 'dart:convert';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/chat_model.dart';
import 'package:bantuin/pages/chat_pages/detail_chat_page.dart';
import 'package:bantuin/pages/chat_pages/detail_chat_page_helper.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/chat_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/chat_items/chat_item.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/toggler/double_btn_toggler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();

  Function() openDrawer;
  ChatPage(this.openDrawer);
}

class _ChatPageState extends State<ChatPage> {
  late var chatVm = ChatViewModel(context);
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  var current = 'left';
  List<ChatModel> helperChats = [];
  List<ChatModel> customerChats = [];

  Future getHelperChats() async {
    var result = await chatVm.getChatFromHelper();
    this.setState(() {
      helperChats = result;
    });
  }

  Future refreshHelperChats() async {
    var newData = await helperChats.map((data) async {
      var groupId = '${user.id}_${data.helperId}';
      await data.setLastChat(groupId);
      await data.setTotalUnreaded(groupId, data.helperId.toString());
      return data;
    }).toList();

    var newFutureData = Future.wait(newData);
    var newChats = await newFutureData;

    this.setState(() {
      helperChats = newChats;
    });
  }

  Future getCustomerChats() async {
    if (user.helper != null && user.helper?.status == 'active') {
      var result = await chatVm.getChatFromCustomer();
      this.setState(() {
        customerChats = result;
      });
    }
  }

  Future refreshCustomerChats() async {
    var newData = await customerChats.map((data) async {
      var groupId = '${data.userId}_${user.helper!.id}';
      await data.setLastChat(groupId);
      await data.setTotalUnreaded(groupId, data.user!.id.toString());
      return data;
    }).toList();

    var newFutureData = Future.wait(newData);
    var newChats = await newFutureData;

    this.setState(() {
      customerChats = newChats;
    });
  }

  @override
  void initState() {
    super.initState();
    getHelperChats();
    getCustomerChats();
  }

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

    Widget HelperChatEmpty() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: Column(
            children: [
              ImageCustom(
                image: AssetImage('assets/illustrations/il_empty_bantuan.png'),
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    Widget HelperChatExist() {
      return Column(
        children: helperChats.map((data) {
          CollectionReference reference = FirebaseFirestore.instance.collection('${user.id}_${data.helperId}');
          reference.snapshots().listen((snapshot) async {
            await refreshHelperChats();
          });

          return ChatItem(
            onPress: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => DetailChatPage('${user.id}_${data.helperId}', data.helper!.user!)
                )
              );
            },
            image: '',
            network: true,
            nwUrl: data.helper!.user!.image,
            name: data.helper!.user!.fullName,
            text: data.lastChat ?? 'Tap to start chat with ' + data.helper!.user!.fullName,
            time: data.lastHour ?? '',
            notif: data.totalUnreaded ?? 0,
          );
        }).toList(),
      );
    }

    Widget RenderHelperChats() {
      return helperChats.length > 0 ? HelperChatExist() : HelperChatEmpty();
    }

    Widget HelperChats() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: RenderHelperChats()
      );
    }

    Widget CustomerChatEmpty() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: Column(
            children: [
              ImageCustom(
                image: AssetImage('assets/illustrations/il_empty_bantuan.png'),
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    Widget CustomerChatExist() {
      return Column(
        children: customerChats.map((data) {
          CollectionReference reference = FirebaseFirestore.instance.collection('${data.user!.id}_${user.helper!.id}');
          reference.snapshots().listen((snapshot) async {
            await refreshCustomerChats();
          });

          return ChatItem(
            onPress: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => DetailChatPageHelper('${data.user!.id}_${user.helper!.id}', data.user!)
                )
              );
            },
            image: '',
            network: true,
            nwUrl: data.user!.image,
            name: data.user!.fullName,
            text: data.lastChat ?? 'Tap to start chat with ' + data.user!.fullName,
            time: data.lastHour ?? '',
            notif: data.totalUnreaded ?? 0,
          );
        }).toList(),
      );
    }

    Widget RenderCustomerChats() {
      return customerChats.length > 0 ? CustomerChatExist() : CustomerChatEmpty();
    }

    Widget CustomerChats() {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: RenderCustomerChats()
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
        user.helper != null && user.helper?.status == 'active' ? Toggler() : SizedBox(),
        RenderChats(),
        SizedBox(height: 150,)
      ],
    );
  }
}