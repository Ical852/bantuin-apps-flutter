import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BantuanOrderService {
  late String baseUrl;
  late BuildContext context;

  BantuanOrderService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> getUserRequestBantuanOrder({
    required int bantuanId,
    required String token
  }) async {
    var url = "$baseUrl/order?bantuan_id=$bantuanId&status=pending";
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