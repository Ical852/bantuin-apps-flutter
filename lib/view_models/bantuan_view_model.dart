import 'dart:math';

import 'package:bantuin/cubit/my_bantuan_cubit.dart';
import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_category_model.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/bantuans/get_bantuan_by_user_response_model.dart';
import 'package:bantuin/models/bantuans/get_bantuan_response_model.dart';
import 'package:bantuin/models/bantuans/get_category_response_model.dart';
import 'package:bantuin/models/transaction_model.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/services/bantuan_service.dart';
import 'package:bantuin/services/transaction_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BantuanViewModel {
  late BuildContext context;
  late BantuanService bantuanService;
  late TransactionService transactionService;
  late UserViewModel userVm;
  late UserModel user;
  late String token;

  BantuanViewModel(BuildContext context) {
    this.bantuanService = BantuanService(context);
    this.transactionService = TransactionService(context);
    this.userVm = UserViewModel(context);
    this.user = this.userVm.getUserData();
    this.token = this.userVm.getToken();
    this.context = context;
  }

  List<BantuanModel> getMyBantuan() {
    return context.read<MyBantuanCubit>().state;
  }

  void setMyBantuan(List<BantuanModel> bantuans) {
    context.read<MyBantuanCubit>().setMyBantuan(bantuans);
  }

  Future<bool> getBantuanByUserId() async {
    var response = await bantuanService.getBantuanByUserId(
      userId: user.id,
      token: token
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Bantuans Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }

    var bantuanResponse = GetBantuanByUserModel.fromJson(response);
    this.setMyBantuan(bantuanResponse.bantuans);
    return true;
  }

  Future<bool> deleteBantuan({
    required int bantuanId
  }) async {
    var response = await bantuanService.deleteBantuan(
      token: token,
      bantuanId: bantuanId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Delete Bantuans Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }

    var fetch = await this.getBantuanByUserId();

    showGLobalAlert('success', 'Delete Bantuan Success', context);
    return true;
  }

  Future<List<BantuanCategoryModel>> getCategories() async {
    var response = await bantuanService.getBantuanCategories(token: token);
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Bantuan Categories Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var result = GetCategoryResponseModel.fromJson(response);

    return result.categories;
  }

  Future<String> createBantuan({
    required int price, categoryId,
    required String image, title, desc, location, payType,
  }) async {
    var response = await bantuanService.createBantuan(
      token: token,
      userId: user.id,
      price: price,
      categoryId: categoryId,
      image: image,
      title: title,
      desc: desc,
      location: location,
      payType: payType,
      status: "active"
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return "";
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Create Bantuan Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return "";
    }
    
    var bantuan = BantuanModel.fromJson(response.data['bantuan']);
    var payResponse = await transactionService.createTransaction(
      bantuanId: bantuan.id,
      orderId: (Random().nextInt(900) + 10).toString(),
      grossAmount: price,
      transactionType: "create_bantuan",
      paymentMethod: payType,
      token: token
    );
    if (payResponse == null) {
      showGLobalAlert('danger', 'Payment Request Error', context);
      return "";
    }

    if (payResponse.meta.code != 200) {
      showGLobalAlert('danger', 'Payment Bantuan Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return "";
    }

    await this.userVm.fetch();
    var transactionResponse = TransactionModel.fromJson(payResponse.data['transaction']);

    return transactionResponse.paymentUrl;
  }

  Future<bool> getExpensiveBantuan() async {
    var response = await bantuanService.getExpensiveBantuan(
      token: token
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Bantuans Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }

    var bantuanResponse = GetBantuanResponseModel.fromJson(response);
    return true;
  }
}