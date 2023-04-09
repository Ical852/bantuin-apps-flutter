import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HelperService {
  late String baseUrl;
  late BuildContext context;

  HelperService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> requestToBeHelper({
    required String token
  }) async {
    var url = "$baseUrl/helper";
    var response = await http.post(
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

  Future<ResponseModel?> getAllRecords({
    required String token,
    required int helperId
  }) async {
    var url = "$baseUrl/helper/rate?helper_id=$helperId";
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