import 'dart:convert';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/notification_model.dart';
import 'package:bantuin/models/notifications/get_all_notif_response.dart';
import 'package:bantuin/services/notification_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

class NotificationViewModel {
  late BuildContext context;
  late NotificationService notificationService;
  late UserViewModel userVm;
  late String token;

  NotificationViewModel(BuildContext context) {
    this.notificationService = NotificationService(context);
    this.userVm = UserViewModel(context);
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future<List<NotificationModel>> getAll() async {
    var response = await notificationService.getAll(token: token);
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Notifications Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var notifResponse = GetAllNotifResponse.fromJson(response);
    return notifResponse.notifications;
  }
}