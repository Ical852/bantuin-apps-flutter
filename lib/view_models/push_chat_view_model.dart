import 'package:bantuin/cubit/on_chat_page_cubit.dart';
import 'package:bantuin/cubit/user_id_chat_cubit.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/services/push_chat_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PushChatViewModel {
  late BuildContext? context;
  late PushChatService pushChatService;
  late UserViewModel userVm;
  late UserModel user;
  late String token;

  PushChatViewModel(BuildContext context) {
    this.pushChatService = PushChatService(context);
    this.userVm = UserViewModel(context);
    this.user = this.userVm.getUserData();
    this.token = this.userVm.getToken();
    this.context = context;
  }

  bool getOnChatPageState() {
    return context!.read<OnChatPageCubit>().state;
  }

  void setOnChatPageState(bool value) {
    context!.read<OnChatPageCubit>().setOnChatPage(value);
  }

  int getCurrentUserIdChat() {
    return context!.read<UserIdChatCubit>().state;
  }

  void setCurrentUserIdChat(int value) {
    context!.read<UserIdChatCubit>().setUserIdOnChat(value);
  }
  
  Future pushChatNotif({
    required String title,
    required String message,
    required String deviceId,
    required int userId,
  }) async {
    await pushChatService.pushChatNotif(
      title: title,
      message: message,
      deviceId: deviceId,
      userId: userId,
      token: token
    );
  }
}