import 'dart:math';

import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/chat_view_model.dart';
import 'package:bantuin/view_models/push_chat_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_me.dart';
import 'package:bantuin/widgets/chat_items/chat_bubble_other.dart';
import 'package:bantuin/widgets/chat_items/chat_input.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailChatPageHelper extends StatefulWidget {
  @override
  State<DetailChatPageHelper> createState() => _DetailChatPageHelperState();

  String groupId;
  UserModel customer;
  DetailChatPageHelper(this.groupId, this.customer);
}

class _DetailChatPageHelperState extends State<DetailChatPageHelper> {
  late var userVm = UserViewModel(context);
  late var chatVm = ChatViewModel(context);
  late var pushChatVm = PushChatViewModel(context);
  late var user = userVm.getUserData();

  late CollectionReference chat = FirebaseFirestore.instance.collection(this.widget.groupId);
  late Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance.collection(this.widget.groupId).orderBy('date').snapshots();
  final ScrollController _controller = ScrollController();

  TextEditingController chatController = TextEditingController(text: "");
  var currentValue = "";

  bool isStick(key, from, stream) {
    return key != stream.length -1 && stream[key + 1]['userId'] == from;
  }

  void readCustomerResentChat() async {
    await chatVm.helperReadCustomer(groupId: this.widget.groupId, userId: this.widget.customer.id.toString());
  }

  @override
  void initState() {
    super.initState();
    readCustomerResentChat();
    pushChatVm.setOnChatPageState(true);
    pushChatVm.setCurrentUserIdChat(this.widget.customer.id);
  }

  @override
  Widget build(BuildContext context) {
    Widget GetCHatBubble(Map<String, dynamic> data, int key, List<QueryDocumentSnapshot<Object?>> docs) {
      return user.helper!.id.toString() == data['userId'] ?
      ChatBubbleMe(
        message: data['message'],
        noPadding: isStick(key, data['userId'], docs),
      )
      :
      ChatBubbleOther(
        message: data['message'],
        image: '',
        network: true,
        nwUrl: this.widget.customer.image,
        noPadding: isStick(key, data['userId'], docs),
      );
    }

    Widget MainContent() {
      return Container(
        child: Column(
          children: [
            MainHeader(
              title: this.widget.customer.fullName,
              onBack: (){
                Navigator.pop(context);
                pushChatVm.setOnChatPageState(false);
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

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_controller.hasClients) {
                      _controller
                          .jumpTo(_controller.position.maxScrollExtent);
                    } else {
                      setState(() => null);
                    }
                  });

                  return ListView(
                    controller: _controller,
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
            hint: 'Beri pesan',
            onPressed: () async {
              var chatText = chatController.text.toString();
              this.chatController.text = '';
              this.setState(() {
                currentValue = '';
              });
              
              await chat.add({
                'groupId': '${this.widget.customer.id}_${user.helper!.id}',
                'userId': user.helper!.id.toString(),
                'date': DateTime.now(),
                'message': chatText,
                'isRead': false
              })
              .then((value) => print('Berhasil'))
              .catchError((error) => print('failed' + error));

              await pushChatVm.pushChatNotif(
                title: user.fullName,
                message: chatText,
                deviceId: this.widget.customer.userDevice!.deviceId,
                userId: user.helper!.id
              );
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