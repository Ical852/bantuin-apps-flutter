import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/chat_model.dart';
import 'package:bantuin/models/chats/get_all_chat_response_model.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/services/chat_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel {
  late BuildContext context;
  late ChatService chatService;
  late UserViewModel userVm;
  late UserModel user;
  late String token;

  ChatViewModel(BuildContext context) {
    this.userVm = UserViewModel(context);
    this.chatService = ChatService(context);
    this.user = this.userVm.getUserData();
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future customerReadHelper({
    required String groupId,
    required String helperId,
  }) async {
    FirebaseFirestore.instance.collection(groupId)
      .where('userId', isEqualTo: helperId)
      .get().then((value) async {
        print(value.docs.map((doc) {
          print(doc.id);
          FirebaseFirestore.instance.collection(groupId).doc(doc.id.toString()).update({
            'isRead': true
          });
        }));
      });
  }

  Future helperReadCustomer({
    required String groupId,
    required String userId,
  }) async {
    FirebaseFirestore.instance.collection(groupId)
      .where('userId', isEqualTo: userId)
      .get().then((value) async {
        print(value.docs.map((doc) {
          print(doc.id);
          FirebaseFirestore.instance.collection(groupId).doc(doc.id.toString()).update({
            'isRead': true
          });
        }));
      });
  }

  Future<List<ChatModel>> getChatFromHelper() async {
    var response = await chatService.getChatFromHelper(
      token: token,
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Chat Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var bantuanResponse = GetAllChatResponseModel.fromJson(response);

    var newData = await bantuanResponse.chats.map((data) async {
      var groupId = '${user.id}_${data.helperId}';
      await data.setLastChat(groupId);
      await data.setTotalUnreaded(groupId, data.helperId.toString());
      return data;
    }).toList();

    var newFutureData = Future.wait(newData);
    var newChats = await newFutureData;

    return newChats;
  }

  Future<List<ChatModel>> getChatFromCustomer() async {
    var response = await chatService.getChatFromCustomer(
      token: token,
      helperId: user.helper!.id
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Chat Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var bantuanResponse = GetAllChatResponseModel.fromJson(response);

    var newData = await bantuanResponse.chats.map((data) async {
      var groupId = '${data.userId}_${user.helper!.id}';
      await data.setLastChat(groupId);
      await data.setTotalUnreaded(groupId, data.user!.id.toString());
      return data;
    }).toList();

    var newFutureData = Future.wait(newData);
    var newChats = await newFutureData;

    return newChats;
  }

  Future<bool> createChat({
    required int userId, helperId
  }) async {
    var response = await chatService.createChat(
      token: token,
      userId: userId,
      helperId: helperId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Start to Chat Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }

    return true;
  }
}