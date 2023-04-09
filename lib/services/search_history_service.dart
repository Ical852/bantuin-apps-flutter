import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchHistoryService {
  late String baseUrl;
  late BuildContext context;

  SearchHistoryService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> getSearchHistories({
    required String token
  }) async {
    var url = "$baseUrl/search";
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

  Future<ResponseModel?> createHistory({
    required String token, searchText
  }) async {
    var url = "$baseUrl/search";
    var body = jsonEncode({
      "search_text": searchText
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

  Future<ResponseModel?> clearHistories({
    required String token
  }) async {
    var url = "$baseUrl/search";
    var response = await http.delete(
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

  Future<ResponseModel?> deleteHistory({
    required String token,
    required int id
  }) async {
    var url = "$baseUrl/search?id=$id";
    var response = await http.delete(
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