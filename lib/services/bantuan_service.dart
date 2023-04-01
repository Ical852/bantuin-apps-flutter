import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class BantuanService {
  late String baseUrl;
  late BuildContext context;

  BantuanService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> getBantuanByUserId({
    required int userId,
    required String token
  }) async {
    var url = "$baseUrl/bantuan?user_id=$userId";
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

  Future<ResponseModel?> deleteBantuan({
    required int bantuanId,
    required String token
  }) async {
    var url = "$baseUrl/bantuan?bantuan_id=$bantuanId";
    var response = await http.delete(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );
    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> createBantuan({
    required int userId, price, categoryId,
    required String image, title, desc, location, payType, status, token,
  }) async {
    var url = "$baseUrl/bantuan";
    var request = await http.MultipartRequest(
      'POST', Uri.parse(url)
    )
      ..files.add(await http.MultipartFile.fromPath('image', image))
      ..headers.addAll(tokenedHeader(token)
    );
    request.fields['user_id'] = userId.toString();
    request.fields['title'] = title;
    request.fields['price'] = price.toString();
    request.fields['desc'] = desc;
    request.fields['location'] = location;
    request.fields['pay_type'] = payType;
    request.fields['category_id'] = categoryId.toString();
    request.fields['status'] = status;

    var streamedResponse  = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> getBantuanCategories ({
    required String token
  }) async {
    var url = "$baseUrl/category";
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

  Future<ResponseModel?> getExpensiveBantuan({
    required String token
  }) async {
    var url = "$baseUrl/bantuan?price=high";
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