import 'dart:math';

import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_me.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_other.dart';
import 'package:bantuin/widgets/chat_items/chat_input.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:flutter/material.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({Key? key}) : super(key: key);

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController chatController = TextEditingController(text: "");
  var currentValue = "";

  var chats = [
    {
      "id": 1,
      "from" : "me",
      "message": "Hello james,  apa saya bisa bantu di campaign?"
    },
    {
      "id": 2,
      "from": "other",
      "message": "Bisa, mungkin dengan menyebarkan campaign?"
    },
  ];
  var confirmDialog = false;
  var choosedId = null;
  void confirmDialogToggle(value) {
    this.setState(() {
      confirmDialog = value;
    });
  }
  bool isStick(data, param) {
    return data.key != chats.length -1 && chats[data.key + 1]['from'] == param;
  }
  void removeChat(id) {
    this.setState(() {
      choosedId = id;
    });
    confirmDialogToggle(true);
  }
  void removeChatConfirmed() {
    this.setState(() {
      chats = chats.where((element) => element['id'] != choosedId).toList();
    });
    confirmDialogToggle(false);
  }

  @override
  Widget build(BuildContext context) {
    Widget MainContent() {
      return Container(
        child: Column(
          children: [
            MainHeader(
              title: 'James Curt',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 12,
                  bottom: 120
                ),
                children: chats.asMap().entries.map((data) {
                  return data.value['from'] == "me" ? 
                  ChatBubbleMe(
                    message: data.value['message'] as String,
                    noPadding: isStick(data, 'me'),
                    onLongPress: (){
                      removeChat(data.value['id']);
                    },
                  )
                  :
                  ChatBubbleOther(
                    message: data.value['message'] as String,
                    image: 'assets/dummies/user1.png',
                    noPadding: isStick(data, 'other'),
                    onLongPress: (){
                      removeChat(data.value['id']);
                    },
                  );
                }).toList(),
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
            onPressed: (){
              this.setState(() {
                chats.add({
                  "id": Random().nextInt(900) + 1,
                  "from" : "me",
                  "message": currentValue
                });
                currentValue = "";
                chatController.text = "";
              });
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
    
    Widget LongPressDialog() {
      return confirmDialog ?
      GestureDetector(
        onTap: () => confirmDialogToggle(false),
        child: DialogModal(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Pilih Aksi',
                    style: mediumBlackSemibold
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Hapus Chat ?",
                    style: poppinsText.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                      color: black1
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RawButtonCustom(
                        height: 40,
                        onPress: removeChatConfirmed,
                        title: 'Hapus',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
      :
      SizedBox();
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            MainContent(),
            BottomInput(),
            LongPressDialog()
          ],
        ),
      ),
    );
  }
}