import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/bantuan_orders/get_bantuan_order_request_response.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/services/bantuan_order_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

class BantuanOrderViewModel {
  late BuildContext context;
  late BantuanOrderService bantuanOrderService;
  late UserViewModel userVm;
  late UserModel user;
  late String token;

  BantuanOrderViewModel(BuildContext context) {
    this.bantuanOrderService = BantuanOrderService(context);
    this.userVm = UserViewModel(context);
    this.user = this.userVm.getUserData();
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future<List<BantuanOrderModel>> getBantuanByUserId({
    required int bantuanId
  }) async {
    var response = await bantuanOrderService.getUserRequestBantuanOrder(
      token: token,
      bantuanId: bantuanId
    );

    print(response);

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Bantuans Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var bantuanResponse = GetBantuanOrderRequestResponse.fromJson(response);
    return bantuanResponse.bantuanOrders;
  }
}