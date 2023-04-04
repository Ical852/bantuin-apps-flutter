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

  Future<ResponseModel?> acceptOrder({
    required int orderId,
    required String token
  }) async {
    var url = "$baseUrl/order/accept";
    var body = jsonEncode({
      "order_id": orderId
    });
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> denyOrder({
    required int orderId,
    required String token
  }) async {
    var url = "$baseUrl/order/deny";
    var body = jsonEncode({
      "order_id": orderId
    });
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> getDetailOrderByBantuanId({
    required int bantuanId,
    required String token, status = 'process'
  }) async {
    var url = "$baseUrl/order?bantuan_id=$bantuanId&status=$status";
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

  Future<ResponseModel?> completeOrder({
    required int orderId,
    required String token
  }) async {
    var url = "$baseUrl/order/done";
    var body = jsonEncode({
      "order_id": orderId
    });
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> cancelOrder({
    required int orderId,
    required String token, reason
  }) async {
    var url = "$baseUrl/order/cancel";
    var body = jsonEncode({
      "order_id": orderId,
      "reason": reason,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> createOrder({
    required int userId, bantuanId, helperId,
    required String token
  }) async {
    var url = "$baseUrl/order";
    var body = jsonEncode({
      "user_id": userId,
      "bantuan_id": bantuanId,
      "helper_id": helperId,
      "status": "pending",
    });
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> getHelperOrderByStatus({
    required int helperId,
    required String token, status
  }) async {
    var url = "$baseUrl/order?helper_id=$helperId&status=$status";
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