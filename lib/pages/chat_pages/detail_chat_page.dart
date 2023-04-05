import 'dart:math';

import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/chat_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_me.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_other.dart';
import 'package:bantuin/widgets/chat_items/chat_input.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailChatPage extends StatefulWidget {
  @override
  State<DetailChatPage> createState() => _DetailChatPageState();

  String groupId;
  UserModel helper;
  DetailChatPage(this.groupId, this.helper);
}

class _DetailChatPageState extends State<DetailChatPage> {
  late var userVm = UserViewModel(context);
  late var chatVm = ChatViewModel(context);
  late var user = userVm.getUserData();

  late CollectionReference chat = FirebaseFirestore.instance.collection(this.widget.groupId);
  late Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance.collection(this.widget.groupId).orderBy('date').snapshots();

  TextEditingController chatController = TextEditingController(text: "");
  var currentValue = "";

  bool isStick(key, from, stream) {
    return key != stream.length -1 && stream[key + 1]['userId'] == from;
  }

  void readHelperResentChat() async {
    await chatVm.customerReadHelper(groupId: this.widget.groupId, helperId: this.widget.groupId.split('_')[1]);
  }

  @override
  void initState() {
    super.initState();
    readHelperResentChat();
  }

  @override
  Widget build(BuildContext context) {
    Widget GetCHatBubble(Map<String, dynamic> data, int key, List<QueryDocumentSnapshot<Object?>> docs) {
      return user.id.toString() == data['userId'] ?
      ChatBubbleMe(
        message: data['message'],
        noPadding: isStick(key, data['userId'], docs),
      )
      :
      ChatBubbleOther(
        message: data['message'],
        image: '',
        network: true,
        nwUrl: this.widget.helper.image,
        noPadding: isStick(key, data['userId'], docs),
      );
    }

    Widget MainContent() {
      return Container(
        child: Column(
          children: [
            MainHeader(
              title: this.widget.helper.fullName,
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: chatStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("error");
                  }
          
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("loading");
                  }

                  return ListView(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 12,
                      bottom: 120
                    ),
                    children: snapshot.data!.docs.asMap().entries.map((element) {
                      var document = element.value;
                      var key = element.key;

                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return GetCHatBubble(data, key, snapshot.data!.docs);
                    }).toList(),
                  );
                }
              ),
            )
          ],
        ),
      );
    }

    Widget BottomInput() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16
          ),
          child: ChatInput(
            controller: chatController,
            isActive: currentValue != "",
            hint: 'Beri pesan ke James Curt',
            onPressed: () async {
              await chat.add({
                'groupId': '${user.id}_${this.widget.helper.id}',
                'userId': user.id.toString(),
                'date': DateTime.now(),
                'message': chatController.text.toString(),
                'isRead': false
              })
              .then((value) => print('Berhasil'))
              .catchError((error) => print('failed' + error));
              
              this.chatController.text = '';
            },
            onChanged: (value) {
              this.setState(() {
                currentValue = value;
              });
            },
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            MainContent(),
            BottomInput(),
          ],
        ),
      ),
    );
  }
}