import 'dart:convert';

import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PushChatService {
  late String baseUrl;
  late BuildContext context;

  PushChatService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future pushChatNotif({
    required String title,
    required String message,
    required String deviceId,
    required int userId,
    required String token,
  }) async {
    var url = "$baseUrl/notif/push";
    var body = jsonEncode({
      "title": title,
      "body": message,
      "device_id": deviceId,
      "user_id": userId,
    });
    await http.post(Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );
  }
}