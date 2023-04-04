import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService {
  late String baseUrl;
  late BuildContext context;

  ChatService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> getChatFromHelper({
    required String token
  }) async {
    var url = "$baseUrl/chat";
    var response = await http.get(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> getChatFromCustomer({
    required int helperId,
    required String token
  }) async {
    var url = "$baseUrl/chat?helper_id=$helperId";
    var response = await http.get(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }
}