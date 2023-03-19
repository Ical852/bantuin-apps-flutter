import 'dart:async';
import 'dart:convert';

import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class UserService {
  late String baseUrl;
  late BuildContext context;

  UserService(BuildContext context) {
    this.baseUrl = getBaseUrl(context);
    this.context = context;
  }

  Future<ResponseModel?> signIn({
    required String email,
    required String password
  }) async {
    var url = "$baseUrl/user/login";
    var body = jsonEncode({
      "email": email,
      "password": password
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> fetch({
    required String token,
  }) async {
    var url = "$baseUrl/user";
    var response = await http.get(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);

    if (decoded.containsKey('message')) {
      if (decoded['message'] == 'Unauthenticated') {
        return null;
      }
    }

    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> signUp({
    required String fullName,
    required String username,
    required String phoneNumber,
    required String email,
    required String password
  }) async {
    var url = "$baseUrl/user/register";
    var body = jsonEncode({
      "full_name": fullName,
      "username": username,
      "phone_number": phoneNumber,
      "email": email,
      "password": password
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> storeDevice({
    required int userId,
    required String deviceId,
    required String email,
  }) async {
    var url = "$baseUrl/device";
    var body = jsonEncode({
      "user_id": userId,
      "device_id": deviceId,
      "email": email,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> updateDevice({
    required int userId,
    required String deviceId,
  }) async {
    var url = "$baseUrl/device/update";
    var body = jsonEncode({
      "user_id": userId,
      "device_id": deviceId,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> reset({
    required String email,
  }) async {
    var url = "$baseUrl/user/resetpw";
    var body = jsonEncode({
      "email": email,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    return ResponseModel.fromJson(decoded);
  }

  Future<ResponseModel?> userUpdate({
    required String fullName,
    required String username,
    required String phoneNumber,
    required String token,
  }) async {
    var url = "$baseUrl/user";
    var body = jsonEncode({
      "full_name": fullName,
      "username": username,
      "phone_number": phoneNumber,
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

  Future<ResponseModel?> updatePassword({
    required String password,
    required String newPassword,
    required String token
  }) async {
    var url = "$baseUrl/user/changepw";
    var body = jsonEncode({
      "password": password,
      "new_password": newPassword,
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

  Future<ResponseModel?> logout({
    required String token
  }) async {
    var url = "$baseUrl/user/logout";
    var response = await http.post(
      Uri.parse(url),
      headers: tokenedHeader(token),
    );

    if (response.body.isEmpty) {
      return null;
    }

    var decoded = jsonDecode(response.body);
    
    if (decoded.containsKey('message')) {
      if (decoded['message'] == 'Unauthenticated') {
        return null;
      }
    }

    return ResponseModel.fromJson(decoded);
  }
}