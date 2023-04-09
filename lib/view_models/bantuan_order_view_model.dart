import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/bantuan_orders/get_bantuan_order_helper_model.dart';
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

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
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

  Future<bool> acceptOrder({
    required int orderId
  }) async {
    var response = await bantuanOrderService.acceptOrder(
      token: token,
      orderId: orderId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Accept Order Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', 'Accept Order Success', context);
    return true;
  }

  Future<bool> denyOrder({
    required int orderId
  }) async {
    var response = await bantuanOrderService.denyOrder(
      token: token,
      orderId: orderId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Deny Order Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', 'Deny Order Success', context);
    return true;
  }

  Future<BantuanOrderModel?> getDetailOrderByBantuanId({
    required int bantuanId,
    String? status
  }) async {
    var response = await bantuanOrderService.getDetailOrderByBantuanId(
      token: token,
      bantuanId: bantuanId,
      status: status
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return null;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return null;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Bantuans Order Detail Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return null;
    }

    var bantuanResponse = BantuanOrderModel.fromJson(response.data[0]);
    return bantuanResponse;
  }

  Future<bool> completeOrder({
    required int orderId
  }) async {
    var response = await bantuanOrderService.completeOrder(
      token: token,
      orderId: orderId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Complete Order Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', 'Complete Order Success', context);
    return true;
  }

  Future<bool> cancelOrder({
    required int orderId,
    required String reason
  }) async {
    var response = await bantuanOrderService.cancelOrder(
      token: token,
      orderId: orderId,
      reason: reason
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Cancel Order Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', 'Cancel Order Success', context);
    return true;
  }

  Future<bool> createOrder({
    required int userId, bantuanId, helperId,
  }) async {
    var response = await bantuanOrderService.createOrder(
      token: token,
      userId: userId,
      bantuanId: bantuanId,
      helperId: helperId
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Request Help Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', 'Request Help Success', context);
    return true;
  }

  Future<List<BantuanOrderModel>> getHelperOrderByStatus({
    required int helperId,
    required String status
  }) async {
    var response = await bantuanOrderService.getHelperOrderByStatus(
      token: token,
      helperId: helperId,
      status: status
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Helper Order Data Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var orderResponse = GetBantuanOrderHelperResponseModel.fromJson(response);
    return orderResponse.orders;
  }
}