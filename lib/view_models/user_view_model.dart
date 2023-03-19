import 'dart:convert';

import 'package:bantuin/cubit/token_cubit.dart';
import 'package:bantuin/cubit/user_cubit.dart';
import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/get_fcm.dart';
import 'package:bantuin/models/auths/sign_in_response_model.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserViewModel {
  late BuildContext context;
  late UserService userService;

  UserViewModel(BuildContext context) {
    this.userService = UserService(context);
    this.context = context;
  }

  void errorShower(errors) {
    for (var message in errors) {
      showGLobalAlert('danger', message, context);
    }
  }

  UserModel getUserData() {
    return context.read<UserCubit>().state;
  }

  void setUserData(UserModel userData) {
    setStringPref('user', jsonEncode(userData.toJson()));
    context.read<UserCubit>().setUserData(userData);
  }

  String getToken() {
    return context.read<TokenCubit>().state;
  }

  void setToken(String token) {
    setStringPref('token', token);
    context.read<TokenCubit>().setToken(token);
  }

  Future<bool> signIn({
    required String email,
    required String password
  }) async {
    if (email == "" || password == "") {
      showGLobalAlert('danger', 'Isi Form Dengan Benar!', context);
      return false;
    }

    var response = await userService.signIn(email: email, password: password);
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      } else {
        if (response.meta.message.containsKey('email')) {
          errorShower(response.meta.message['email']);
        }
      }
      if (response.data != null) {
        if (response.data.containsKey('error')) {
          showGLobalAlert('danger', response.data['error'], context);
        }
      }
      return false;
    }

    SignInResponseModel result = SignInResponseModel.fromJson(response);
    setStringPref('isLoggedIn', 'yes');
    this.setUserData(result.user);
    this.setToken('Bearer ${result.accessToken}');

    showGLobalAlert('success', 'Sign In Success', context);
    return true;
  }

  Future<bool> fetch() async {
    var response = await userService.fetch(token: getToken());
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    UserModel user = UserModel.fromJson(response.data);
    var updatedDId = await getFcmToken();

    var deviceUpdate = await userService.updateDevice(userId: user.id, deviceId: updatedDId!);
    if (deviceUpdate == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    user = UserModel.fromJson(deviceUpdate.data['user']);

    this.setUserData(user);
    return true;
  }

  Future<bool> signUp({
    required String fullName,
    required String username,
    required String phoneNumber,
    required String email,
    required String password
  }) async {
    if (fullName == "" || username == "" || phoneNumber == "" || email == "" || password == "") {
      showGLobalAlert('danger', 'Isi Form Dengan Benar!', context);
      return false;
    }

    var response = await userService.signUp(
      fullName: fullName,
      username: username,
      phoneNumber: phoneNumber, 
      email: email, password: password
    );
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      } else {
        if (response.meta.message.containsKey('full_name')) {
          errorShower(response.meta.message['full_name']);
        }
        if (response.meta.message.containsKey('username')) {
          errorShower(response.meta.message['username']);
        }
        if (response.meta.message.containsKey('email')) {
          errorShower(response.meta.message['email']);
        }
        if (response.meta.message.containsKey('phone_number')) {
          errorShower(response.meta.message['phone_number']);
        }
        if (response.meta.message.containsKey('password')) {
          errorShower(response.meta.message['password']);
        }
      }
      if (response.data != null) {
        if (response.data.containsKey('error')) {
          showGLobalAlert('danger', response.data['error'], context);
        }
      }
      return false;
    }

    var storeUserId = response.data['user']['id'];
    var storeEmail = response.data['user']['email'];
    var deviceId = await getFcmToken();

    var storeResponse = await userService.storeDevice(
      userId: storeUserId,
      email: storeEmail,
      deviceId: deviceId!
    );

    if (storeResponse == null) {
      return false;
    }

    showGLobalAlert('success', 'Sign Up Success', context);
    return true;
  }

}