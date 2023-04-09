import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  late String baseUrl;
  late BuildContext context;

  TransactionService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> createTransaction({
    required int bantuanId, grossAmount,
    required String orderId, transactionType, paymentMethod, token
  }) async {
    var url = "$baseUrl/transaction";
    var body = jsonEncode({
      "bantuan_id": bantuanId,
      "order_id": orderId,
      "gross_amount": grossAmount,
      "transaction_type": transactionType,
      "payment_method": paymentMethod,
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
    if (decoded.containsKey('message')) {
      if (decoded['message'] == 'Unauthenticated.') {
        return ResponseModel(true);
      }
    }

    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> getTransactions({
    required String token
  }) async {
    var url = "$baseUrl/transaction";
    var response = await http.get(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );
    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    if (decoded.containsKey('message')) {
      if (decoded['message'] == 'Unauthenticated.') {
        return ResponseModel(true);
      }
    }
    
    return ResponseModel.fromJson(decoded);
  }
}